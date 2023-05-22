unit Lense;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TfmLense = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender:tObject; var Key:word; Shift:tShiftState);
  private
    LenseSize:tPoint;  // width & height of lense in blocks
    BlockSize:tPoint;  // width & height of lense blocks
    // ---
    procedure CMMouseEnter(var aMsg:TMessage); message CM_MOUSEENTER;
    (*procedure CMMouseLeave(var aMsg:TMessage); message CM_MOUSELEAVE;*)
    procedure WMEraseBkgnd(var aMsg:TWMEraseBkgnd); message WM_ERASEBKGND;
    // ---
    procedure IncBlockSize(d:integer);
    procedure CalcLenseSize;
    procedure CalcLensePos;

    procedure InitScreenCapture;
  public
    procedure DoneScreenCapture;
  end;

implementation

uses
  DatMod1,
  Main;

{$R *.DFM}

procedure TfmLense.WMEraseBkgnd(var aMsg:TWMEraseBkgnd);
begin
  aMsg.Result:=LRESULT(false);
end;

procedure TfmLense.CMMouseEnter(var aMsg:TMessage);
begin
  CalcLensePos;
end;

(*procedure TfmLense.CMMouseLeave(var aMsg:TMessage);
begin
  // --
end;*)

procedure TfmLense.FormPaint(Sender: TObject);
{ draw increased view of a part of the screen }
var
  p:tPoint;
  r:tRect;
  a:pRGBQuadArray;  //pRGBTripleArray;
  x,y,x_,y_:integer;
  c:TColor;  // color of pixel under hotspot

begin
  // default pen color == black
  Canvas.Pen.Color:=clBlack;

  // get current cursor pos
  GetCursorPos(p);

  // calc left-top coords of lense rect
  x_:=p.X-dm1.CursorHS.X;
  y_:=p.Y-dm1.CursorHS.Y;

  // check left-top coords of lense rect
  if x_ <0 then
    x_:=0
  else
    if x_ >Screen.Width-LenseSize.X then
      x_:=Screen.Width-LenseSize.X;

  if y_ <0 then
    y_:=0
  else
    if y_ >Screen.Height-LenseSize.Y then
      y_:=Screen.Height-LenseSize.Y;

  for y:=y_ to y_+pred(LenseSize.Y) do begin
    a:=fmMain.bmpScr.ScanLine[y];

    for x:=x_ to x_+pred(LenseSize.X) do with Canvas do begin
      Brush.Color:=RGB(a[x].rgbRed,a[x].rgbGreen,a[x].rgbBlue);

      Rectangle(succ((x-x_)*BlockSize.X),
                succ((y-y_)*BlockSize.Y),
                (x-x_)*BlockSize.X+BlockSize.X+2,
                (y-y_)*BlockSize.Y+BlockSize.Y+2);

      if (x =p.X) and (y =p.Y) then
        c:=Brush.Color;
    end; (*FOR x:=x_*)
  end; (*FOR y:=y_*)

  with Canvas do begin
    // draw cursor hot-spot
    Brush.Color:=clRed;
    Pen.Color:=clYellow;
    //Canvas.FrameRect(r);
    //Canvas.FillRect(r);
    Rectangle(succ((p.X-x_)*BlockSize.X),
              succ((p.Y-y_)*BlockSize.Y),
              (p.X-x_)*BlockSize.X+BlockSize.X+2,
              (p.Y-y_)*BlockSize.Y+BlockSize.Y+2);

    // draw the lense edge
    r:=Rect(0,0,Width,Height);
    DrawEdge(Canvas.Handle,r,BDR_RAISEDOUTER,BF_RECT);
    //DrawEdge(Canvas.Handle,r,BDR_SUNKENOUTER,BF_RECT);

    // draw info block
    Brush.Color:=clWindow;
    FillRect(Rect(1,Height-InfoHeight,Width-1,Height-1));

    y:=Height-InfoHeight+1;
    y_:=y+14;
    Font.Style:=[fsBold];
    TextOut(5,y,'XY:');
    TextOut(105,y,'C:');
    if dm1.LenseMode =lm_CaptureMark then
      TextOut(5,y_,'S:');

    Font.Style:=[];
    TextOut(27,y,IntToStr(p.X)+' : '+IntToStr(p.Y));
    TextOut(120,y,'$'+IntToHex(c,6));
    if dm1.LenseMode =lm_CaptureMark then
      TextOut(20,y_,
        IntToStr(dm1.CaptureRect.Left)+','+IntToStr(dm1.CaptureRect.Top)+' - '+
        IntToStr(dm1.CaptureRect.Right)+','+IntToStr(dm1.CaptureRect.Bottom)+' = '+
        IntToStr(dm1.CaptureRect.Right-dm1.CaptureRect.Left+1)+'x'+
        IntToStr(dm1.CaptureRect.Bottom-dm1.CaptureRect.Top+1));
  end; (*WITH Canvas*)
end;

procedure TfmLense.FormCreate(Sender: TObject);
begin
  with DM1.fIni do begin
    BlockSize:=ReadPoint(secLense,keyBlockSize,DefBlockSize);
    LenseSize:=ReadPoint(secLense,keyLenseSize,DefLenseSize);
  end;

  if (BlockSize.X <MinBlockSize.X) or (BlockSize.X >MaxBlockSize.X) then
    BlockSize.X:=DefBlockSize.X;
  if (BlockSize.Y <MinBlockSize.Y) or (BlockSize.Y >MaxBlockSize.Y) then
    BlockSize.Y:=DefBlockSize.Y;

  if (LenseSize.X <MinLenseSize.X) or (LenseSize.X >MaxLenseSize.X) then
    LenseSize.X:=DefLenseSize.X;
  if (LenseSize.Y <MinLenseSize.Y) or (LenseSize.Y >MaxLenseSize.Y) then
    LenseSize.Y:=DefLenseSize.Y;

  Cursor:=crLense;

  CalcLenseSize;
