{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: AppOptionsEditor.pas
* Description: Редактор параметров работы приложения
*
* Created: 26.12.2022 12:01:54
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit AppOptionsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls,  System.StrUtils, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, cxContainer, cxEdit, dxLayoutcxEditAdapters,
  dxLayoutControlAdapters, Vcl.Menus, dxLayoutContainer, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, cxButtons, Data.DB, cxClasses, cxMaskEdit,
  cxSpinEdit, cxDBEdit, cxTextEdit, dxLayoutControl, dxSkinBasic;

type
  TAppOptionsEditorForm = class(TForm)
    aclMain: TActionList;
    layRoot: TdxLayoutGroup;
    lacMain: TdxLayoutControl;
    dsOptions: TDataSource;
    cxDBTextEdit1: TcxDBTextEdit;
    dxLayoutItem1: TdxLayoutItem;
    cxDBTextEdit2: TcxDBTextEdit;
    dxLayoutItem2: TdxLayoutItem;
    cxDBTextEdit3: TcxDBTextEdit;
    dxLayoutItem3: TdxLayoutItem;
    cxDBTextEdit4: TcxDBTextEdit;
    dxLayoutItem4: TdxLayoutItem;
    cxDBTextEdit5: TcxDBTextEdit;
    dxLayoutItem5: TdxLayoutItem;
    cxDBTextEdit6: TcxDBTextEdit;
    dxLayoutItem6: TdxLayoutItem;
    cxDBTextEdit7: TcxDBTextEdit;
    dxLayoutItem7: TdxLayoutItem;
    cxDBSpinEdit1: TcxDBSpinEdit;
    dxLayoutItem8: TdxLayoutItem;
    cxDBSpinEdit2: TcxDBSpinEdit;
    dxLayoutItem9: TdxLayoutItem;
    layButtons: TdxLayoutGroup;
    btnOk: TcxButton;
    layOk: TdxLayoutItem;
    btnCancel: TcxButton;
    layCancel: TdxLayoutItem;
    actOk: TAction;
    actCancel: TAction;
    dxLayoutSeparatorItem1: TdxLayoutSeparatorItem;
    procedure FormCreate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure cxDBTextEdit1Exit(Sender: TObject);
    procedure cxDBTextEdit1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  strict private
    function FindFieldControl(AField: TField): TcxCustomEdit;
    procedure ResetAllErrorMarkers;
    procedure SetErrorMarkersForInvalidFields(AErrors: TStrings);
    procedure SetErrorText(AField: TField; AText: string);
    function Validate: Boolean;
  public
  end;

implementation

uses
  AppOptionsModule, Lib.ComponentHelper, TypInfo, DbLib.DataSetHelper;

resourcestring
  SPleaseFixErrors = 'Пожалуйста исправьте ошибки';

const
  SDataBinding = 'DataBinding';
  cErrorBackgroundColor = clYellow;

{$R *.dfm}

procedure TAppOptionsEditorForm.FormCreate(Sender: TObject);
begin
  Validate;
end;

procedure TAppOptionsEditorForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TAppOptionsEditorForm.actOkExecute(Sender: TObject);
begin
  if not Validate then
  begin
    ModalResult := mrNone;
    ShowMessage(SPleaseFixErrors);
  end
  else
    dsOptions.DataSet.PostIfNeeded();
end;

procedure TAppOptionsEditorForm.cxDBTextEdit1Exit(Sender: TObject);
begin
  Validate;
end;

procedure TAppOptionsEditorForm.cxDBTextEdit1PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := (Sender as TcxCustomEdit).Hint;
  Error := ErrorText <> '';
end;

function TAppOptionsEditorForm.FindFieldControl(AField: TField): TcxCustomEdit;
begin
  var vResult: TcxCustomEdit := nil;
  Self.ForEachSubcomponent<TcxCustomEdit>(
    procedure(AEdit: TcxCustomEdit)
    begin
      if (vResult = nil) and IsPublishedProp(AEdit, SDataBinding) then
      begin
        with GetObjectProp(AEdit, SDataBinding) as TcxDBEditDataBinding do
        begin
          if Field = AField then
            vResult := AEdit;
        end;
      end;
    end);
  Result := vResult;
end;

procedure TAppOptionsEditorForm.ResetAllErrorMarkers;
begin
  Self.ForEachSubcomponent<TcxCustomEdit>(
    procedure(AEdit: TcxCustomEdit)
    begin
      if IsPublishedProp(AEdit, SDataBinding) then
      begin
        AEdit.Hint := '';
        AEdit.ValidateEdit;
        AEdit.Style.Color := clWindow;
      end;
    end);
end;

procedure TAppOptionsEditorForm.SetErrorMarkersForInvalidFields(AErrors:
  TStrings);
begin
  for var I := 0 to AErrors.Count-1 do
    SetErrorText(AErrors.Objects[I] as TField, AErrors[I]);
end;

procedure TAppOptionsEditorForm.SetErrorText(AField: TField; AText: string);
begin
  var vControl: TcxCustomEdit := FindFieldControl(AField);
  if vControl <> nil then
  begin
    vControl.Hint := vControl.Hint + IfThen(vControl.Hint = '', '', #13) + AText;
    vControl.ValidateEdit;
    vControl.Style.Color := cErrorBackgroundColor;
  end;
end;

function TAppOptionsEditorForm.Validate: Boolean;
begin
  var vErrors := TStringList.Create;
  AppOptions.Validate(vErrors);
  Result := vErrors.Count = 0;
  if not Result then
  begin
    ResetAllErrorMarkers();
    SetErrorMarkersForInvalidFields(vErrors)
  end;
  vErrors.Free;
end;

end.

