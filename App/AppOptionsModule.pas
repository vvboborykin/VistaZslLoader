{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: AppOptionsModule.pas
* Description: Параметры работы приложения
*
* Created: 26.12.2022 11:30:52
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit AppOptionsModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.IOUtils, Lib.CommandLineService;

type
  /// <summary>TAppOptions
  /// Параметры работы приложения
  /// </summary>
  TAppOptions = class(TDataModule)
    conMain: TFDConnection;
    VistaOptions: TFDQuery;
    VistaOptionsId: TFDAutoIncField;
    VistaOptionsServer: TWideStringField;
    VistaOptionsDbUserName: TWideStringField;
    VistaOptionsDbPassword: TWideStringField;
    VistaOptionsDatabase: TWideStringField;
    VistaOptionsAppUserName: TWideStringField;
    VistaOptionsAppPassword: TWideStringField;
    VistaOptionsSourceDir: TWideStringField;
    VistaOptionsSourceFilesCheckSum: TWideStringField;
    VistaOptionsImportBatchSize: TIntegerField;
    VistaOptionsLastImportFile: TWideStringField;
    VistaOptionsLastImportRecno: TIntegerField;
    VistaOptionsUpdateBatchSize: TIntegerField;
    VistaOptionsLastUpdatedRecNo: TIntegerField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure conMainBeforeConnect(Sender: TObject);
    procedure VistaOptionsAfterOpen(DataSet: TDataSet);
    procedure VistaOptionsNewRecord(DataSet: TDataSet);
  strict private
    procedure CheckFieldForNotNull(AField: TField; AErrors: TStrings);
    function GetAppDatabaseFileName: string;
    function GetAppDataDir: string;
    function GetOptionsDbFileName: string;
    function GetOptionValue(const AName: string): Variant;
    function GetUserDatabaseFileName: string;
  private
    function GetAppPassword: Variant;
    function GetAppUserName: Variant;
    function GetDatabase: Variant;
    function GetDbPassword: Variant;
    function GetDbUserName: Variant;
    function GetId: Variant;
    function GetImportBatchSize: Variant;
    function GetLastImportFile: Variant;
    function GetLastImportRecno: Variant;
    function GetLastUpdatedRecNo: Variant;
    function GetServer: Variant;
    function GetSourceDir: Variant;
    function GetSourceFilesCheckSum: Variant;
    function GetUpdateBatchSize: Variant;
  strict protected
    FCommandLine: TCommandLineService;
  public
    property Id: Variant read GetId;
    property Server: Variant read GetServer;
    property DbUserName: Variant read GetDbUserName;
    property DbPassword: Variant read GetDbPassword;
    property Database: Variant read GetDatabase;
    property AppUserName: Variant read GetAppUserName;
    property AppPassword: Variant read GetAppPassword;
    property SourceDir: Variant read GetSourceDir;
    property SourceFilesCheckSum: Variant read GetSourceFilesCheckSum;
    property ImportBatchSize: Variant read GetImportBatchSize;
    property LastImportFile: Variant read GetLastImportFile;
    property LastImportRecno: Variant read GetLastImportRecno;
    property UpdateBatchSize: Variant read GetUpdateBatchSize;
    property LastUpdatedRecNo: Variant read GetLastUpdatedRecNo;
    procedure Validate(AErrors: TStrings);
    procedure ValidateUsingCommandLine(AErrors: TStrings);
  end;

var
  AppOptions: TAppOptions;

implementation

const
  SDefaultDatabaseName = 's11';
  SDefaultAppUserName = 'Админ';
  cDefaultUpdateBatchSize = 50000;
  cDefaultImportBatchSize = 50000;
  cDefaultDbServerName = 'MySqlServer';

resourcestring
  SSourceDirNotExists =
    'Каталог "%s" со списками застрахованных лиц не существует';
  SFieldShoudNotBeEmpty = 'Параметр "%s" не должен быть пустым';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAppOptions.DataModuleDestroy(Sender: TObject);
begin
  FCommandLine.Free;
end;

procedure TAppOptions.DataModuleCreate(Sender: TObject);
begin
  FCommandLine := TCommandLineService.Create;
  VistaOptions.Open();
end;

procedure TAppOptions.CheckFieldForNotNull(AField: TField; AErrors: TStrings);
begin
  if AField <> nil then
  begin
    if AField.AsString = '' then
    begin
      var vMessage := Format(SFieldShoudNotBeEmpty, [AField.DisplayLabel]);
      AErrors.AddObject(vMessage, AField);
    end;
  end;
end;

procedure TAppOptions.conMainBeforeConnect(Sender: TObject);
begin
  if FileExists(GetUserDatabaseFileName) then
    conMain.Params.Database := GetUserDatabaseFileName
  else
  if FileExists(GetAppDatabaseFileName) then
    conMain.Params.Database := GetAppDatabaseFileName
  else;
end;

function TAppOptions.GetAppDatabaseFileName: string;
begin
  Result := TPath.Combine(GetAppDataDir,
    GetOptionsDbFileName);
end;

function TAppOptions.GetAppDataDir: string;
begin
  Result := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'Data');
