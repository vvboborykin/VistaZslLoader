{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: Lib.Container.pas
* Description: Контейнер dependency injection
*
* Created: 27.12.2022 11:22:08
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.Container;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.Generics.Collections,
  TypInfo;

type
  IRegistryEntity = interface
    ['{97FF90CA-19D6-4370-B15A-879C4807FA43}']
    function CreateObject: IInterface; stdcall;
    function GetIID: TGUID; stdcall;
    procedure SetIID(const Value: TGUID); stdcall;
    property IID: TGUID read GetIID write SetIID;
  end;

  TRegistryEntityBase = class abstract(TInterfacedObject, IRegistryEntity)
  strict private
    FIID: TGUID;
    FName: string;
    function GetIID: TGUID; stdcall;
    procedure SetIID(const Value: TGUID); stdcall;
    procedure SetName(const Value: string);
  strict protected
    function CreateObject: IInterface; virtual; stdcall; abstract;
  public
    constructor Create(const AIID: TGUID; const AName: string);
    property IID: TGUID read GetIID write SetIID;
    property Name: string read FName write SetName;
  end;

  TClassRegistryEntity = class(TRegistryEntityBase)
  private
    FImplementorClass: TClass;
    procedure SetImplementorClass(const Value: TClass);
  strict protected
    function CreateObject: IInterface; override; stdcall;
  public
    constructor Create(const AIID: TGUID; const AName: string; AImplementorClass:
      TClass);
    property ImplementorClass: TClass read FImplementorClass write
      SetImplementorClass;
  end;

  TFactoryMethodRegistryEntity = class(TRegistryEntityBase)
  private
    FFactoryMethod: TFunc<IInterface>;
  strict protected
    function CreateObject: IInterface; override; export;
  public
    constructor Create(const AIID: TGUID; const AName: string; AFactoryMethod:
      TFunc<IInterface>);
  end;

  EUnregisteredInterface = class(Exception)
  public
    constructor Create(const AIID: TGUID; const AName: string);
  end;

  EFactoryMethodNotAssigned = class(Exception)
  public
    constructor Create(const AIID: TGUID; const AName: string);
  end;

  /// <summary>TContainer
  /// Контейнер dependency injection
  /// </summary>
  TContainer = class
  strict private
    FRegistry: TDictionary<string, IRegistryEntity>;
  protected
    function GetRegistryKey<TInterface: IInterface>(AName: string = ''): string;
      overload;
    function GetRegistryKey(AIID: TGUID; AName: string = ''): string; overload;
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure RegisterTransient<TInterface: IInterface; TImplementor: class,
      constructor>(AName: string = ''); overload;
    procedure RegisterTransient(AEntity: IRegistryEntity; AName: string = '');
      overload;
    procedure RegisterTransient<TInterface: IInterface>(AFactoryMethod: TFunc<
        IInterface>; AName: string = ''); overload;
    function ResolveTransient<TInterface: IInterface>(AName: string = ''):
      TInterface;
  end;

  /// <summary>procedure GlobalContainer
  /// Глобальный экземпляр контейнера DI
  /// </summary>
  /// <returns> TContainer
  /// </returns>
  function GlobalContainer(): TContainer;

implementation

uses
  Lib.RTTIHelper, Lib.Singleton;

resourcestring
  SFactoryMethodNotAssigned =
    'Не задан фабричный метод для интерфейса "%s" имени "%s"';
  SUnregisteregInterface =
    'Запрошен незарегистрированный интерфейс "%s" имя "%s"';
  SInterfaceNotSupportedByClass = 'Интерфейс %s не поддерживается классом %s';

type
  TContainerSingletor = class(TSingleton<TContainer>)
  end;

function GlobalContainer(): TContainer;
begin
  Result := TContainerSingletor.Instance;
end;



constructor TContainer.Create;
begin
  inherited Create;
  FRegistry := TDictionary<string, IRegistryEntity>.Create();
end;

destructor TContainer.Destroy;
begin
  FRegistry.Free;
  inherited Destroy;
end;

function TContainer.GetRegistryKey(AIID: TGUID; AName: string = ''): string;
begin
  Result := AIID.ToString() + '.' + AName;
end;

function TContainer.GetRegistryKey<TInterface>(AName: string = ''): string;
begin
  Result := GetRegistryKey(TRTTIUtilites.GetInterfaceGuid<TInterface>, AName);
end;

procedure TContainer.RegisterTransient(AEntity: IRegistryEntity; AName: string =
  '');
begin
  FRegistry.AddOrSetValue(GetRegistryKey(AEntity.IID, AName), AEntity);
end;

{ TContainer }

procedure TContainer.RegisterTransient<TInterface, TImplementor>(AName: string =
  '');
begin
  var vEntity: IRegistryEntity := TClassRegistryEntity.Create(TRTTIUtilites.GetInterfaceGuid
    <TInterface>(), AName, TRTTIUtilites.GetClassType<TImplementor>());

  RegisterTransient(vEntity, AName);
end;

procedure TContainer.RegisterTransient<TInterface>(AFactoryMethod: TFunc<
    IInterface>; AName: string = '');
begin
  RegisterTransient(TFactoryMethodRegistryEntity
    .Create(TRTTIUtilites.GetInterfaceGuid<TInterface>, AName, AFactoryMethod));
end;

function TContainer.ResolveTransient<TInterface>(AName: string = ''): TInterface;
begin
  var vKey := GetRegistryKey<TInterface>(AName);
  if FRegistry.ContainsKey(vKey) then
  begin
    var vEntity := FRegistry[vKey];
    Supports(vEntity.CreateObject,
      TRTTIUtilites.GetInterfaceGuid<TInterface>(),
      Result);
  end
  else
    raise EUnregisteredInterface.Create(TRTTIUtilites.GetInterfaceGuid<
      TInterface>, AName);
end;

constructor TClassRegistryEntity.Create(const AIID: TGUID; const AName: string;
  AImplementorClass: TClass);
begin
  inherited Create(AIID, AName);
  FImplementorClass := AImplementorClass;
end;

function TClassRegistryEntity.CreateObject: IInterface;
begin
  if not Supports(ImplementorClass.Create, IID, Result) then
    raise ENotSupportedException.CreateFmt(SInterfaceNotSupportedByClass,
      [IID.ToString, FImplementorClass.QualifiedClassName]);
end;

procedure TClassRegistryEntity.SetImplementorClass(const Value: TClass);
begin
  if FImplementorClass <> Value then
  begin
    FImplementorClass := Value;
  end;
end;

constructor TRegistryEntityBase.Create(const AIID: TGUID; const AName: string);
begin
  inherited Create;
  FIID := AIID;
  FName := AName;
end;

function TRegistryEntityBase.GetIID: TGUID;
begin
  Result := FIID;
end;

procedure TRegistryEntityBase.SetIID(const Value: TGUID);
begin
  if FIID <> Value then
  begin
    FIID := Value;
  end;
end;

procedure TRegistryEntityBase.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
  end;
end;

constructor EUnregisteredInterface.Create(const AIID: TGUID; const AName: string);
begin
  inherited CreateFmt(SUnregisteregInterface, [AIID.ToString(), AName]);
end;

constructor TFactoryMethodRegistryEntity.Create(const AIID: TGUID; const AName:
  string; AFactoryMethod: TFunc<IInterface>);
begin
  inherited Create(AIID, AName);
  FFactoryMethod := AFactoryMethod;
  if not Assigned(FFactoryMethod) then
    raise EFactoryMethodNotAssigned.Create(AIID, AName);
end;

function TFactoryMethodRegistryEntity.CreateObject: IInterface;
begin
  Result := FFactoryMethod();
end;

{ EFactoryMethodNotAssigned }

constructor EFactoryMethodNotAssigned.Create(const AIID: TGUID; const AName:
  string);
begin
  inherited CreateFmt(SFactoryMethodNotAssigned, [AIID.ToString(), AName]);
end;

end.

