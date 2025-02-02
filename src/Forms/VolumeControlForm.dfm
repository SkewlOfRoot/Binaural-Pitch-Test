object VolumeControl: TVolumeControl
  Left = 794
  Top = 186
  Caption = 'Volume Control'
  ClientHeight = 251
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpPlayControl: TGroupBox
    Left = 8
    Top = 0
    Width = 121
    Height = 217
    Caption = 'Play Control'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblPan: TLabel
      Left = 3
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Balance:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblVolume: TLabel
      Left = 3
      Top = 63
      Width = 38
      Height = 13
      Caption = 'Volume:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnVolumeDefault: TButton
      Left = 55
      Top = 189
      Width = 51
      Height = 25
      Caption = 'Default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnVolumeDefaultClick
    end
    object chkMute: TCheckBox
      Left = 3
      Top = 197
      Width = 46
      Height = 17
      Caption = 'Mute'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkMuteClick
    end
    object trackPan: TTrackBar
      Left = 15
      Top = 35
      Width = 91
      Height = 30
      LineSize = 1000
      Max = 4000
      Min = -4000
      PageSize = 1000
      Frequency = 1000
      TabOrder = 2
      OnChange = trackPanChange
    end
    object trackVolume: TTrackBar
      Left = 39
      Top = 77
      Width = 44
      Height = 106
      LineSize = 5000
      Max = 65535
      Orientation = trVertical
      PageSize = 5000
      Frequency = 5000
      TabOrder = 3
      TickMarks = tmBoth
      OnChange = trackVolumeChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 135
    Top = 0
    Width = 146
    Height = 217
    Caption = 'SPL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 58
      Top = 106
      Width = 41
      Height = 13
      Caption = '0 dB SPL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblSplLevel: TLabel
      Left = 35
      Top = 16
      Width = 103
      Height = 26
      Caption = 'Enter SPL level between 55 and 101:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object trackSpl: TTrackBar
      Left = 3
      Top = 16
      Width = 26
      Height = 198
      Max = 46
      Orientation = trVertical
      TabOrder = 0
      OnChange = trackSplChange
    end
    object editSplLevel: TEdit
      Left = 47
      Top = 50
      Width = 31
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnSetSpl: TButton
      Left = 84
      Top = 50
      Width = 53
      Height = 21
      Caption = 'Set'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSetSplClick
    end
  end
  object btnClose: TButton
    Left = 206
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object xmlDoc: TXMLDocument
    Left = 232
    Top = 176
    DOMVendorDesc = 'MSXML'
  end
end
