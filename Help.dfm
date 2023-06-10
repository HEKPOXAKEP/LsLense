object fmHelp: TfmHelp
  Left = 403
  Top = 235
  Width = 403
  Height = 395
  Caption = 'Help'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    395
    363)
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 312
    Width = 379
    Height = 3
    Anchors = [akLeft, akRight, akBottom]
  end
  object btnOk: TButton
    Left = 294
    Top = 324
    Width = 92
    Height = 31
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
    Width = 379
    Height = 295
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 1
    WordWrap = False
  end
  object fsHelp: TFormStorage
    IniSection = 'Help'
    StoredValues = <>
    Left = 16
    Top = 16
  end
end
