{*******************************************************
* Project: VistaZslLoader.Console
* Unit: CommandLineServiceUnit.pas
* Description: Служба параметров командной строки
*
* Created: 19.12.2022 13:31:28
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.CommandLineService;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.Generics.Collections,
  System.RegularExpressions;

type
  /// <summary>TCommandLineService
  /// Служба параметров командной строки
  /// </summary>
  TCommandLineService = class
  strict private
    FValues: TDictionary<string, string>;
    procedure ParseParameters;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>TCommandLineService.GetValue
    /// Получить значение параметра по имени
    /// </summary>
    /// <returns> String
    /// </returns>
    /// <param name="AName"> (string) Имя параметра</param>
    /// <param name="ADefaultValue"> (string) Значение возвращаемое если параметр не
    /// задан</param>
    function GetValue(AName, ADefaultValue: string): String;
    /// <summary>TCommandLineService.SwitchExists
    /// Определить задан ли в командной строке ключ
    /// </summary>
    /// <returns> Boolean
    /// </returns>
    /// <param name="AName"> (string) Имя ключа</param>
    function SwitchExists(AName: string): Boolean;
    /// <summary>TCommandLineService.TryGetValue
    /// Попытаться получить значение параметра
    /// </summary>
    /// <returns> Boolean
    /// True при найденном параметре
    /// </returns>
    /// <param name="AParameterName"> (string) Имя параметра</param>
    /// <param name="AValue"> (string) Возвращаемое значение параметра при успешном
    /// исходе</param>
    function TryGetValue(AParameterName: string; var AValue: string): Boolean;
    /// <summary>TCommandLineService.ValueExists
    /// Проверить существует ли значение параметра
    /// </summary>
    /// <returns> Boolean
    /// </returns>
    /// <param name="AParameterName"> (string) Имя параметра</param>
    function ValueExists(AParameterName: string): Boolean;


  end;

implementation

const
  SParameterExpr = '(\S+)\s*\=\s*\"?(.*)\"?';

constructor TCommandLineService.Create;
begin
  inherited Create;
  FValues := TDictionary<string, string>.Create();
  ParseParameters();
end;

destructor TCommandLineService.Destroy;
begin
  FValues.Free;
  inherited Destroy;
end;

function TCommandLineService.GetValue(AName, ADefaultValue: string): String;
begin
  if not TryGetValue(AName, Result) then
    Result := ADefaultValue;
end;

procedure TCommandLineService.ParseParameters;
var
  I: Integer;
begin
  for I := 1 to ParamCount do
  begin
    var vMatch := TRegEx.Match(ParamStr(I), SParameterExpr);
    if vMatch.Success then
      FValues.AddOrSetValue(vMatch.Groups[1].Value, vMatch.Groups[2].Value);
  end;
end;

function TCommandLineService.SwitchExists(AName: string): Boolean;
begin
  Result := FindCmdLineSwitch(AName);
end;

function TCommandLineService.TryGetValue(AParameterName: string; var AValue:
  string): Boolean;
begin
  Result := FValues.TryGetValue(AParameterName, AValue);
end;

function TCommandLineService.ValueExists(AParameterName: string): Boolean;
begin
  Result := FValues.ContainsKey(AParameterName);
end;

end.

