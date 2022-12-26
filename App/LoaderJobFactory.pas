{*******************************************************
* Project: VistaZslLoader.Windows
* Unit: LoaderJobFactoryUnit.pas
* Description: ������� ����� �������� ���
*
* Created: 18.12.2022 13:06:45
* Copyright (C) 2022 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit LoaderJobFactory;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.UITypes,
  System.UIConsts, Job.BackgroundJob, AppOptionsModule;

type
  /// <summary>TLoaderJobFactory
  /// ������� ����� �������� ���
  /// </summary>
  TLoaderJobFactory = class
  private
    class procedure LoadOptions(AOptions: TAppOptions);
  public
    /// <summary>TLoaderJobFactory.CreateJob
    /// ������� ������ �� �������� ���
    /// </summary>
    /// <returns> IBackgroundJob
    /// </returns>
    class function CreateJob: IBackgroundJob;
  end;

implementation



class function TLoaderJobFactory.CreateJob: IBackgroundJob;
begin
  Result := TBackgroundJob.Create('�������� ��� � �� ��������',
    procedure(AJob: IBackgroundJob)
    begin
      var vOptions := TAppOptions.Create(nil);
      LoadOptions(vOptions);
      try
        //TODO: ����������� ���������
        for var I := 0 to 100 do
        begin
          Sleep(100);
          AJob.Task.CheckCanceled;
          var vMessage := TJobRichTextMessage.CreateFmt(AJob, '�������� %s',  [I.ToString()]);
          if I mod 2 = 0 then
          begin
            vMessage.RichTextOptions.BackColor.Value := TColorRec.Green;
            vMessage.RichTextOptions.FontColor.Value := TColorRec.White;
          end;
          AJob.SendJobMessage(vMessage);
          AJob.SendJobMessage(TJobPercentDoneMessage.Create(AJob, I));
        //        if I > 50 then
        //          raise Exception.Create('Overflow');
          end;
      finally
        vOptions.Free
      end;
    end);
end;

class procedure TLoaderJobFactory.LoadOptions(AOptions: TAppOptions);
begin
//  var vLoader := TOptionsLoader.Create(nil);
//  try
//    vLoader.LoadAppOptions(AOptions);
//  finally
//    vLoader.Free;
//  end;
end;

end.
