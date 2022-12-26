{*******************************************************
* Project: VistaBillExtractor
* Unit: Job.ConsoleDisplay.pas
* Description: Модуль отображения статуса работы в консоли
*
* Created: 18.12.2022 9:28:11
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.ConsoleDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, winapi.windows,
  Job.BackgroundJob, Job.TextDisplay, System.UITypes;

type
  /// <summary>TConsoleDisplay
  /// Дисплей отображения статуса фоновой работы в консоли
  /// </summary>
  TConsoleDisplay = class(TTextDisplay)
  strict protected
    FDefaultTextOptions: TRichTextOptions;
    function GetConsoleAttrs(AOptions: TRichTextOptions): WORD;
    procedure OutputTextToControl(AMessageText: string; AMessage:
      TBackgroundJobMessage); override;
  public
  end;

implementation

function TConsoleDisplay.GetConsoleAttrs(AOptions: TRichTextOptions):
    WORD;
begin
  Result := 0;
  if AOptions.FontColor.HasValue then
  begin
    case AOptions.FontColor.Value of
      TColorRec.Red: Result := Result or FOREGROUND_RED or FOREGROUND_INTENSITY;
      TColorRec.Green: Result := Result or FOREGROUND_GREEN or FOREGROUND_INTENSITY;
      TColorRec.Blue: Result := Result or FOREGROUND_BLUE or FOREGROUND_INTENSITY;
    end;
  end;
  if AOptions.BackColor.HasValue then
  begin
    case AOptions.BackColor.Value of
      TColorRec.Red: Result := Result or BACKGROUND_RED or BACKGROUND_INTENSITY;
      TColorRec.Green: Result := Result or BACKGROUND_GREEN or BACKGROUND_INTENSITY;
      TColorRec.Blue: Result := Result or BACKGROUND_BLUE or BACKGROUND_INTENSITY;
    end;
  end;
end;

procedure TConsoleDisplay.OutputTextToControl(AMessageText: string;
  AMessage: TBackgroundJobMessage);
var
  ConOut: THandle;
  BufInfo: TConsoleScreenBufferInfo;
  vAttrs: WORD;
  vTextOptions: TRichTextOptions;
begin
  ConOut := TTextRec(Output).Handle;  // or GetStdHandle(STD_OUTPUT_HANDLE)
  GetConsoleScreenBufferInfo(ConOut, BufInfo);
  if (AMessage is TJobRichTextMessage) then
  begin
    vTextOptions := (AMessage as TJobRichTextMessage).RichTextOptions;
    if vTextOptions.ColorsSpecified() then
    begin
      vAttrs := GetConsoleAttrs(vTextOptions);
      SetConsoleTextAttribute(TTextRec(Output).Handle, vAttrs);
    end;
  end;
  writeln(AMessageText);
  SetConsoleTextAttribute(ConOut, BufInfo.wAttributes);
end;

end.

