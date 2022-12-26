{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: Lib.StreamHelper.pas
* Description: Расширение функциональности TStream
*
* Created: 21.12.2022 14:02:16
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.StreamHelper;

interface

uses
  System.SysUtils, System.Classes, System.Variants;

type
  /// <summary>TStreamHelper
  /// Расширение функциональности TStream
  /// </summary>
  TStreamHelper = class helper for TStream
  public
    function ReadString(AEncoding: TEncoding = nil): string;
  end;

implementation

function TStreamHelper.ReadString(AEncoding: TEncoding = nil): string;
var
  Bytes: TArray<Byte>;
begin
  Result := '';
  var vRestCount := Size - Position;

  if vRestCount > 0 then
  begin
    SetLength(Bytes, vRestCount);
    Read(Bytes[0], vRestCount);
  end;

  if AEncoding = nil then
    AEncoding := TEncoding.Default;

  Result := TEncoding.ASCII.GetString(Bytes);
end;

end.