end;

procedure TfmLense.CalcLenseSize;
begin
  SetBounds(0,0,LenseSize.X*BlockSize.X+2,LenseSize.Y*BlockSize.Y+2+InfoHeight);
end;

procedure TfmLense.CalcLensePos;
var
  p:tPoint;

begin
  GetCursorPos(p);

  Top:=0;

  if PtInRect(BoundsRect,p) then
    if Left =0 then
      Left:=Screen.Width-Width
    else
      Left:=0;
end;

procedure TfmLense.FormResize(Sender: TObject);
begin
  CalcLensePos;
end;

procedure TfmLense.FormKeyDown(Sender:tObject; var Key:word; Shift:tShiftState);
begin
  if dm1.LenseMode <>lm_Normal then begin
    fmMain.FormKeyDown(Self,Key,Shift);
    exit;
  end;

  case Key of
    // exit the program
    vk_Escape: fmMain.actExitExecute(nil);

    // set min blocks size
    vk_End: if (BlockSize.X >MinBlockSize.X) or (BlockSize.Y >MinBlockSize.Y) then begin
      IncBlockSize(-1);
      CalcLenseSize;
    end;

    // set max blocks size
    vk_Home: if (BlockSize.X <MaxBlockSize.X) or (BlockSize.Y <MaxBlockSize.Y) then begin
      IncBlockSize(1);
      CalcLenseSize;
    end;

    // decrease width of blocks
    vk_Left: if BlockSize.X >MinBlockSize.X then begin
      Dec(BlockSize.X);
      CalcLenseSize;
    end;

    // descrease height of blocks
    vk_Up: if BlockSize.Y >MinBlockSize.Y then begin
      Dec(BlockSize.Y);
      CalcLenseSize;
    end;

    // increase width of blocks
    vk_Right: if BlockSize.X <MaxBlockSize.X then begin
      Inc(BlockSize.X);
      CalcLenseSize;
    end;

    // increase height of blocks
    vk_Down: if BlockSize.Y <MaxBlockSize.Y then begin
      Inc(BlockSize.Y);
      CalcLenseSize;
    end;

    // Ctrl+F12: activate Capture (part of) Screen mode
    vk_F12: if (Shift =[ssCtrl]) then InitScreenCapture;

    // set default lense blocks size
    vk_Multiply: if (BlockSize.X <>DefBlockSize.X) or (BlockSize.Y <>DefBlockSize.Y) then begin
      BlockSize.X:=DefBlockSize.X;
      BlockSize.Y:=DefBlockSize.Y;
      CalcLenseSize;
    end;

    // gray [+] : increase magnification
    vk_Add: if (BlockSize.X <MaxBlockSize.X) and (BlockSize.Y <MaxBlockSize.Y) then begin
      Inc(BlockSize.X);
      Inc(BlockSize.Y);
      CalcLenseSize;
    end;

    // gray [-] : decrease magnification
    vk_Subtract: if (BlockSize.X >MinBlockSize.X) and (BlockSize.Y >MinBlockSize.Y) then begin
      Dec(BlockSize.X);
      Dec(BlockSize.Y);
      CalcLenseSize;
    end;

    // vk_C: capture lense area to clipboard
    $43: if Shift =[ssCtrl] then fmMain.Capture2Clipboard;

    // vk_S: capture lense area to bitmap file
    $53: if Shift =[ssCtrl] then fmMain.Capture2BmpFile;

  {else
    ShowMessage('KeyCode==$'+IntToHex(Key,4));}
 end; (*CASE Key*)
end;

procedure TfmLense.FormDestroy(Sender: TObject);
begin
  with DM1.fIni do begin
    WritePoint(secLense,keyLenseSize,LenseSize);
    WritePoint(secLense,keyBlockSize,BlockSize);
  end;
end;

procedure TfmLense.IncBlockSize(d:integer);
var
  i1,i2:integer;

begin
  //messagebeep(mb_ok);
  if d <0 then begin
    // decrease blocks size using aspect ratio
    if BlockSize.X <BlockSize.Y then begin
      i1:=BlockSize.X;
      i2:=MinBlockSize.x;
    end
    else begin
      i1:=BlockSize.Y;
      i2:=MinBlockSize.Y;
    end;
  end
  else begin
    // increase blocks size using aspect ratio
    if BlockSize.X >BlockSize.Y then begin
      i1:=BlockSize.X;
      i2:=MaxBlockSize.x;
    end
    else begin
      i1:=BlockSize.Y;
      i2:=MaxBlockSize.Y;
    end;
  end;

  // do it!
  while i1 <>i2 do begin
    Inc(BlockSize.X,d);
    Inc(BlockSize.Y,d);
    Inc(i1,d);
  end;
end;

procedure TfmLense.InitScreenCapture;
begin
  dm1.LenseMode:=lm_Capture;
  dm1.CursorHS:=hsCross;
  Application.MainForm.Cursor:=crCaptureCross;
  Refresh;
end;

procedure TfmLense.DoneScreenCapture;
begin
  dm1.LenseMode:=lm_Normal;
  dm1.CursorHS:=hsLense;
  Application.MainForm.Cursor:=crLense;
  Refresh;
end;

end.

