object fmHelp: TfmHelp
  Left = 349
  Top = 205
  Width = 521
  Height = 367
  Caption = 'Help'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    513
    335)
  PixelsPerInch = 125
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 299
    Width = 497
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object btnOk: TButton
    Left = 424
    Top = 306
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object redHelp: TRxRichEdit
    Left = 8
    Top = 8
    Width = 497
    Height = 281
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 1
    WordWrap = False
  end
  object fsHelp: TFormStorage
    IniSection = 'Help'
    StoredValues = <>
    Left = 48
    Top = 280
  end
end
