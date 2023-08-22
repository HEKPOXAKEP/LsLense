object fmHelp: TfmHelp
  Left = 403
  Top = 235
  Width = 502
  Height = 376
  Caption = 'Help'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    494
    349)
  PixelsPerInch = 96
  TextHeight = 13
  object redHelp: TRxRichEdit
    Left = 5
    Top = 6
    Width = 480
    Height = 306
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 0
    WordWrap = False
  end
  object btnOk: TButton
    Left = 405
    Top = 320
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 1
  end
  object fsHelp: TFormStorage
    IniSection = 'Help'
    StoredValues = <>
    Left = 24
    Top = 24
  end
end
