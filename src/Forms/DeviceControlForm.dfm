object DeviceControl: TDeviceControl
  Left = 794
  Top = 465
  Caption = 'Device Control'
  ClientHeight = 184
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object grpDevices: TGroupBox
    Left = 0
    Top = 0
    Width = 233
    Height = 145
    Caption = 'Devices'
    TabOrder = 0
    object Label1: TLabel
      Left = 58
      Top = 122
      Width = 40
      Height = 13
      Caption = 'No input'
    end
    object lblInput: TLabel
      Left = 22
      Top = 122
      Width = 30
      Height = 13
      Caption = 'Input:'
    end
    object Label2: TLabel
      Left = 22
      Top = 16
      Width = 93
      Height = 13
      Caption = 'Plugged-in devices:'
    end
    object listDevice: TListBox
      Left = 22
      Top = 35
      Width = 198
      Height = 81
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object btnClose: TButton
    Left = 158
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object hidDeviceController: TJvHidDeviceController
    OnEnumerate = hidDeviceControllerEnumerate
    OnDeviceChange = hidDeviceControllerDeviceChange
    OnDeviceData = hidDeviceControllerDeviceData
    Left = 120
    Top = 152
  end
end
