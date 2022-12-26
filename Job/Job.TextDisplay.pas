{*******************************************************
* Project: VistaBillExtractor
* Unit: Job.TextDisplay.pas
* Description: Базовый класс для текстовых дисплеев фоновой работы
*
* Created: 16.12.2022 13:39:55
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.TextDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.ThreadSafeObject,
  Job.BackgroundJob, Lib.Subscription, VCL.Forms;

type
  /// <summary>TTextDisplay
  /// Базовый класс для текстовых дисплеев фоновой работы
  /// </summary>
  TTextDisplay = class abstract(TThreadSafeInterfacedObject,
      IBackgroundJobSubscriber, ISubscriber<TBackgroundJobMessage>)
  strict protected
    function GetMessageText(AMessage: TBackgroundJobMessage): Variant; virtual;
    procedure OutputTextToControl(AMessageText: String;
      AMessage: TBackgroundJobMessage); virtual; abstract;
    /// <summary>ISubscriber<TBackgroundJobMessage>.OnPublisherMessage
    /// Обработчик событий получаемых от издателей
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TBackgroundJobMessage>) Издатель</param>
    /// <param name="AMessage"> (TBackgroundJobMessage) Событие</param>
    procedure OnPublisherMessage(APublisher: IPublisher<TBackgroundJobMessage>;
        AMessage: TBackgroundJobMessage); virtual; stdcall;
  public
  end;

implementation

function TTextDisplay.GetMessageText(AMessage: TBackgroundJobMessage):
    Variant;
begin
  Result := AMessage.AsString;
  if Result <> null then
    Result := DateTimeToStr(Now) + #9 + VarToStr(Result);
end;

procedure TTextDisplay.OnPublisherMessage(APublisher:
    IPublisher<TBackgroundJobMessage>; AMessage: TBackgroundJobMessage);
begin
  var vProc : TThreadProcedure := procedure
    begin
      var vMessageText: Variant := GetMessageText(AMessage);

      if vMessageText <> null then
      begin
        OutputTextToControl(vMessageText, AMessage);
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

