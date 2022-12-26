{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: Job.VCL.MemoDisplay.pas
* Description: Текстовый дисплей фоновой работы с выводом в TMemo
*
* Created: 18.12.2022 18:10:03
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Job.VCL.MemoDisplay;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Job.BackgroundJob,
  Job.TextDisplay, VCL.StdCtrls, VCL.Forms;

type
  /// <summary>TMemoDisplay
  /// Текстовый дисплей фоновой работы с выводом в TMemo
  /// </summary>
  TMemoDisplay = class(TTextDisplay)
  strict protected
    FMemo: TMemo;
    procedure OutputTextToControl(AMessageText: String; AMessage:
        TBackgroundJobMessage); override;
  public
    constructor Create(AMemo: TMemo);
  end;

implementation

constructor TMemoDisplay.Create(AMemo: TMemo);
begin
  inherited Create();
  FMemo := AMemo;
end;

procedure TMemoDisplay.OutputTextToControl(AMessageText: String;
    AMessage: TBackgroundJobMessage);
begin
  FMemo.Lines.Insert(0, AMessageText);
end;

end.
