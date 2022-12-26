program VistaZslLoader.Console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.SysUtils,
  Job.BackgroundJob in '..\Job\Job.BackgroundJob.pas',
  Job.TextDisplay in '..\Job\Job.TextDisplay.pas',
  Job.ConsoleDisplay in '..\Job\Job.ConsoleDisplay.pas',
  ConsoleLoader in 'ConsoleLoader.pas',
  LoaderJobFactory in '..\App\LoaderJobFactory.pas',
  DbLib.DataSetHelper in '..\DbLib\DbLib.DataSetHelper.pas',
  AppOptionsModule in '..\App\AppOptionsModule.pas' {AppOptions: TDataModule},
  Lib.CommandLineService in '..\Lib\Lib.CommandLineService.pas',
  Lib.ComponentHelper in '..\Lib\Lib.ComponentHelper.pas',
  Lib.Environment in '..\Lib\Lib.Environment.pas',
  Lib.Nullable in '..\Lib\Lib.Nullable.pas',
  Lib.RTTIHelper in '..\Lib\Lib.RTTIHelper.pas',
  Lib.Singleton in '..\Lib\Lib.Singleton.pas',
  Lib.StreamHelper in '..\Lib\Lib.StreamHelper.pas',
  Lib.Subscription in '..\Lib\Lib.Subscription.pas',
  Lib.ThreadSafeObject in '..\Lib\Lib.ThreadSafeObject.pas';

begin
  try
    var vLoader := TConsoleLoader.Create(nil);
    vLoader.Load;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
