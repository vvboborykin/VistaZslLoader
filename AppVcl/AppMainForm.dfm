object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1075#1088#1091#1079#1095#1080#1082' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1086' '#1079#1072#1089#1090#1088#1072#1093#1086#1074#1072#1085#1085#1099#1093' '#1083#1080#1094#1072#1093
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 7
  Padding.Right = 10
  Padding.Bottom = 10
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 20
  object btnStartStop: TButton
    Left = 10
    Top = 7
    Width = 604
    Height = 42
    Action = actStartStop
    Align = alTop
    TabOrder = 0
  end
  object edLog: TRichEdit
    AlignWithMargins = True
    Left = 10
    Top = 89
    Width = 604
    Height = 290
    Margins.Left = 0
    Margins.Top = 5
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WantTabs = True
    WordWrap = False
  end
  object pbPercentDone: TProgressBar
    AlignWithMargins = True
    Left = 13
    Top = 64
    Width = 598
    Height = 17
    Margins.Top = 15
    Align = alTop
    TabOrder = 2
  end
  object btnEditOptions: TcxButton
    Left = 10
    Top = 379
    Width = 604
    Height = 52
    Align = alBottom
    Action = actEditOptions
    TabOrder = 3
  end
  object aclMain: TActionList
    Left = 304
    Top = 224
    object actStartStop: TAction
      Caption = #1053#1072#1095#1072#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091' '#1076#1072#1085#1085#1099#1093' '#1047#1057#1051' '#1074' '#1041#1044' '#1042#1080#1089#1090#1072#1052#1077#1076
      OnExecute = actStartStopExecute
    end
    object actEditOptions: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1079#1072#1075#1088#1091#1079#1082#1080
      OnExecute = actEditOptionsExecute
    end
  end
  object tprJob: TdxTaskbarProgress
    Position = 0
    Left = 448
    Top = 152
  end
end
