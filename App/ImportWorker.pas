{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: ImportWorker.pas
* Description: Модуль интерфейса работника для импорта данных из файлов в БД
*
* Created: 27.12.2022 8:12:38
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit ImportWorker;

interface

uses
  System.SysUtils, System.Classes, System.Variants, AppOptionsModule,
  Job.BackgroundJob;

type
  /// <summary>IImportWorker
  /// Интерфейс работника для импорта данных из файлов в БД
  /// </summary>
  IImportWorker = interface
    ['{EB8A7956-669E-4325-88F7-0EC0CF8AD8C8}']
    /// <summary>IImportWorker.Import
    /// Загрузить данные из файлов в БД
    /// </summary>
    /// <param name="AJob"> (IBackgroundJob) Фоновая работа в рамках которой
    /// производится загрузка</param>
    /// <param name="AOptions"> (TAppOptions) Параметры приложения</param>
    procedure Import(AJob: IBackgroundJob; AOptions: TAppOptions);
  end;

implementation

end.
