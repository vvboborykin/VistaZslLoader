{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: Job.VCL.TaskbarPercentDisplay.pas
* Description: ������� ��� ����������� �������� ���������� �������
*              ������ �� ������ TdxTaskbarProgress
*
* Created: 18.12.2022 14:10:25
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit Job.VCL.TaskbarPercentDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.ThreadSafeObject,
  Job.BackgroundJob, Lib.Subscription, VCL.Forms, dxTaskbarProgress,
  Job.PercentDisplay;

type
  /// <summary>TTaskbarPercentDisplay
  /// ������� ��� ����������� �������� ���������� ������� ������ �� ������
  /// TdxTaskbarProgress
  /// </summary>
  TTaskbarPercentDisplay = class(TPercentDisplay)
  strict private
    FTaskbarProgress: TdxTaskbarProgress;
  strict protected
    procedure OutputPercentToControl(APercent: Double; AMessage:
      TBackgroundJobMessage); override;
  public
    property TaskbarProgress: TdxTaskbarProgress read FTaskbarProgress;
    constructor Create(ATaskbarProgress: TdxTaskbarProgress);
  end;

implementation

constructor TTaskbarPercentDisplay.Create(ATaskbarProgress:
  TdxTaskbarProgress);
begin
  inherited Create;
  FTaskbarProgress := ATaskbarProgress;
end;

{ TTaskbarPercentDisplay }

procedure TTaskbarPercentDisplay.OutputPercentToControl(APercent:
  Double; AMessage: TBackgroundJobMessage);
begin
  FTaskbarProgress.Active := True;

  if APercent >= 0 then
  begin
    FTaskbarProgress.Position := Trunc(APercent);
    if APercent >= 100 then
      FTaskbarProgress.State := tbpsNoProgress;
  end
  else
    FTaskbarProgress.State := tbpsError;

  Application.ProcessMessages;
end;

end.

