{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: Job.VCL.ProgressBarPercentDisplay.pas
* Description: Дисплей для отображения процента выполнения фоновой работы на основе TProgressBar
*
* Created: 18.12.2022 18:18:46
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.VCL.ProgressBarPercentDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.ThreadSafeObject,
  Job.BackgroundJob, Lib.Subscription, VCL.Forms, VCL.ComCtrls,
  Job.PercentDisplay;

type
  /// <summary>TProgressBarPercentDisplay
  /// Дисплей для отображения процента выполнения фоновой работы на основе TProgressBar
  /// TProgressBar
  /// </summary>
  TProgressBarPercentDisplay = class(TPercentDisplay)
  strict private
    FProgressBar: TProgressBar;
  strict protected
    procedure OutputPercentToControl(APercent: Double; AMessage:
      TBackgroundJobMessage); override;
  public
    property ProgressBar: TProgressBar read FProgressBar;
    constructor Create(AProgressBar: TProgressBar);
  end;


implementation

constructor TProgressBarPercentDisplay.Create(AProgressBar: TProgressBar);
begin
  inherited Create;
  FProgressBar := AProgressBar;
end;

{ TProgressBarPercentDisplay }

procedure TProgressBarPercentDisplay.OutputPercentToControl(APercent:
  Double; AMessage: TBackgroundJobMessage);
begin
  if APercent >= 0 then
  begin
    FProgressBar.Position := Trunc(APercent);
  end;

  Application.ProcessMessages;
end;

end.
