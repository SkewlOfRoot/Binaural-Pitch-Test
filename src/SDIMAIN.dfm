object SDIAppForm: TSDIAppForm
  Left = 309
  Top = 186
  BorderStyle = bsSingle
  Caption = 'Binaural Pitch Test'
  ClientHeight = 548
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 16
  object TLabel
    Left = 252
    Top = 222
    Width = 4
    Height = 16
  end
  object grpPlayControl: TGroupBox
    Left = 5
    Top = 0
    Width = 490
    Height = 137
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblAudioFile: TLabel
      Left = 15
      Top = 79
      Width = 84
      Height = 13
      Caption = 'Audio-file loaded:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lblElapsed: TLabel
      Left = 15
      Top = 111
      Width = 44
      Height = 13
      Caption = '00:00:00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalDuration: TLabel
      Left = 436
      Top = 111
      Width = 44
      Height = 13
      Caption = '00:00:00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object trackPosition: TTrackBar
      Left = 65
      Top = 98
      Width = 365
      Height = 26
      LineSize = 100
      PageSize = 100
      Frequency = 100
      TabOrder = 0
      ThumbLength = 15
      TickMarks = tmBoth
      OnChange = trackPositionChange
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnOpenTest: TButton
      Left = 116
      Top = 16
      Width = 80
      Height = 25
      Caption = 'Open Test'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnOpenTestClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnStartTest: TButton
      Left = 247
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Start Test'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnStartTestClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnResetTest: TButton
      Left = 409
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Reset Test'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnResetTestClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnCreateTest: TButton
      Left = 15
      Top = 16
      Width = 95
      Height = 25
      Caption = 'Create/Edit Test'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnCreateTestClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnPauseTest: TButton
      Left = 328
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Pause Test'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnPauseTestClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnVolumeControl: TButton
      Left = 267
      Top = 47
      Width = 119
      Height = 25
      Caption = 'Volume Control'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Visible = False
      OnClick = btnVolumeControlClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnOpenResult: TButton
      Left = 116
      Top = 47
      Width = 80
      Height = 25
      Caption = 'Open Result'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = btnOpenResultClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object btnClearAll: TButton
      Left = 409
      Top = 47
      Width = 75
      Height = 25
      Caption = 'Clear All'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = btnClearAllClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
    object chkEnableTrackBar: TCheckBox
      Left = 357
      Top = 78
      Width = 127
      Height = 17
      Caption = 'Update Play Position'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 9
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
  end
  object grpTestAndResults: TGroupBox
    Left = 188
    Top = 143
    Width = 307
    Height = 397
    Caption = 'Test results'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblTotalDichoticBlocks: TLabel
      Left = 16
      Top = 130
      Width = 82
      Height = 13
      Caption = 'Dichotic blocks: 0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalDioticBlocks: TLabel
      Left = 16
      Top = 117
      Width = 71
      Height = 13
      Caption = 'Diotic blocks: 0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblPatientInput: TLabel
      Left = 16
      Top = 86
      Width = 65
      Height = 13
      Caption = 'Patient input:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnDetection: TButton
      Left = 13
      Top = 20
      Width = 132
      Height = 53
      Caption = 'Detection'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnDetectionClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
      OnMouseDown = btnDetectionMouseDown
      OnMouseUp = btnDetectionMouseUp
    end
    object grpCorrectDetections: TGroupBox
      Left = 13
      Top = 152
      Width = 132
      Height = 125
      Caption = 'Correct'
      TabOrder = 1
      object lblDiotic: TLabel
        Left = 3
        Top = 19
        Width = 30
        Height = 13
        Caption = 'Diotic:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDichotic: TLabel
        Left = 3
        Top = 38
        Width = 41
        Height = 13
        Caption = 'Dichotic:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblCorrectDichotic: TLabel
        Left = 96
        Top = 38
        Width = 6
        Height = 13
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblCorrectDiotic: TLabel
        Left = 96
        Top = 19
        Width = 6
        Height = 13
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentDiotic: TLabel
        Left = 3
        Top = 63
        Width = 44
        Height = 13
        Caption = '% Diotic:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentDichotic: TLabel
        Left = 3
        Top = 82
        Width = 55
        Height = 13
        Caption = '% Dichotic:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentDichoticValue: TLabel
        Left = 96
        Top = 82
        Width = 17
        Height = 13
        Caption = '0%'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentDioticValue: TLabel
        Left = 96
        Top = 63
        Width = 17
        Height = 13
        Caption = '0%'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentTotal: TLabel
        Left = 3
        Top = 101
        Width = 42
        Height = 13
        Caption = '% Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentTotalValue: TLabel
        Left = 96
        Top = 101
        Width = 17
        Height = 13
        Caption = '0%'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object panelTest: TPanel
      Left = 168
      Top = 19
      Width = 132
      Height = 366
      TabOrder = 2
      object sbTest: TScrollBar
        Left = 115
        Top = 1
        Width = 16
        Height = 364
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        TabOrder = 1
        OnScroll = sbTestScroll
      end
      object drawGrid: TDrawGrid
        Left = 2
        Top = 1
        Width = 112
        Height = 360
        ColCount = 2
        DefaultColWidth = 55
        DefaultRowHeight = 15
        Enabled = False
        FixedCols = 0
        RowCount = 30
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = '@Arial Unicode MS'
        Font.Style = []
        GridLineWidth = 0
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 0
        OnDrawCell = drawGridDrawCell
      end
    end
    object panelColorDetection: TPanel
      Left = 87
      Top = 80
      Width = 55
      Height = 26
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = '0'
      Color = clGreen
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object btnSaveTestResults: TButton
      Left = 16
      Top = 307
      Width = 82
      Height = 25
      Caption = 'Save Results'
      TabOrder = 4
      OnClick = btnSaveTestResultsClick
      OnKeyDown = FormKeyDown
      OnKeyUp = FormKeyUp
    end
  end
  object grpPatient: TGroupBox
    Left = 6
    Top = 143
    Width = 180
    Height = 397
    Caption = 'Patient'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lblCpr: TLabel
      Left = 3
      Top = 24
      Width = 21
      Height = 13
      Caption = 'Cpr:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblFirstname: TLabel
      Left = 3
      Top = 52
      Width = 51
      Height = 13
      Caption = 'Firstname:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblSurname: TLabel
      Left = 3
      Top = 79
      Width = 46
      Height = 13
      Caption = 'Surname:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblComment: TLabel
      Left = 3
      Top = 101
      Width = 49
      Height = 13
      Caption = 'Comment:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object editCprFirst: TEdit
      Left = 67
      Top = 20
      Width = 52
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object editCprSecond: TEdit
      Left = 125
      Top = 20
      Width = 40
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object editFirstname: TEdit
      Left = 67
      Top = 47
      Width = 98
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object editSurname: TEdit
      Left = 67
      Top = 74
      Width = 98
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object memoComment: TMemo
      Left = 15
      Top = 120
      Width = 150
      Height = 97
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 128
    Top = 486
  end
  object xmlDoc: TXMLDocument
    Left = 96
    Top = 486
    DOMVendorDesc = 'MSXML'
  end
  object openFileDialog: TOpenDialog
    Left = 64
    Top = 486
  end
  object saveLocalDialog: TSaveDialog
    Left = 32
    Top = 486
  end
  object MainMenu: TMainMenu
    Left = 32
    Top = 454
    object File1: TMenuItem
      Caption = 'Options'
      object menuControls: TMenuItem
        Caption = 'Controls'
        object menuVolumeControl: TMenuItem
          Caption = 'Volume control'
          OnClick = menuVolumeControlClick
        end
        object menuDeviceControl: TMenuItem
          Caption = 'Device control'
          OnClick = menuDeviceControlClick
        end
      end
      object menuSaveAs: TMenuItem
        Caption = 'Save As'
        ShortCut = 16467
        OnClick = menuSaveAsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuExit: TMenuItem
        Caption = 'Exit'
        OnClick = menuExitClick
      end
    end
    object About1: TMenuItem
      Caption = 'Help'
      object About2: TMenuItem
        Caption = 'About'
        OnClick = About2Click
      end
    end
  end
  object hidDeviceController: TJvHidDeviceController
    OnEnumerate = hidDeviceControllerEnumerate
    OnDeviceChange = hidDeviceControllerDeviceChange
    OnDeviceData = hidDeviceControllerDeviceData
    Left = 64
    Top = 454
  end
end
