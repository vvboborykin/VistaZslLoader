{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: Lib.Environment.pas
* Description: ������ �������� ��������� ���������
*
* Created: 26.12.2022 14:35:37
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit Lib.Environment;

interface
uses
  System.SysUtils, System.Classes, System.Variants, Lib.Singleton;

type
  /// <summary>TEnvironment
  /// ������ �������� ��������� ���������
  /// </summary>
  TEnvironment = class
  public
    /// <summary>TEnvironment.GetComputerName
    /// �������� ��� ���������� �� ������� ����������� ���������
    /// </summary>
    /// <returns> string
    /// </returns>
    function GetComputerName: string;
    /// <summary>TEnvironment.GetUserName
    /// �������� ��� ������������ ������������ �������
    /// </summary>
    /// <returns> string
    /// </returns>
    function GetUserName: string;
    /// <summary>TEnvironment.GetUserDomainName
    /// �������� �������� ��� �������� ������������ ������������ ������� � ����
    /// UserName@Domain
    /// </summary>
    /// <returns> string
    /// </returns>
    function GetUserDomainName: string;
    /// <summary>TEnvironment.GetDomainName
    /// �������� ��� ������ �������� ������������ ������������ �������
    /// </summary>
    /// <returns> string
    /// </returns>
    function GetDomainName: string;
  end;

  /// <summary>procedure EnvironmentService
  /// �������� ���������� ������ ������ ���������
  /// </summary>
  /// <returns> TEnvironment
  /// </returns>
  function EnvironmentService: TEnvironment;

implementation

uses
  System.StrUtils
{$IFDEF MSWINDOWS}
  ,WinApi.Windows
{$ENDIF}
;

type
  TEnvironmentService = class(TSingleton<TEnvironment>)
  end;

function EnvironmentService: TEnvironment;
begin
  Result := TEnvironmentService.Instance;
end;

function TEnvironment.GetComputerName: string;
begin
{$IFDEF MSWINDOWS}
  Result := GetEnvironmentVariable('COMPUTERNAME');
{$ENDIF}
end;

function TEnvironment.GetDomainName: string;
begin
{$IFDEF MSWINDOWS}
  Result := GetEnvironmentVariable('USERDOMAIN');
{$ENDIF}
end;

function TEnvironment.GetUserDomainName: string;
begin
  Result := GetDomainName + '@' +  GetUserName;
end;

function TEnvironment.GetUserName: string;
begin
{$IFDEF MSWINDOWS}
  Result := GetEnvironmentVariable('USERNAME');
{$ENDIF}
end;

end.