end;

function TAppOptions.GetAppPassword: Variant;
begin
  Result := GetOptionValue('AppPassword');
end;

function TAppOptions.GetAppUserName: Variant;
begin
  Result := GetOptionValue('AppUserName');
end;

function TAppOptions.GetDatabase: Variant;
begin
  Result := GetOptionValue('Database');
end;

function TAppOptions.GetDbPassword: Variant;
begin
  Result := GetOptionValue('DbPassword');
end;

function TAppOptions.GetDbUserName: Variant;
begin
  Result := GetOptionValue('DbUserName');
end;

function TAppOptions.GetId: Variant;
begin
  Result := GetOptionValue('Get');
end;

function TAppOptions.GetImportBatchSize: Variant;
begin
  Result := GetOptionValue('ImportBatchSize');
end;

function TAppOptions.GetLastImportFile: Variant;
begin
  Result := GetOptionValue('LastImportFile');
end;

function TAppOptions.GetLastImportRecno: Variant;
begin
  Result := GetOptionValue('LastImportRecno');
end;

function TAppOptions.GetLastUpdatedRecNo: Variant;
begin
  Result := GetOptionValue('LastUpdatedRecno');
end;

function TAppOptions.GetOptionsDbFileName: string;
begin
  Result := TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.db';
end;

function TAppOptions.GetOptionValue(const AName: string): Variant;
begin
  Result := VistaOptions[AName];
  if FCommandLine.ValueExists(AName) then
    Result := FCommandLine.GetValue(AName, '');
end;

function TAppOptions.GetServer: Variant;
begin
  Result := GetOptionValue('Server');
end;

function TAppOptions.GetSourceDir: Variant;
begin
  Result := GetOptionValue('SourceDir');
end;

function TAppOptions.GetSourceFilesCheckSum: Variant;
begin
  Result := GetOptionValue('SourceFilesCheckSum');
end;

function TAppOptions.GetUpdateBatchSize: Variant;
begin
  Result := GetOptionValue('UpdateBatchSize');
end;

function TAppOptions.GetUserDatabaseFileName: string;
begin
  Result := TPath.Combine(TPath.GetHomePath, GetOptionsDbFileName);
end;

procedure TAppOptions.Validate(AErrors: TStrings);
begin
  CheckFieldForNotNull(VistaOptionsServer, AErrors);
  CheckFieldForNotNull(VistaOptionsDbUserName, AErrors);
  CheckFieldForNotNull(VistaOptionsDbPassword, AErrors);
  CheckFieldForNotNull(VistaOptionsDatabase, AErrors);
  CheckFieldForNotNull(VistaOptionsAppUserName, AErrors);
  CheckFieldForNotNull(VistaOptionsSourceDir, AErrors);

  if not TDirectory.Exists(VistaOptionsSourceDir.AsString) then
    AErrors.AddObject(Format(SSourceDirNotExists, [VistaOptionsSourceDir.AsString]),
      VistaOptionsSourceDir);
end;

procedure TAppOptions.ValidateUsingCommandLine(AErrors: TStrings);
begin
  Validate(AErrors);
  var I := 0;
  while I < AErrors.Count do
  begin
    var vField: TField := AErrors.Objects[I] as TField;
    if FCommandLine.ValueExists(vField.FieldName) then
    begin
      AErrors.Delete(I);
      Dec(I);
    end;
    Inc(I);
  end;
end;

procedure TAppOptions.VistaOptionsAfterOpen(DataSet: TDataSet);
begin
  if VistaOptions.IsEmpty then
  begin
    VistaOptions.Append;
    VistaOptions.Post;
  end;
end;

procedure TAppOptions.VistaOptionsNewRecord(DataSet: TDataSet);
begin
  VistaOptionsServer.AsString := cDefaultDbServerName;
  VistaOptionsDbUserName.AsString := '';
  VistaOptionsDbPassword.AsString := '';
  VistaOptionsDatabase.AsString := SDefaultDatabaseName;
  VistaOptionsAppUserName.AsString := SDefaultAppUserName;
  VistaOptionsAppPassword.AsString := '';
  VistaOptionsSourceDir.AsString := '';

  VistaOptionsSourceFilesCheckSum.AsString := '';
  VistaOptionsImportBatchSize.Value := cDefaultImportBatchSize;
  VistaOptionsLastImportRecno.Value := -1;

  VistaOptionsLastImportFile.AsString := '';
  VistaOptionsUpdateBatchSize.Value := cDefaultUpdateBatchSize;
  VistaOptionsLastUpdatedRecNo.Value := -1;
end;

end.

