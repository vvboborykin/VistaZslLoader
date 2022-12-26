unit Lib.Environment;

interface
uses
  System.SysUtils, System.Classes, System.Variants, Lib.Singleton;

type
  TEnvironment = class
  public
    function GetComputerName: string;
    function GetUserName: string;
    function GetUserDomainName: string;
    function GetDomainName: string;
  end;

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
