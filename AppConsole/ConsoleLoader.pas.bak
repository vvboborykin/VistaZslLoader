unit ConsoleLoader;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Lib.Subscription,
  Job.BackgroundJob, Job.ConsoleDisplay, System.Threading;

type
  TConsoleLoader = class(TComponent, ISubscriber<TBackgroundJobMessage>)
  strict private
    FDone: Boolean;
    FConsoleDisplay: TConsoleDisplay;
    /// <summary>ISubscriber<TMessageData>.OnPublisherMessage
    /// Обработчик событий получаемых от издателей
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TMessageData>) Издатель</param>
    /// <param name="AMessage"> (TMessageData) Событие</param>
    procedure OnPublisherMessage(APublisher: IPublisher<TBackgroundJobMessage>;
      AMessage: TBackgroundJobMessage); stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load;
  end;

implementation

uses
  LoaderJobFactory;

constructor TConsoleLoader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConsoleDisplay := TConsoleDisplay.Create();
end;

destructor TConsoleLoader.Destroy;
begin
  FConsoleDisplay.Free;
  inherited Destroy;
end;

procedure TConsoleLoader.Load;
begin
  FDone := False;

  var vJob := TLoaderJobFactory.CreateJob as IBackgroundJob;
  vJob.RegisterSubscriber(Self);
  vJob.RegisterSubscriber(FConsoleDisplay);
  vJob.Task.Start;

  while not FDone do
  begin
    Sleep(100);
  end;
end;

{ TConsoleLoader }

procedure TConsoleLoader.OnPublisherMessage(APublisher: IPublisher<
  TBackgroundJobMessage>; AMessage: TBackgroundJobMessage);
begin
  if AMessage is TJobFinishedMessage then
    FDone := True;
end;

end.

