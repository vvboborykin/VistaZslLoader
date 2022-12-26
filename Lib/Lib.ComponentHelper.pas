{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: Lib.ComponentHelper.pas
* Description: Расширение функциональности TComponent
*
* Created: 26.12.2022 11:06:21
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.ComponentHelper;

interface

uses
  System.SysUtils, System.Classes, System.Variants;

type
  /// <summary>TComponentHelper
  /// Расширение функциональности TComponent
  /// </summary>
  TComponentHelper = class helper for TComponent
  public
    /// <summary>TComponentHelper.ForEachSubcomponent
    /// Итерация по дочерним компонентам
    /// </summary>
    /// <param name="AProc"> (TProc<TComponent>) Процедура выполняемая для дочерних
    /// компонентов</param>
    /// <param name="AMinClass"> (TClass) Минимальный класс дочернего компонента</param>
    procedure ForEachSubcomponent(AProc: TProc<TComponent>; AMinClass:
        TComponentClass); overload;
    procedure ForEachSubcomponent<T: TComponent>(AProc: TProc<T>);
        overload;
    procedure ForEachSubcomponent(AProc: TProc<TComponent>); overload;
  end;

implementation

uses
  TypInfo;

procedure TComponentHelper.ForEachSubcomponent(AProc: TProc<TComponent>;
    AMinClass: TComponentClass);
begin
  for var I := 0 to ComponentCount-1 do
  begin
    var vComponent := Components[I];
    if vComponent.InheritsFrom(AMinClass) then
      AProc(vComponent);
  end;
end;

procedure TComponentHelper.ForEachSubcomponent(AProc: TProc<TComponent>);
begin
  ForEachSubcomponent(AProc, TComponent)
end;

procedure TComponentHelper.ForEachSubcomponent<T>(AProc: TProc<T>);
begin
  for var I := 0 to ComponentCount-1 do
  begin
    var vComponent := Components[I];
    if vComponent is T then
      AProc(vComponent as T);
  end;
end;


end.
