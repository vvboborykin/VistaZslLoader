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
  FireDAC.Comp.Client, System.IOUtils;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure conMainBeforeConnect(Sender: TObject);
    procedure VistaOptionsAfterOpen(DataSet: TDataSet);
    procedure VistaOptionsNewRecord(DataSet: TDataSet);
  strict private
    procedure CheckFieldForNotNull(AField: TField; AErrors: TStrings);
    function GetAppDatabaseFileName: string;
    function GetAppDataDir: string;
    function GetOptionsDbFileName: string;
    function GetUserDatabaseFileName: string;
  private
  public
    procedure Validate(AErrors: TStrings);
  end;

var
  AppOptions: TAppOptions;

implementation

const
  cDefaultUpdateBatchSize = 50000;
  cDefaultImportBatchSize = 50000;
  cDefaultDbServerName = 'MySqlServer';

resourcestring
  SSourceDirNotExists =
    'Каталог "%s" со списками застрахованных лиц не существует';
  SFieldShoudNotBeEmpty = 'Поле %s не должно быть пустым';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAppOptions.DataModuleCreate(Sender: TObject);
begin
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

function TAppOptions.GetOptionsDbFileName: string;
begin
  Result := TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.db';
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
  VistaOptionsDatabase.AsString := 's11';
  VistaOptionsAppUserName.AsString := 'Админ';
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

