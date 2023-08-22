unit DatMod1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RxIni;

const
  PID='Lagodrom Screen Lense';
  VID='Version 1.01.01/g0617';
  CID='Copyright 2006-2023 LAGODROM Solutions Ltd.';
  QOD='better fewer, but better';


type
  pRGBTripleArray=^tRGBTripleArray;
  tRGBTripleArray=array[0..32767] of tRGBTriple;

  pRGBQuadArray=^tRGBQuadArray;
  tRGBQuadArray=array[0..32767] of tRGBQuad;

const
  // default lense matrix size in blocks
  DefLenseSize:tPoint=(X:32; Y:32);
  // default width & height of lense block
  DefBlockSize:tPoint=(X:8; Y:8);
  // min lense size
  MinLenseSize:tPoint=(X:16; Y:16);
  // max lense size
  MaxLenseSize:tPoint=(X:32; Y:32);
  // min block width & height
  MinBlockSize:tPoint=(X:4; Y:4);
  // max block width & height
  MaxBlockSize:tPoint=(X:16; Y:16);

  // cursor hot-spots
  hsLense:tPoint=(X:0; Y:0);
  hsCross:tPoint=(X:15; Y:15);

  // lense cursor ID
  crLense=13;
  crCaptureCross=14;

  // infomation footer height for fmLense window
  InfoHeight=32;

  // ini section & key names
  secLense='Lense';
  keyBlockSize='Block size';
  keyLenseSize='Lense size';

type
  tLenseMode=(
    lm_Normal,         // just lense
    lm_Capture,        // full screen capture
    lm_CaptureMark     // marking
  );

type
  TDM1 = class(TDataModule)
    procedure DM1Create(Sender: TObject);
    procedure DM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    fIni:tRxIniFile;
    LenseMode:tLenseMode;

    CursorHS:tPoint;       // current cursor hot-spot
    StartPt:tPoint;        // capturing start point (LenseMode==lm_CaptureMark)
    CaptureRect:tRect;     // capturing rectangle (LenseMode==lm_CaptureMark)
  end;

var
  DM1: TDM1;

implementation

{$R *.DFM}

procedure TDM1.DM1Create(Sender: TObject);
begin
  fIni:=tRxIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  LenseMode:=lm_Normal;
  CursorHS:=hsLense;
end;

procedure TDM1.DM1Destroy(Sender: TObject);
begin
  if Assigned(fIni) then fIni.Free;
end;

end.

