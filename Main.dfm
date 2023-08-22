object fmMain: TfmMain
  Left = 401
  Top = 262
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  ClientHeight = 146
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object pumMain: TRxPopupMenu
    ShowCheckMarks = False
    Left = 32
    Top = 24
    object pmiHelp: TMenuItem
      Action = actHelp
    end
    object pmiAbout: TMenuItem
      Action = actAbout
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmiExit: TMenuItem
      Action = actExit
    end
  end
  object actsMain: TActionList
    Left = 32
    Top = 72
    object actExit: TAction
      Caption = 'Exit'
      Hint = 'Close the lense'
      OnExecute = actExitExecute
    end
    object actAbout: TAction
      Caption = 'About'
      OnExecute = actAboutExecute
    end
    object actHelp: TAction
      Caption = 'Help'
      Hint = 'Show small help'
      ShortCut = 112
      OnExecute = actHelpExecute
    end
  end
  object TheOnly: TTheOnly
    Automatic = True
    IpcName = 'Lense'
    SecInstMsg = 'The only one instance of Lense allowed.'
    Left = 120
    Top = 24
  end
  object AppEvents: TAppEvents
    OnActivate = AppEventsActivate
    Left = 192
    Top = 24
  end
  object dlgSavePic: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|All files (*.*)|*.*'
    Title = 'Capture to bitmap file'
    Left = 120
    Top = 72
  end
  object fsMain: TFormStorage
    IniSection = 'Main'
    Options = []
    StoredProps.Strings = (
      'dlgSavePic.InitialDir')
    StoredValues = <>
    Left = 192
    Top = 72
  end
end
