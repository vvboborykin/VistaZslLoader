{*******************************************************
* Project: VistaBillExtractor
* Unit: NullableUnit.pas
* Description: Обнуляемое хранилище скалярного значения
* См. https://stackoverflow.com/questions/36681676/delphi-and-nullable-types
*
* Created: 16.12.2022 16:09:04
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.Nullable;

interface

uses
  Classes, SysUtils;

type
  /// <summary>TNullable
  /// Обнуляемое хранилище скалярного значения
  /// </summary>
  TNullable<T> = record
  private
    FHasValue: Boolean;
    FValue: T;
    function GetValue: T;
    procedure SetValue(AValue: T);
  public
    /// <summary>TNullable<>.Clear
    /// Обнулить значение
    /// </summary>
    procedure Clear;
    /// <summary>TNullable<>.HasValue
    /// Значение присвоено
    /// </summary>
    /// type:Boolean
    property HasValue: Boolean read FHasValue;
    /// <summary>TNullable<>.Value Хранимое значение (при обнуленном состоянии
    /// выбрасывает исключение EVariableHasNoValue)
    /// </summary> type:T
    property Value: T read GetValue write SetValue;
    class operator Implicit(A: T): TNullable<T>;
    /// <summary>TNullable<>.Implicit
    /// Оператор присвоения указателя. При присваиваемом значении не равном nil
    /// выбрасывает исключение EPointerValueNotAllowed.
    /// </summary>
    /// <returns> TNullable<T>
    /// </returns>
    /// <param name="A"> (Pointer) </param>
    class operator Implicit(A: Pointer): TNullable<T>;
  end;

  EVariableHasNoValue = class(Exception)
  public
    constructor Create;
  end;

  EPointerValueNotAllowed = class(Exception)
  public
    constructor Create;
  end;

implementation

resourcestring
  SVariableHasNoValue = 'У TNullable переменной нет значения';
  SPointerValueNotAllowed =
    'Непустой указатель нельзя присвоить TNullable переменной';


{ TNullable }

function TNullable<T>.GetValue: T;
begin
  if FHasValue then
    Result := FValue
  else
    raise EVariableHasNoValue.Create();
end;

procedure TNullable<T>.SetValue(AValue: T);
begin
  FValue := AValue;
  FHasValue := True;
end;

procedure TNullable<T>.Clear;
begin
  FHasValue := False;
end;

class operator TNullable<T>.Implicit(A: T): TNullable<T>;
begin
  Result.Value := A;
end;

class operator TNullable<T>.Implicit(A: Pointer): TNullable<T>;
begin
  if A = nil then
    Result.Clear
  else
    raise EPointerValueNotAllowed.Create();
end;

constructor EVariableHasNoValue.Create;
begin
  inherited Create(SVariableHasNoValue);
end;

constructor EPointerValueNotAllowed.Create;
begin
  inherited Create(SPointerValueNotAllowed);
end;

end.

