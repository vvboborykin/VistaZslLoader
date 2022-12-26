{*******************************************************
* Project: VistaBillExtractor
* Unit: Job.BackgroundJob.pas
* Description: Работа выполняемая в фоновом режиме
*
* Created: 15.12.2022 10:16:32
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.BackgroundJob;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.Threading,
  System.UITypes, Lib.Nullable, Generics.Collections, Lib.Subscription;

type
  TBackgroundJobMessage = class;

  IBackgroundJobSubscriber = interface(ISubscriber<TBackgroundJobMessage>)
    ['{0A4B19B0-5874-4B97-95ED-F5943F6B7921}']
  end;

  /// <summary>IBackgroundJob
  /// Работа выполняемая в фоновом режиме
  /// </summary>
  IBackgroundJob = interface(IPublisher<TBackgroundJobMessage>)
    ['{F01EEFDA-BE38-467B-B9BB-B4E2363522FD}']
    function GetCaption: string; stdcall;
    procedure SetCaption(const Value: string); stdcall;
    /// <summary>IBackgroundJob.Task
    /// Задача выполняющая работу
    /// </summary>
    /// <returns> ITask
    /// </returns>
    function Task: ITask; stdcall;
    /// <summary>IBackgroundJob.Caption
    /// Наименование работы
    /// </summary>
    /// type:String
    property Caption: string read GetCaption write SetCaption;
    /// <summary>IBackgroundJob.SendJobMessage
    /// Отправить подписчикам сообщение</summary>
    /// <param name="AMessage"> (TBackgroundJobMessage) </param>
    procedure SendJobMessage(const AMessage: TBackgroundJobMessage); stdcall;
    /// <summary>IBackgroundJob.GetMessages
    /// Получить список сообщений отправленных работой ранее
    /// </summary>
    /// <param name="AMessageList"> (TList<TBackgroundJobMessage>) список для
    /// заполнения</param>
    procedure GetMessages(AMessageList: TList<TBackgroundJobMessage>); stdcall;
  end;

  /// <summary>TBackgroundJob
  /// Реализация IBackgroundJob
  /// </summary>
  TBackgroundJob = class(TPublisher<TBackgroundJobMessage>, IBackgroundJob)
  strict private
    FTask: ITask;
    FCaption: string;
    FMessages: TObjectList<TBackgroundJobMessage>;
    procedure SendJobMessage(const AMessage: TBackgroundJobMessage); stdcall;
    function GetCaption: string; stdcall;
    procedure SetCaption(const Value: string); stdcall;
    function Task: ITask; stdcall;
    procedure GetMessages(AMessageList: TList<TBackgroundJobMessage>); stdcall;
    procedure SendJobCompleted;
    procedure SendJobCanceled;
    procedure SendJobFault(AException: Exception);
  public
    constructor Create(const ACaption: string; const AProc: TProc<IBackgroundJob
      >);
    destructor Destroy; override;
  end;

{$REGION Типы сообщений от фоновой работы подписчикам}

  TBackgroundJobMessage = class abstract
  private
    FSender: IBackgroundJob;
    procedure SetSender(const Value: IBackgroundJob);
  public
    constructor Create(ASender: IBackgroundJob);
    function AsString: Variant; virtual;
    property Sender: IBackgroundJob read FSender write SetSender;
  end;

  /// <summary>TChangeCaptionMessage
  /// Изменено наименование работы
  /// </summary>
  TChangeCaptionMessage = class(TBackgroundJobMessage)
  private
    FNewCaption: string;
  public
    constructor Create(ASender: IBackgroundJob; const ANewCaption: string);
    property NewCaption: string read FNewCaption;
  end;

  /// <summary>TJobTextMessage
  /// Текстовое сообщение о статусе работы
  /// </summary>
  TJobTextMessage = class(TBackgroundJobMessage)
  private
    FText: string;
  public
    constructor Create(ASender: IBackgroundJob; const AText: string); virtual;
    constructor CreateFmt(ASender: IBackgroundJob; ATemplate: string; AParams:
      array of const);
    function AsString: Variant; override;
    property Text: string read FText;
  end;

  /// <summary>TJobPercentDoneMessage
  /// Изменился процент выполнения работы
  /// </summary>
  TJobPercentDoneMessage = class(TBackgroundJobMessage)
  private
    FPercentDone: Double;
  public
    constructor Create(ASender: IBackgroundJob; APercentDone: Double);
    property PercentDone: Double read FPercentDone;
  end;

  /// <summary>TRichTextOptions
  /// Параметры форматирования текста
  /// </summary>
  TRichTextOptions = record
  public
    FontName: TNullable<string>;
    Size: TNullable<integer>;
    FontStyle: TNullable<TFontStyles>;
    FontColor: TNullable<TColor>;
    BackColor: TNullable<TColor>;
    procedure Clear;
    function ColorsSpecified: Boolean;
  end;

  /// <summary>TJobRichTextMessage
  /// Текстовое сообщение с форматированием
  /// </summary>
  TJobRichTextMessage = class(TJobTextMessage)
  private
    FRichTextOptions: TRichTextOptions;
  public
    property RichTextOptions: TRichTextOptions read FRichTextOptions write
        FRichTextOptions;
  end;

  /// <summary>TJobStartedMessage
  /// Начато выполнение работы
  /// </summary>
  TJobStartedMessage = class(TJobRichTextMessage)
  private
  public
    constructor Create(ASender: IBackgroundJob);
  end;


  /// <summary>TJobFinishedMessage
  /// Работа закончена
  /// </summary>
  TJobFinishedMessage = class abstract(TJobRichTextMessage)
  private
  public
  end;

  /// <summary>TJobCompletedMessage
  /// Работа завершена штатно
  /// </summary>
  TJobCompletedMessage = class(TJobFinishedMessage)
  private
  public
    constructor Create(ASender: IBackgroundJob);
  end;

  /// <summary>TJobCanceledMessage
  /// Работа прервана
  /// </summary>
  TJobCanceledMessage = class(TJobFinishedMessage)
  private
  public
    constructor Create(ASender: IBackgroundJob);
  end;

  /// <summary>TJobFaultMessage
  /// Работа завершена с ошибкой
  /// </summary>
  TJobFaultMessage = class(TJobFinishedMessage)
  private
    FExceptionMessage: string;
  public
    constructor Create(ASender: IBackgroundJob; const AExceptionMessage: string);
    property ExceptionMessage: string read FExceptionMessage;
  end;


{$ENDREGION}

var
  DefaultTextOptions: TRichTextOptions;
  DefaultJobStartedTextOptions: TRichTextOptions;
  DefaultJobCompletedTextOptions: TRichTextOptions;
  DefaultJobCanceledTextOptions: TRichTextOptions;
  DefaultJobFaultTextOptions: TRichTextOptions;

implementation

resourcestring
  SJobCompleted = 'Закончено выполнение задачи "%s"';
  SJobCancelled = 'Прервано выполнение задачи "%s"';
  SJobStarted = 'Начато выполнение задачи "%s"';
  SJobFault = 'ОШИБКА: Выполнение задачи "%s" завершено с ошибкой "%s"';

constructor TBackgroundJob.Create(const ACaption: string; const AProc: TProc<
  IBackgroundJob>);
begin
  inherited Create;
  FCaption := ACaption;
  FTask := TTask.Create(
    procedure
    begin
      SendJobMessage(TJobStartedMessage.Create(Self));
      try
        AProc(Self);
        FTask.CheckCanceled();
        SendJobCompleted();
      except
        on E: EOperationCancelled do
          SendJobCanceled();
        on E: Exception do
          SendJobFault(E);
      end;
    end);
  FMessages := TObjectList<TBackgroundJobMessage>.Create(True);
end;

destructor TBackgroundJob.Destroy;
begin
  FMessages.Free;
  inherited Destroy;
end;

procedure TBackgroundJob.SendJobMessage(const AMessage: TBackgroundJobMessage);
begin
  try
    BroadcastMessage(AMessage);
  finally
    FMessages.Add(AMessage);
  end;
end;

function TBackgroundJob.GetCaption: string;
begin
  Result := FCaption;
end;

procedure TBackgroundJob.GetMessages(AMessageList: TList<TBackgroundJobMessage>);
begin

end;

procedure TBackgroundJob.SendJobCanceled;
begin
  SendJobMessage(TJobCanceledMessage.Create(Self));
end;

procedure TBackgroundJob.SendJobCompleted;
begin
  SendJobMessage(TJobCompletedMessage.Create(Self));
end;

procedure TBackgroundJob.SendJobFault(AException: Exception);
begin
  SendJobMessage(TJobFaultMessage.Create(Self, AException.Message));
end;

procedure TBackgroundJob.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    SendJobMessage(TChangeCaptionMessage.Create(Self, FCaption));
  end;
end;

function TBackgroundJob.Task: ITask;
begin
  Result := FTask;
end;

constructor TChangeCaptionMessage.Create(ASender: IBackgroundJob; const
  ANewCaption: string);
begin
  inherited Create(ASender);
  FNewCaption := ANewCaption;
end;

constructor TJobFaultMessage.Create(ASender: IBackgroundJob; const
  AExceptionMessage: string);
begin
  inherited CreateFmt(ASender, SJobFault, [ASender.Caption, AExceptionMessage]);
  FExceptionMessage := AExceptionMessage;
  RichTextOptions := DefaultJobFaultTextOptions;
end;

constructor TJobTextMessage.Create(ASender: IBackgroundJob; const AText:
    string);
begin
  inherited Create(ASender);
  FText := AText;
end;

constructor TJobTextMessage.CreateFmt(ASender: IBackgroundJob; ATemplate: string;
  AParams: array of const);
begin
  Create(ASender, Format(ATemplate, AParams));
end;

function TJobTextMessage.AsString: Variant;
begin
  Result := FText;
end;

constructor TJobPercentDoneMessage.Create(ASender: IBackgroundJob; APercentDone:
  Double);
begin
  inherited Create(ASender);
  FPercentDone := APercentDone;
end;

constructor TBackgroundJobMessage.Create(ASender: IBackgroundJob);
begin
  inherited Create;
  FSender := ASender;
end;

function TBackgroundJobMessage.AsString: Variant;
begin
  Result := null;
end;

procedure TBackgroundJobMessage.SetSender(const Value: IBackgroundJob);
begin
  FSender := Value;
end;

procedure TRichTextOptions.Clear;
begin
  FontName := nil;
  Size := nil;
  FontStyle := nil;
  FontColor := nil;
  BackColor := nil;
end;

function TRichTextOptions.ColorsSpecified: Boolean;
begin
  Result := FontColor.HasValue or BackColor.HasValue;
end;

constructor TJobCompletedMessage.Create(ASender: IBackgroundJob);
begin
  inherited CreateFmt(ASender, SJobCompleted, [ASender.Caption]);
  RichTextOptions := DefaultJobCompletedTextOptions;
end;

constructor TJobCanceledMessage.Create(ASender: IBackgroundJob);
begin
  inherited CreateFmt(ASender, SJobCancelled, [ASender.Caption]);
  RichTextOptions := DefaultJobCanceledTextOptions;
end;

constructor TJobStartedMessage.Create(ASender: IBackgroundJob);
begin
  inherited CreateFmt(ASender, SJobStarted, [ASender.Caption]);
  RichTextOptions := DefaultJobStartedTextOptions;
end;

initialization
  DefaultJobStartedTextOptions.FontColor := TColorRec.Blue;
  DefaultJobStartedTextOptions.FontStyle := [TFontStyle.fsBold];

  DefaultJobCompletedTextOptions.FontColor := TColorRec.Green;
  DefaultJobCompletedTextOptions.FontStyle := [TFontStyle.fsBold];

  DefaultJobCanceledTextOptions.FontColor := TColorRec.White;
  DefaultJobCanceledTextOptions.FontStyle := [TFontStyle.fsBold];
  DefaultJobCanceledTextOptions.BackColor := TColorRec.Blue;

  DefaultJobFaultTextOptions.FontColor := TColorRec.White;
  DefaultJobFaultTextOptions.FontStyle := [TFontStyle.fsBold];
  DefaultJobFaultTextOptions.BackColor := TColorRec.Red;
end.

