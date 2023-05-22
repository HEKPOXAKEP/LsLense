object fmAbout: TfmAbout
  Left = 360
  Top = 209
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 306
  ClientWidth = 480
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
  OnCreate = FormCreate
  DesignSize = (
    480
    306)
  PixelsPerInch = 125
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 264
    Width = 465
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object lblPID: TLabel
    Left = 176
    Top = 16
    Width = 289
    Height = 27
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVID: TLabel
    Left = 176
    Top = 48
    Width = 289
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCID: TLabel
    Left = 176
    Top = 72
    Width = 289
    Height = 16
    Alignment = taCenter
    AutoSize = False
  end
  object panLogo: TPanel
    Left = 8
    Top = 8
    Width = 153
    Height = 243
    BevelOuter = bvLowered
    TabOrder = 0
    object imgLogo: TImage
      Left = 1
      Top = 1
      Width = 150
      Height = 240
    end
  end
  object btnOk: TButton
    Left = 392
    Top = 275
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object sttQOD: TStaticText
    Left = 176
    Top = 232
    Width = 289
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    BevelEdges = [beTop]
    BevelKind = bkFlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
