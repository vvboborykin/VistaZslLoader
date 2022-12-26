{*******************************************************
* Project: VistaZslLoader.Console
* Unit: SingletonUnit.pas
* Description: Паттерн "одиночка"
*
* Created: 19.12.2022 13:04:25
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.Singleton;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.SyncObjs;

type
  /// <summary>TSingleton
  /// Паттерн "одиночка"
  /// </summary>
  TSingleton<T: class, constructor> = class(TObject)
  strict private
    class var
      FLock: TCriticalSection;
    class var
      FInstance: T;
    class destructor Destroy;
    class constructor Create;
  public
    class function Instance: T;
    class procedure UsingInstanceLock(AProc: TProc<T>);
  end;

implementation

class constructor TSingleton<T>.Create;
begin
  FLock := TCriticalSection.Create;
end;

class destructor TSingleton<T>.Destroy;
begin
  UsingInstanceLock(
    procedure(AInstance: T)
    begin
      if FInstance <> nil then
        FreeAndNil(FInstance);
    end);
  FLock.Free;
end;

class function TSingleton<T>.Instance: T;
begin
  if FInstance = nil then
    FInstance := T.Create();
  Result := FInstance;
end;

class procedure TSingleton<T>.UsingInstanceLock(AProc: TProc<T>);
begin
  FLock.Enter;
  try
    AProc(FInstance);
  finally
    FLock.Leave;
  end;
end;

end.

