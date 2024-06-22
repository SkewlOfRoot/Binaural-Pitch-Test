object CreateNewTest: TCreateNewTest
  Left = 265
  Top = 233
  Caption = 'Test Editor'
  ClientHeight = 480
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddToExisting: TButton
    Left = 8
    Top = 8
    Width = 96
    Height = 25
    Caption = 'Open existing'
    TabOrder = 0
    OnClick = btnAddToExistingClick
  end
  object btnSave: TButton
    Left = 437
    Top = 447
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 39
    Width = 585
    Height = 402
    TabOrder = 1
    object sbtnUp: TSpeedButton
      Left = 298
      Top = 39
      Width = 23
      Height = 22
      Glyph.Data = {
        7E030000424D7E0300000000000036000000280000000F0000000E0000000100
        2000000000004803000023050000230500000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000001F74184B216F
        161700000000000000000000000000000000000000000000000000000000246D
        120E1C771C5C0000000000000000000000001C741765198928EE1A7B1BD81A66
        0D140000000000000000000000000000000000000000156A150C1D8022CC21AB
        41F21F7F1F8D000000001F66141919791BEC10C14FFF13B94AFF1A791AD52070
        10100000000000000000000000001A661A0A1D7E20C921DB65FD24F97BFF1F93
        2FEE1C69112E000000001B751790149631F10FC04DFF13B647FE1B791BD11462
        140D00000000206020081C7C1CC61DCC59FC1FEC70FF1EB84BF31C7D20990000
        000000000000000000001A751896139832F20EBD4BFF12B244FD1A771ACD1E69
        0F111B7A1AC319C04FFB1ADE66FF1BB647F41D7C1DA000000000000000000000
        000000000000000000001A73179E119830F30DBA49FF12AE41FD1B7518E915B3
        45FA15D15BFF19B043F51B7A1DA7000000000000000000000000000000000000
        000000000000000000001A7217A5119831F40CB847FF0EBD4BFF10C350FF16AB
        3EF71B791BAD0000000100000000000000000000000000000000000000000000
        00000000000000000001187417AA0F9831F50BB545FF11A339F81B771AB20000
        0001000000000000000000000000000000000000000000000000000000000000
        00000000000000000001197416B0128A27F5197518B700800002000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000008000021A6E1264008000040000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000}
      OnClick = sbtnUpClick
    end
    object sbtnDown: TSpeedButton
      Left = 298
      Top = 67
      Width = 23
      Height = 22
      Glyph.Data = {
        7E030000424D7E0300000000000036000000280000000F0000000E0000000100
        2000000000004803000023050000230500000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000008000021A6E12640080000400000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000001197416B0128A27F5197518B70080000200000000000000000000
        0000000000000000000000000000000000000000000000000000000000011874
        17AA0F9831F50BB545FF11A339F81B771AB20000000100000000000000000000
        000000000000000000000000000000000000000000001A7217A5119831F40CB8
        47FF0EBD4BFF10C350FF16AB3EF71B791BAD0000000100000000000000000000
        00000000000000000000000000001A73179E119830F30DBA49FF12AE41FD1B75
        18E915B345FA15D15BFF19B043F51B7A1DA70000000000000000000000000000
        0000000000001A751896139832F20EBD4BFF12B244FD1A771ACD1E690F111B7A
        1AC319C04FFB1ADE66FF1BB647F41D7C1DA00000000000000000000000001B75
        1790149631F10FC04DFF13B647FE1B791BD11462140D00000000206020081C7C
        1CC61DCC59FC1FEC70FF1EB84BF31C7D2099000000001F66141919791BEC10C1
        4FFF13B94AFF1A791AD5207010100000000000000000000000001A661A0A1D7E
        20C921DB65FD24F97BFF1F932FEE1C69112E000000001C741765198928EE1A7B
        1BD81A660D140000000000000000000000000000000000000000156A150C1D80
        22CC21AB41F21F7F1F8D0000000000000000000000001F74184B216F16170000
        0000000000000000000000000000000000000000000000000000246D120E1C77
        1C5C000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000}
      OnClick = sbtnDownClick
    end
    object btnAdd: TButton
      Left = 271
      Top = 168
      Width = 50
      Height = 25
      Caption = '>>>'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 88
      Width = 257
      Height = 153
      Caption = 'Create block'
      TabOrder = 0
      object lblTypeDuration: TLabel
        Left = 11
        Top = 48
        Width = 28
        Height = 13
        Caption = 'Type:'
      end
      object Label2: TLabel
        Left = 11
        Top = 75
        Width = 63
        Height = 13
        Caption = 'Answer time:'
      end
      object lblStartTime: TLabel
        Left = 11
        Top = 101
        Width = 51
        Height = 13
        Caption = 'Start time:'
      end
      object lblEndTime: TLabel
        Left = 11
        Top = 128
        Width = 45
        Height = 13
        Caption = 'End time:'
      end
      object lblSeconds1: TLabel
        Left = 206
        Top = 75
        Width = 40
        Height = 13
        Caption = 'Seconds'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lblSeconds2: TLabel
        Left = 206
        Top = 101
        Width = 40
        Height = 13
        Caption = 'Seconds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblSeconds3: TLabel
        Left = 206
        Top = 128
        Width = 40
        Height = 13
        Caption = 'Seconds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblSeconds4: TLabel
        Left = 183
        Top = 20
        Width = 40
        Height = 13
        Caption = 'Seconds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object cbType: TComboBox
        Left = 150
        Top = 44
        Width = 75
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Void'
        Items.Strings = (
          'Void'
          'Diotic'
          'Dichotic')
      end
      object cbDuration: TComboBox
        Left = 150
        Top = 71
        Width = 50
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 1
        Text = '2'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object editStartTime: TEdit
        Left = 150
        Top = 98
        Width = 50
        Height = 21
        TabOrder = 2
      end
      object editEndTime: TEdit
        Left = 150
        Top = 125
        Width = 50
        Height = 21
        TabOrder = 3
      end
      object editConstantInterval: TEdit
        Left = 150
        Top = 17
        Width = 27
        Height = 21
        TabOrder = 4
        Text = '5'
      end
      object chkConstantInterval: TCheckBox
        Left = 11
        Top = 19
        Width = 133
        Height = 17
        Caption = 'Constant block interval:'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = chkConstantIntervalClick
      end
    end
    object btnDeleteRow: TButton
      Left = 501
      Top = 8
      Width = 75
      Height = 25
      Hint = 'Select a row from the list above and click this button.'
      Caption = 'Delete row'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnDeleteRowClick
    end
    object lvBlocks: TListView
      Left = 327
      Top = 39
      Width = 249
      Height = 330
      Columns = <
        item
          Caption = 'Type'
          Width = 60
        end
        item
          Caption = 'Ans. time'
          Width = 65
        end
        item
          Caption = 'Start time'
          Width = 60
        end
        item
          Caption = 'End time'
          Width = 60
        end>
      HideSelection = False
      RowSelect = True
      TabOrder = 3
      ViewStyle = vsReport
      OnDblClick = lvBlocksDblClick
    end
    object grpWaveFile: TGroupBox
      Left = 8
      Top = 247
      Width = 257
      Height = 122
      Caption = 'For entire test'
      TabOrder = 4
      object Label1: TLabel
        Left = 11
        Top = 49
        Width = 134
        Height = 13
        Caption = 'Select associated wave-file:'
      end
      object lblWaveDir: TLabel
        Left = 11
        Top = 68
        Width = 51
        Height = 13
        Caption = 'Looking in:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblOverallAnswerTime: TLabel
        Left = 11
        Top = 26
        Width = 116
        Height = 13
        Caption = 'Set overall answer time:'
      end
      object cbWaveFile: TComboBox
        Left = 11
        Top = 87
        Width = 230
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object cbOverallAnswer: TComboBox
        Left = 133
        Top = 22
        Width = 41
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 1
        Text = '2'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object btnOverallAnswerTime: TButton
        Left = 180
        Top = 21
        Width = 38
        Height = 21
        Caption = 'Set'
        TabOrder = 2
        OnClick = btnOverallAnswerTimeClick
      end
    end
  end
  object btnCancel: TButton
    Left = 518
    Top = 447
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object btnClear: TButton
    Left = 335
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = btnClearClick
  end
  object saveDialog: TSaveDialog
    Left = 343
    Top = 448
  end
  object openDialog: TOpenDialog
    Left = 303
    Top = 448
  end
  object existingXmlDoc: TXMLDocument
    Left = 263
    Top = 448
    DOMVendorDesc = 'MSXML'
  end
end
