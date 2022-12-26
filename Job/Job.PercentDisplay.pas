{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: Job.PercentDisplay.pas
* Description: Базовый класс для отображения процента выполнения фоновой работы
*
* Created: 18.12.2022 14:10:03
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.PercentDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.ThreadSafeObject,
  Job.BackgroundJob, Lib.Subscription, VCL.Forms;

type
  /// <summary>TPercentDisplay
  /// Базовый класс для отображения процента выполнения фоновой работы
  /// </summary>
  TPercentDisplay = class abstract(TThreadSafeInterfacedObject,
      IBackgroundJobSubscriber, ISubscriber<TBackgroundJobMessage>)
  strict protected
    function GetMessagePercent(AMessage: TBackgroundJobMessage): Variant; virtual;
    procedure OutputPercentToControl(APercent: Double; AMessage:
        TBackgroundJobMessage); virtual; abstract;
    /// <summary>ISubscriber<TMessageData>.OnPublisherMessage
    /// Обработчик событий получаемых от издателей
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TMessageData>) Издатель</param>
    /// <param name="AMessage"> (TMessageData) Событие</param>
    procedure OnPublisherMessage(APublisher: IPublisher<TBackgroundJobMessage>;
        AMessage: TBackgroundJobMessage); virtual; stdcall;
  public
  end;

implementation

function TPercentDisplay.GetMessagePercent(AMessage:
    TBackgroundJobMessage): Variant;
begin
  Result := null;
  if AMessage is TJobPercentDoneMessage then
    Result := (AMessage as TJobPercentDoneMessage).PercentDone;

  if AMessage is TJobCompletedMessage then
    Result := 100;

  if AMessage is TJobFaultMessage then
    Result := -1;
end;

procedure TPercentDisplay.OnPublisherMessage(APublisher:
    IPublisher<TBackgroundJobMessage>; AMessage: TBackgroundJobMessage);
begin
  var vProc : TThreadProcedure := procedure
    begin
      var vPercent: Variant := GetMessagePercent(AMessage);

      if vPercent <> null then
      begin
        OutputPercentToControl(vPercent, AMessage);
        Application.ProcessMessages;
      end;
    end;

{$IF APPTYPE = 'GUI'}
  TThread.Synchronize(nil, vProc);
{$ELSE}
  vProc();
{$ENDIF}
end;

end.
