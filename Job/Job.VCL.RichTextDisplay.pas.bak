{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: Job.VCL.RichTextDisplay.pas
* Description: Текстовый дисплей фоновой работы с форматированием
*
* Created: 18.12.2022 18:09:18
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.VCL.RichTextDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Job.BackgroundJob,
  Job.TextDisplay, VCL.ComCtrls, VCL.Forms, Vcl.Graphics;

type
  /// <summary>TRichTextDisplay
  /// Текстовый дисплей фоновой работы с форматированием
  /// </summary>
  TRichTextDisplay = class(TTextDisplay)
  strict protected
    FRichEdit: TRichEdit;
    FDefaultTextOptions: TRichTextOptions;
    procedure OutputTextToControl(AMessageText: String; AMessage:
        TBackgroundJobMessage); override;
    procedure RestoreRichEditTextOptions(AMessage: TBackgroundJobMessage);
    procedure SaveRichEditTextOptions(AMessage: TBackgroundJobMessage);
    procedure SetRichEditTextOptions(AMessage: TBackgroundJobMessage; AText:
        String);
  public
    constructor Create(ARichEdit: TRichEdit);
  end;

implementation

uses System.TypInfo;

constructor TRichTextDisplay.Create(ARichEdit: TRichEdit);
begin
  inherited Create();
  FRichEdit := ARichEdit;
end;

procedure TRichTextDisplay.OutputTextToControl(AMessageText: String;
    AMessage: TBackgroundJobMessage);
begin
  SaveRichEditTextOptions(AMessage);
  SetRichEditTextOptions(AMessage, AMessageText);
  RestoreRichEditTextOptions(AMessage);
end;

procedure TRichTextDisplay.RestoreRichEditTextOptions(AMessage:
    TBackgroundJobMessage);
begin
  if AMessage is TJobRichTextMessage then
  begin
    with FDefaultTextOptions do
    begin
      FRichEdit.SelStart := 0;
      FRichEdit.SelText := '';
      Application.ProcessMessages;
      FRichEdit.SelAttributes.Name := FontName.Value;
      FRichEdit.SelAttributes.Size := Size.Value;
      FRichEdit.SelAttributes.Style := FontStyle.Value;
      FRichEdit.SelAttributes.Color := FontColor.Value;
      FRichEdit.SelAttributes.BackColor := BackColor.Value;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TRichTextDisplay.SaveRichEditTextOptions(AMessage:
    TBackgroundJobMessage);
begin
  with FDefaultTextOptions do
  begin
    Clear();

    FontName := FRichEdit.Font.Name;
    Size := FRichEdit.Font.Size;
    FontStyle := FRichEdit.Font.Style;
    FontColor := FRichEdit.Font.Color;
    BackColor := FRichEdit.Brush.Color;
  end;
end;

procedure TRichTextDisplay.SetRichEditTextOptions(AMessage:
    TBackgroundJobMessage; AText: String);
begin
  FRichEdit.SelStart := 0;
  FRichEdit.SelText := AText + #13;
  Application.ProcessMessages;

  if AMessage is TJobRichTextMessage then
  begin
    FRichEdit.SelStart := 0;
    FRichEdit.SelLength := Length(AText + #13);
    with (AMessage as TJobRichTextMessage).RichTextOptions do
    begin
      if (FontName.HasValue) then
        FRichEdit.SelAttributes.Name := FontName.Value;

      if (Size.HasValue) then
        FRichEdit.SelAttributes.Size := Size.Value;

      if (FontStyle.HasValue) then
        FRichEdit.SelAttributes.Style := FontStyle.Value;

      if (FontColor.HasValue) then
        FRichEdit.SelAttributes.Color := FontColor.Value;

      if (BackColor.HasValue) then
        FRichEdit.SelAttributes.BackColor := BackColor.Value;
    end;
  end;
  Application.ProcessMessages;

end;

end.
