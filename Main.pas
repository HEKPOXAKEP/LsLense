unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ActnList, RxMenus, TheOnly, AppEvent, Lense, Placemnt, ExtDlgs;

type
  TfmMain = class(TForm)
    pumMain: TRxPopupMenu;
    actsMain: TActionList;
    actExit: TAction;
    pmiExit: TMenuItem;
    actAbout: TAction;
    N1: TMenuItem;
    pmiAbout: TMenuItem;
    TheOnly: TTheOnly;
    AppEvents: TAppEvents;
    actHelp: TAction;
    dlgSavePic: TSavePictureDialog;
    fsMain: TFormStorage;
    pmiHelp: TMenuItem;
    procedure actExitExecute(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actAboutExecute(Sender: TObject);
    procedure AppEventsActivate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure WMEraseBkgnd(var m:TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CaptureScreen;  // initial screen capture
    procedure Capture2Bmp(var bmp:tBitmap; x,y,w,h:integer);
    procedure DoCaptureMark(x,y:integer);
  public
    bmpScr:tBitmap;    // screen copy
    fmLense:TfmLense;  // lense window
    // ---
    procedure Capture2Clipboard;
    procedure Capture2BmpFile;
  end;

var
  fmMain: TfmMain;

implementation

uses
  ClipBrd,
  VclUtils,
  DatMod1,
  CaptureTo,
  Help,
  About;

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fsMain.IniFileName:=dm1.fIni.FileName;

  Screen.Cursors[crLense]:=LoadCursor(hInstance,'Lense');
  Screen.Cursors[crCaptureCross]:=LoadCursor(hInstance,'CaptureCross');
  Cursor:=crLense;

  // capture the screen;
  bmpScr:=tBitmap.Create;
  CaptureScreen;

  //bmpScr.HandleType:=bmDIB;

  (*case bmpScr.PixelFormat of
    pfDevice: s:='device';
    pf1bit: s:='1bit';
    pf4bit: s:='4bit';
    pf8bit: s:='8bit';
    pf15bit: s:='15bit';
    pf16bit: s:='16bit';
    pf24bit: s:='24bit';
    pf32bit: s:='32bit';
    pfCustom: s:='custom';
  else
    s:='UNKNOWN';
  end;
  MessageDlg(s,mtInformation,[mbOk],0);*)

  // create the lense window
  fmLense:=TfmLense.Create(Self); //Application);
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(bmpScr) then
    bmpScr.Free;
end;

procedure TfmMain.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0,0,bmpScr);
end;

procedure TfmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.WMEraseBkgnd(var m:TWMEraseBkgnd);
begin
  m.Result:=LRESULT(false);
end;

procedure TfmMain.CaptureScreen;
var
  ScrDC:hDC;

begin
  with bmpScr do begin
    Width:=Screen.Width;
    Height:=Screen.Height;

    ScrDC:=GetDC(0);

    try
      BitBlt(Canvas.Handle,0,0,Width,Height,ScrDC,0,0,SRCCOPY);
    finally
      ReleaseDC(0,ScrDC);
    end;

    //Palette:=GetSystemPalette;
  end; (*WITH bmpScr*)
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  fmLense.Show;  //Modal;
end;

procedure TfmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  case dm1.LenseMode of
    lm_Normal: ; //fmLense.Refresh;

    lm_Capture: ;

    lm_CaptureMark: DoCaptureMark(X,Y);
  end;

  // redraw lense window
  fmLense.Refresh;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dm1.LenseMode =lm_Normal then
    fmLense.FormKeyDown(Self,Key,Shift)
  else
    case Key of
      // cancel capture screen mode
      vk_Escape: fmLense.DoneScreenCapture;
    end; (*CASE Key*)
end;

procedure TfmMain.actAboutExecute(Sender: TObject);
begin
  with TfmAbout.Create(Self) do
    ShowModal;
end;

procedure TfmMain.AppEventsActivate(Sender: TObject);
begin
  if Assigned(fmLense) then
    SetForegroundWindow(fmLense.Handle)
end;

procedure TfmMain.actHelpExecute(Sender: TObject);
begin
  with TfmHelp.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfmMain.Capture2Bmp(var bmp:tBitmap; x,y,w,h:integer);
begin
  bmp.Width:=w;
  bmp.Height:=h;

  bmp.Canvas.CopyRect(Rect(0,0,w,h),bmpScr.Canvas,Rect(x,y,x+w,y+h));
end;

procedure TfmMain.Capture2BmpFile;
var
  pt:tPoint;
  bmp:tBitmap;

begin
  GetCursorPos(pt);

  if not dlgSavePic.Execute then exit;

  bmp:=tBitmap.Create;

  try
    Capture2Bmp(bmp,pt.X,pt.Y,32,32);
    bmp.SaveToFile(dlgSavePic.FileName);
  finally
    bmp.Free;
  end; (*TRY*)
end;

procedure TfmMain.Capture2Clipboard;
var
  pt:tPoint;
  bmp:tBitmap;

begin
  GetCursorPos(pt);

  bmp:=tBitmap.Create;

  try
    Capture2Bmp(bmp,pt.X,pt.Y,32,32);
    Clipboard.Assign(bmp);
  finally
    bmp.Free;
  end; (*TRY*)
end;

procedure TfmMain.DoCaptureMark(x,y:integer);
{ called from OnMouseMove event when LenseMode==lm_CaptureMark }
begin
  // clear old capture rect
  Canvas.DrawFocusRect(dm1.CaptureRect);

  // check & set new capture rect
  if x >=dm1.StartPt.X then begin
    dm1.CaptureRect.Left:=dm1.StartPt.X;
    dm1.CaptureRect.Right:=x;
  end
  else begin
    dm1.CaptureRect.Left:=x;
    dm1.CaptureRect.Right:=dm1.StartPt.X;
  end;

  if y >=dm1.StartPt.Y then begin
    dm1.CaptureRect.Top:=dm1.StartPt.Y;
    dm1.CaptureRect.Bottom:=y;
  end
  else begin
    dm1.CaptureRect.Top:=y;
    dm1.CaptureRect.Bottom:=dm1.StartPt.Y;
  end;

  // draw new capture rect
  Canvas.DrawFocusRect(dm1.CaptureRect);

  // assign hint: (XL,YL-XH,YH)
  //Application.CancelHint;
  {with dm1.CaptureRect do
    Self.Hint:=Format('(%d,%d-%d,%d)',[Left,Top,Right,Bottom]);}
end;

procedure TfmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if dm1.LenseMode =lm_Normal then begin
    if Button =mbRight then
      pumMain.Popup(X,Y);

    exit;
  end
  else
    if (dm1.LenseMode <>lm_Capture) and (Button <>mbLeft) then exit;

  dm1.LenseMode:=lm_CaptureMark;

  dm1.StartPt:=Point(X,Y);
  dm1.CaptureRect:=Rect(X,Y,X,Y);

  // draw initial capture rect
  Canvas.DrawFocusRect(dm1.CaptureRect);

  // redraw lense window
  fmLense.Refresh;
end;

procedure TfmMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  bmp:tBitmap;

begin
  if dm1.LenseMode <>lm_CaptureMark then exit;

  // clear capture rect
  Canvas.DrawFocusRect(dm1.CaptureRect);

  with TfmCaptureTo.Create(Self) do
    try
      if ShowModal =mrOk then begin
        if rgrpCaptureTo.ItemIndex =1 then
          if not dlgSavePic.Execute then exit;

        bmp:=tBitmap.Create;

        try
          // capture marked rect into bitmap
          Capture2Bmp(bmp,
            dm1.CaptureRect.Left,
            dm1.CaptureRect.Top,
            WidthOf(dm1.CaptureRect)+1,HeightOf(dm1.CaptureRect)+1);

          case rgrpCaptureTo.ItemIndex of
            // cature to Clipboard
            0: Clipboard.Assign(bmp);

            // capture to file
            1: bmp.SaveToFile(dlgSavePic.FileName);
          end; (*CASE rgrpCaptureTo.ItemIndex *)
        finally
          bmp.Free;
        end; (*TRY tBitmap.Create*)
      end; (*IF ShowModal*)
    finally
      Free;
    end; (*TRY TfmCaptureTo*)

  // return to normal lense mode
  fmLense.DoneScreenCapture;
end;

end.

