{*******************************************************
* Project: VistaZslLoader.Vcl
* Unit: AppMainForm.pas
* Description: Главная форма приложения
*
* Created: 26.12.2022 11:59:48
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit AppMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Job.BackgroundJob, Lib.Subscription,
  Vcl.StdCtrls, Vcl.ComCtrls, Job.VCL.RichTextDisplay, Job.VCL.ProgressBarPercentDisplay,
  Job.VCL.TaskbarPercentDisplay,  Vcl.Menus, cxButtons, dxSkinsCore, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxClasses, dxTaskbarProgress;

type
  TMainForm = class(TForm, ISubscriber<TBackgroundJobMessage>)
    aclMain: TActionList;
    btnStartStop: TButton;
    actStartStop: TAction;
    edLog: TRichEdit;
    actEditOptions: TAction;
    tprJob: TdxTaskbarProgress;
    pbPercentDone: TProgressBar;
    btnEditOptions: TcxButton;
    procedure actEditOptionsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actStartStopExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  strict private
    FStartButtonCaption: string;
    FJob: IBackgroundJob;
    FRtfDisplay: TRichTextDisplay;
    FTaskBar: TTaskbarPercentDisplay;
    FProgressDisplay: TProgressBarPercentDisplay;
    procedure CancelLoading;
    function CanCloseForm: Boolean;
    procedure CreateAndRunJob;
    procedure EditOptions;
    function NoGuiMode: Boolean;
    /// <summary>ISubscriber<TBackgroundJobMessage>.OnPublisherMessage
    /// Обработчик событий получаемых от издателей
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TBackgroundJobMessage>) Издатель</param>
    /// <param name="AMessage"> (TBackgroundJobMessage) Событие</param>
    procedure OnPublisherMessage(APublisher: IPublisher<TBackgroundJobMessage>;
      AMessage: TBackgroundJobMessage); stdcall;
    procedure WaitForLoadingCancellation;
  public
    function LoadingIsActive: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

uses
  LoaderJobFactory, AppOptionsEditor;

const
  SNoGUICommandLineParam = 'NoGUI';
  SSilentCommandLineParam = 'Silent';
  CCancelWaitMs = 100;
  CMaxCancelTryCount = 100;

resourcestring
  SCancelTimeoutException = 'Таймаут прерывания загрузки';
  SCancelLoadingConfirm = 'Прервать загрузку ЗСЛ ?';
  SAbortLoading = 'Прервать загрузку списка ЗСЛ';

{$R *.dfm}

procedure TMainForm.actEditOptionsExecute(Sender: TObject);
begin
  EditOptions();
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FStartButtonCaption := actStartStop.Caption;
  FRtfDisplay := TRichTextDisplay.Create(edLog);
  FTaskBar := TTaskbarPercentDisplay.Create(tprJob);
  FProgressDisplay := TProgressBarPercentDisplay.Create(pbPercentDone);
end;

procedure TMainForm.actStartStopExecute(Sender: TObject);
begin
  if not LoadingIsActive then
    CreateAndRunJob()
  else
    CancelLoading();
end;

procedure TMainForm.CancelLoading;
begin
  FJob.Task.Cancel;
  Application.ProcessMessages;
end;

function TMainForm.CanCloseForm: Boolean;
begin
  Result := not LoadingIsActive() or NoGuiMode()
    or (MessageDlg(SCancelLoadingConfirm, TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrYes);
end;

procedure TMainForm.CreateAndRunJob;
begin
  FJob := TLoaderJobFactory.CreateJob();

  FJob.RegisterSubscriber(FRtfDisplay);
  FJob.RegisterSubscriber(Self);
  FJob.RegisterSubscriber(FTaskBar);
  FJob.RegisterSubscriber(FProgressDisplay);

  FJob.Task.Start();

  actStartStop.Caption := SAbortLoading;
end;

procedure TMainForm.EditOptions;
begin
  with TAppOptionsEditorForm.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseForm();
  if CanClose and LoadingIsActive() then
  begin
    CancelLoading();
    WaitForLoadingCancellation();
  end;
end;

function TMainForm.LoadingIsActive: Boolean;
begin
  var vResult: Boolean;
  TThread.Synchronize(nil,
    procedure
    begin
      vResult := FJob <> nil;
    end);
  Result := vResult;
end;

function TMainForm.NoGuiMode: Boolean;
begin
  Result := FindCmdLineSwitch(SSilentCommandLineParam) or FindCmdLineSwitch(SNoGUICommandLineParam);
end;

procedure TMainForm.OnPublisherMessage(APublisher: IPublisher<
  TBackgroundJobMessage>; AMessage: TBackgroundJobMessage);
begin
  if AMessage is TJobFinishedMessage then
  begin
    TThread.Synchronize(nil,
      procedure
      begin
        FJob := nil;
        actStartStop.Caption := FStartButtonCaption;
      end)
  end;
end;

procedure TMainForm.WaitForLoadingCancellation;
begin
  var vCancelTryCount: Integer := 0;
  while LoadingIsActive()  do
  begin
    Application.ProcessMessages;
    Sleep(CCancelWaitMs);
    Inc(vCancelTryCount);
    if vCancelTryCount > CMaxCancelTryCount then
      raise Exception.Create(SCancelTimeoutException);
  end;
end;

end.

