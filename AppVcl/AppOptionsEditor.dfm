object AppOptionsEditorForm: TAppOptionsEditorForm
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1085#1072#1089#1090#1088#1086#1077#1082
  ClientHeight = 669
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ShowHint = True
  TextHeight = 21
  object lacMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 624
    Height = 669
    Align = alClient
    TabOrder = 0
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 17
      Top = 46
      DataBinding.DataField = 'Server'
      DataBinding.DataSource = dsOptions
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 590
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 17
      Top = 114
      DataBinding.DataField = 'DbUserName'
      DataBinding.DataSource = dsOptions
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 590
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 17
      Top = 182
      DataBinding.DataField = 'DbPassword'
      DataBinding.DataSource = dsOptions
      Properties.EchoMode = eemPassword
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 590
    end
    object cxDBTextEdit4: TcxDBTextEdit
      Left = 17
      Top = 250
      DataBinding.DataField = 'Database'
      DataBinding.DataSource = dsOptions
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Width = 590
    end
    object cxDBTextEdit5: TcxDBTextEdit
      Left = 17
      Top = 318
      DataBinding.DataField = 'AppUserName'
      DataBinding.DataSource = dsOptions
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Width = 590
    end
    object cxDBTextEdit6: TcxDBTextEdit
      Left = 17
      Top = 386
      DataBinding.DataField = 'AppPassword'
      DataBinding.DataSource = dsOptions
      Properties.EchoMode = eemPassword
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Width = 590
    end
    object cxDBTextEdit7: TcxDBTextEdit
      Left = 17
      Top = 454
      DataBinding.DataField = 'SourceDir'
      DataBinding.DataSource = dsOptions
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Width = 590
    end
    object cxDBSpinEdit1: TcxDBSpinEdit
      Left = 354
      Top = 493
      DataBinding.DataField = 'ImportBatchSize'
      DataBinding.DataSource = dsOptions
      Properties.MaxValue = 1000000.000000000000000000
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 9
      Width = 121
    end
    object cxDBSpinEdit2: TcxDBSpinEdit
      Left = 354
      Top = 532
      DataBinding.DataField = 'UpdateBatchSize'
      DataBinding.DataSource = dsOptions
      Properties.MaxValue = 1000000.000000000000000000
      Properties.OnValidate = cxDBTextEdit1PropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 10
      Width = 121
    end
    object btnOk: TcxButton
      Left = 17
      Top = 602
      Width = 232
      Height = 50
      Action = actOk
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 259
      Top = 602
      Width = 150
      Height = 50
      Action = actCancel
      Cancel = True
      ModalResult = 2
      TabOrder = 1
    end
    object layRoot: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1057#1077#1088#1074#1077#1088' '#1041#1044
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit1
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1041#1044
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit2
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1041#1044
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit3
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItem4: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1048#1084#1103' '#1041#1044
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit4
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItem5: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1042#1080#1089#1090#1072#1052#1077#1076
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit5
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object dxLayoutItem6: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1042#1080#1089#1090#1072#1052#1077#1076
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit6
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItem7: TdxLayoutItem
      Parent = layRoot
      CaptionOptions.Text = #1050#1072#1090#1072#1083#1086#1075' '#1089' '#1092#1072#1081#1083#1072#1084#1080' '#1089#1087#1080#1089#1082#1086#1074' '#1079#1072#1089#1090#1088#1072#1093#1086#1074#1072#1085#1085#1099#1093' '#1083#1080#1094
      CaptionOptions.Layout = clTop
      Control = cxDBTextEdit7
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 8
    end
    object dxLayoutItem8: TdxLayoutItem
      Parent = layRoot
      AlignHorz = ahLeft
      CaptionOptions.Text = #1056#1072#1079#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '#1087#1088#1080' '#1080#1084#1087#1086#1088#1090#1077' '#1092#1072#1081#1083#1086#1074' ('#1079#1072#1087#1080#1089#1077#1081')'
      Control = cxDBSpinEdit1
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 9
    end
    object dxLayoutItem9: TdxLayoutItem
      Parent = layRoot
      AlignHorz = ahLeft
      CaptionOptions.Text = #1056#1072#1079#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '#1087#1088#1080' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1080' '#1041#1044' '#1042#1080#1089#1090#1072#1052#1077#1076
      Control = cxDBSpinEdit2
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 10
    end
    object layButtons: TdxLayoutGroup
      Parent = layRoot
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object layOk: TdxLayoutItem
      Parent = layButtons
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnOk
      ControlOptions.OriginalHeight = 50
      ControlOptions.OriginalWidth = 232
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layCancel: TdxLayoutItem
      Parent = layButtons
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 50
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutSeparatorItem1: TdxLayoutSeparatorItem
      Parent = layRoot
      AlignVert = avBottom
      CaptionOptions.Text = 'Separator'
      Index = 0
    end
  end
  object aclMain: TActionList
    Left = 304
    Top = 224
    object actOk: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1072
      OnExecute = actCancelExecute
    end
  end
  object dsOptions: TDataSource
    DataSet = AppOptions.VistaOptions
    Left = 400
    Top = 224
  end
end
