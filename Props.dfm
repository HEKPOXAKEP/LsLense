object fmProps: TfmProps
  Left = 324
  Top = 187
  BorderStyle = bsDialog
  Caption = ' properties'
  ClientHeight = 422
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  DesignSize = (
    527
    422)
  PixelsPerInch = 125
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 527
    Height = 385
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
    end
  end
  object btnOk: TButton
    Left = 368
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 448
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
