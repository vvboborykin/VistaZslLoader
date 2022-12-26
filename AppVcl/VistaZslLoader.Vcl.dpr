program VistaZslLoader.Vcl;

uses
  Vcl.Forms,
  AppMainForm in 'AppMainForm.pas' {MainForm},
  Job.BackgroundJob in '..\Job\Job.BackgroundJob.pas',
  Job.TextDisplay in '..\Job\Job.TextDisplay.pas',
  LoaderJobFactory in '..\App\LoaderJobFactory.pas',
  Job.PercentDisplay in '..\Job\Job.PercentDisplay.pas',
  Job.ConsoleDisplay in '..\Job\Job.ConsoleDisplay.pas',
  Job.VCL.MemoDisplay in '..\Job\Job.VCL.MemoDisplay.pas',
  Job.VCL.RichTextDisplay in '..\Job\Job.VCL.RichTextDisplay.pas',
  Job.VCL.TaskbarPercentDisplay in '..\Job\Job.VCL.TaskbarPercentDisplay.pas',
  Job.VCL.ProgressBarPercentDisplay in '..\Job\Job.VCL.ProgressBarPercentDisplay.pas',
  Lib.CommandLineService in '..\Lib\Lib.CommandLineService.pas',
  Lib.Nullable in '..\Lib\Lib.Nullable.pas',
  Lib.RTTIHelper in '..\Lib\Lib.RTTIHelper.pas',
  Lib.Singleton in '..\Lib\Lib.Singleton.pas',
  Lib.StreamHelper in '..\Lib\Lib.StreamHelper.pas',
  Lib.Subscription in '..\Lib\Lib.Subscription.pas',
  Lib.ThreadSafeObject in '..\Lib\Lib.ThreadSafeObject.pas',
  DbLib.DataSetHelper in '..\DbLib\DbLib.DataSetHelper.pas',
  Lib.Environment in '..\Lib\Lib.Environment.pas',
  AppOptionsEditor in 'AppOptionsEditor.pas' {AppOptionsEditorForm},
  AppOptionsModule in '..\App\AppOptionsModule.pas' {AppOptions: TDataModule},
  Lib.ComponentHelper in '..\Lib\Lib.ComponentHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Загрузчик сведений о застрахованных лицах';
  Application.CreateForm(TAppOptions, AppOptions);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
