object fmCaptureTo: TfmCaptureTo
  Left = 458
  Top = 460
  BorderStyle = bsDialog
  Caption = 'Capture to...'
  ClientHeight = 110
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object rgrpCaptureTo: TRadioGroup
    Left = 8
    Top = 8
    Width = 337
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Capture destination '
    Items.Strings = (
      'Capture to Clipboard'
      'Capture to file')
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 192
    Top = 80
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 269
    Top = 80
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object fsCaptureTo: TFormStorage
    IniSection = 'CaptureTo'
    StoredProps.Strings = (
      'rgrpCaptureTo.ItemIndex')
    StoredValues = <>
    Left = 264
  end
end
