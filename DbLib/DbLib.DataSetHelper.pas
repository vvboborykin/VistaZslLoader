{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: DataSetHelper.pas
* Description: ���������� ���������������� TDataSet
*
* Created: 24.12.2022 11:09:55
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit DbLib.DataSetHelper;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Data.DB;

type
  /// <summary>TDataSetHelper
  /// ���������� ���������������� TDataSet
  /// </summary>
  TDataSetHelper = class helper for TDataSet
  public
    /// <summary>TDataSetHelper.ForEachRecord
    /// �������� �� ������� DataSet
    /// </summary>
    /// <param name="AProc"> (TProc) ��������� ����������� ��� �������</param>
    /// <param name="ADisableControls"> (Boolean) ��������� ���������� ����������
    /// ���������� ������������ � DataSet</param>
    /// <param name="AFilter"> (TFunc<Boolean>) �������� �����������������
    /// �������������� ������</param>
    /// <param name="ABreaker"> (TFunc<Boolean>) �������� ���������� ��������</param>
    procedure ForEachRecord(AProc: TProc; ADisableControls: Boolean = True;
        AFilter: TFunc<Boolean> = nil; ABreaker: TFunc<Boolean> = nil);
    /// <summary>TDataSetHelper.ForEachField
    /// �������� �� ����� DataSet
    /// </summary>
    /// <param name="AProc"> (TProc<TField>) ��������� ����������� ��� �����</param>
    /// <param name="AFilter"> (TFunc<TField, Boolean>) �������� �����������������
    /// �������������� ����</param>
    /// <param name="ABreaker"> (TFunc<TField, Boolean>) �������� ����������
    /// ��������</param>
    procedure ForEachField(AProc: TProc<TField>; AFilter: TFunc<TField, Boolean> =
        nil; ABreaker: TFunc<TField, Boolean> = nil);
    /// <summary>TDataSetHelper.PostIfNeeded
    /// ������������� ��������� �  DataSet ���� �� � ������ ������� ��� ��������������
    /// </summary>
    procedure PostIfNeeded;
    /// <summary>TDataSetHelper.EditIfNeeded
    /// ��������� DataSet � ����� �������������� ���� �� ��� �� ��������� � ���
    /// </summary>
    procedure EditIfNeeded;
  end;

  EDataSetIsNotActive = class(Exception)
  public
    constructor Create;
  end;

implementation

resourcestring
  SErrDataSetIsNotActive = 'DataSet �� �������';
  SErrForEachRecordAProcIsNil = 'TDataSetHelper.ForEachRecord AProc �� �����';

procedure TDataSetHelper.EditIfNeeded;
begin
  if State = dsBrowse then
    Edit;
end;

procedure TDataSetHelper.ForEachField(AProc: TProc<TField>; AFilter:
    TFunc<TField, Boolean> = nil; ABreaker: TFunc<TField, Boolean> = nil);
begin
  if not Assigned(AProc) then
    raise EArgumentException.Create(SErrForEachRecordAProcIsNil);

  if not Active then
    raise EDataSetIsNotActive.Create();

  for var I := 0 to FieldCount-1 do
  begin
    var vField := Fields[I];

    if not Assigned(AFilter) or AFilter(vField) then
      AProc(vField);

    if Assigned(ABreaker) and ABreaker(vField) then
      Break;
    Next;
  end;
end;

procedure TDataSetHelper.ForEachRecord(AProc: TProc; ADisableControls: Boolean
    = True; AFilter: TFunc<Boolean> = nil; ABreaker: TFunc<Boolean> = nil);
begin
  if not Assigned(AProc) then
    raise EArgumentException.Create(SErrForEachRecordAProcIsNil);

  if not Active then
    raise EDataSetIsNotActive.Create();

  var vRecno := RecNo;

  if ADisableControls then
    DisableControls;

  try
    First;
    while not Eof do
    begin
      if not Assigned(AFilter) or AFilter() then
        AProc();

      if Assigned(ABreaker) and ABreaker() then
        Break;
      Next;
    end;
  finally
    if (vRecno >= 0) and (vRecno < RecordCount) then
      RecNo := vRecno;

    if ADisableControls then
      EnableControls;
  end;
end;

procedure TDataSetHelper.PostIfNeeded;
begin
  if State <> dsBrowse then
    Post;
end;

constructor EDataSetIsNotActive.Create;
begin
  inherited Create(SErrDataSetIsNotActive);
end;

end.

