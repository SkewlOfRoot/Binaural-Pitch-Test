object SaveAs: TSaveAs
  Left = 353
  Top = 419
  BorderStyle = bsDialog
  Caption = 'Save As'
  ClientHeight = 139
  ClientWidth = 326
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
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 312
    Height = 97
    TabOrder = 0
    object rgSave: TRadioGroup
      Left = 16
      Top = 8
      Width = 281
      Height = 73
      Caption = 'Where to save'
      ItemIndex = 1
      Items.Strings = (
        'Locally only'
        'AuditBase only'
        'Both locally and in AuditBase')
      TabOrder = 0
    end
  end
  object btnCancel: TButton
    Left = 245
    Top = 109
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnSave: TButton
    Left = 164
    Top = 109
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object saveLocalDialog: TSaveDialog
    Left = 88
    Top = 112
  end
end
