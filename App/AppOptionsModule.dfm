object AppOptions: TAppOptions
  OnCreate = DataModuleCreate
  Height = 263
  Width = 267
  object conMain: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\bpost\Documents\Embarcadero\Studio\Projects\Vi' +
        'staZslLoader\Data\VistaZslLoader.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = conMainBeforeConnect
    Left = 45
    Top = 19
  end
  object VistaOptions: TFDQuery
    AfterOpen = VistaOptionsAfterOpen
    OnNewRecord = VistaOptionsNewRecord
    Connection = conMain
    SQL.Strings = (
      'SELECT * FROM VistaOptions')
    Left = 45
    Top = 75
    object VistaOptionsId: TFDAutoIncField
      FieldName = 'Id'
      ReadOnly = True
      Visible = False
    end
    object VistaOptionsServer: TWideStringField
      DisplayLabel = #1057#1077#1088#1074#1077#1088' '#1041#1044
      FieldName = 'Server'
      Size = 100
    end
    object VistaOptionsDbUserName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1041#1044
      FieldName = 'DbUserName'
      Size = 100
    end
    object VistaOptionsDbPassword: TWideStringField
      DisplayLabel = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1041#1044
      FieldName = 'DbPassword'
      Size = 100
    end
    object VistaOptionsDatabase: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1041#1044
      FieldName = 'Database'
      Size = 100
    end
    object VistaOptionsAppUserName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1042#1080#1089#1090#1072#1052#1077#1076
      FieldName = 'AppUserName'
      Size = 100
    end
    object VistaOptionsAppPassword: TWideStringField
      DisplayLabel = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1042#1080#1089#1090#1072#1052#1077#1076
      FieldName = 'AppPassword'
      Size = 100
    end
    object VistaOptionsSourceDir: TWideStringField
      DisplayLabel = #1050#1072#1090#1072#1083#1086#1075' '#1089' '#1092#1072#1081#1083#1072#1084#1080' '#1089#1087#1080#1089#1082#1086#1074' '#1079#1072#1089#1090#1088#1072#1093#1086#1074#1072#1085#1085#1099#1093' '#1083#1080#1094
      FieldName = 'SourceDir'
      Size = 255
    end
    object VistaOptionsSourceFilesCheckSum: TWideStringField
      DisplayLabel = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1092#1072#1081#1083#1086#1074
      FieldName = 'SourceFilesCheckSum'
      Visible = False
      Size = 100
    end
    object VistaOptionsImportBatchSize: TIntegerField
      DisplayLabel = #1056#1072#1079#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '#1087#1088#1080' '#1080#1084#1087#1086#1088#1090#1077' '#1092#1072#1081#1083#1086#1074' ('#1079#1072#1087#1080#1089#1077#1081')'
      FieldName = 'ImportBatchSize'
    end
    object VistaOptionsLastImportFile: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1079#1072#1075#1088#1091#1078#1072#1077#1084#1086#1075#1086' '#1092#1072#1081#1083#1072
      FieldName = 'LastImportFile'
      Size = 255
    end
    object VistaOptionsLastImportRecno: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
      FieldName = 'LastImportRecno'
    end
    object VistaOptionsUpdateBatchSize: TIntegerField
      DisplayLabel = #1056#1072#1079#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '#1087#1088#1080' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1080' '#1041#1044' '#1042#1080#1089#1090#1072#1052#1077#1076
      FieldName = 'UpdateBatchSize'
    end
    object VistaOptionsLastUpdatedRecNo: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1086#1073#1085#1086#1074#1083#1077#1085#1085#1086#1081' '#1079#1072#1087#1080#1089#1080' '#1074' '#1042#1080#1089#1090#1072#1052#1077#1076
      FieldName = 'LastUpdatedRecNo'
    end
  end
end
