{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: Lib.RTTIHelper.pas
* Description: ������ ���������� ���������������� RTTI
*
* Created: 20.12.2022 14:37:18
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit Lib.RTTIHelper;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.RTTI, System.TypInfo;

type
  /// <summary>TRTTIUtilites
  /// ������� ���������� ���������������� RTTI
  /// </summary>
  TRTTIUtilites = class
  public
    /// <summary>TRTTIUtilites.WithContext
    /// ��������� ��������� ��� ��������� TRttiContext
    /// </summary>
    /// <param name="AProc"> (TProc<TRttiContext>) </param>
    class procedure WithContext(AProc: TProc<TRttiContext>);
    /// <summary>TRTTIUtilites.WithType
    /// ��������� ��������� ��� ��������� ���� PTypeInfo
    /// </summary>
    /// <param name="ATypeInfo"> (PTypeInfo) </param>
    /// <param name="AProc"> (TProc<TRttiType>) </param>
    class procedure WithType(ATypeInfo: PTypeInfo; AProc: TProc<TRttiType>);
    /// <summary>TRTTIUtilites.ForEachProperty
    /// ��������� ��������� ��� ������� �������� ��������� ���� PTypeInfo
    /// </summary>
    /// <param name="ATypeInfo"> (PTypeInfo) </param>
    /// <param name="AProc"> (TProc< TRttiProperty>) </param>
    class procedure ForEachProperty(ATypeInfo: PTypeInfo; AProc: TProc<
      TRttiProperty>);
    class function IsGenericType(ATypeInfo: PTypeInfo): Boolean;
    class function TryGetGenericClassName(ATypeInfo: PTypeInfo; out AResult:
      string): Boolean;
  end;

implementation

class procedure TRTTIUtilites.ForEachProperty(ATypeInfo: PTypeInfo; AProc: TProc
  <TRttiProperty>);
begin
  WIthType(ATypeInfo,
    procedure(AType: TRttiType)
    begin
      for var vProp in AType.GetProperties() do
        AProc(vProp);
    end);
end;

class function TRTTIUtilites.IsGenericType(ATypeInfo: PTypeInfo): Boolean;
begin
  var vResult := (ATypeInfo <> nil);
  WithType(ATypeInfo,
    procedure(AType: TRTTIType)
    begin
      vResult := vResult and AType.IsInstance and AType.Name.Contains('<') and
        AType.Name.Contains('>');
    end);
end;

class function TRTTIUtilites.TryGetGenericClassName(ATypeInfo: PTypeInfo; out
  AResult: string): Boolean;
begin
  var vClassName := '';
  Result := IsGenericType(ATypeInfo);
  if Result then
  begin
    WithType(ATypeInfo,
      procedure(AType: TRTTIType)
      begin
        vClassName := AType.Name;
      end);
  end;
  AResult := vClassName;
end;

class procedure TRTTIUtilites.WithContext(AProc: TProc<TRttiContext>);
begin
  var vContext := TRttiContext.Create;
  try
    AProc(vContext);
  finally
    vContext.Free;
  end;
end;

class procedure TRTTIUtilites.WithType(ATypeInfo: PTypeInfo; AProc: TProc<
  TRttiType>);
begin
  WithContext(
    procedure(AContext: TRTTIContext)
    begin
      var vType := AContext.GetType(ATypeInfo);
      AProc(vType);
    end)
end;

end.

