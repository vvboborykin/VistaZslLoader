{*******************************************************
* Project: VistaBillExtractor
* Unit: Job.TextDisplay.pas
* Description: ������� ����� ��� ��������� �������� ������� ������
*
* Created: 16.12.2022 13:39:55
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit Job.TextDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.ThreadSafeObject,
  Job.BackgroundJob, Lib.Subscription, VCL.Forms;

type
  /// <summary>TTextDisplay
  /// ������� ����� ��� ��������� �������� ������� ������
  /// </summary>
  TTextDisplay = class abstract(TThreadSafeInterfacedObject,
      IBackgroundJobSubscriber, ISubscriber<TBackgroundJobMessage>)
  strict protected
    function GetMessageText(AMessage: TBackgroundJobMessage): Variant; virtual;
    procedure OutputTextToControl(AMessageText: String;
      AMessage: TBackgroundJobMessage); virtual; abstract;
    /// <summary>ISubscriber<TBackgroundJobMessage>.OnPublisherMessage
    /// ���������� ������� ���������� �� ���������
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TBackgroundJobMessage>) ��������</param>
    /// <param name="AMessage"> (TBackgroundJobMessage) �������</param>
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

