unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg;

type
  TfmAbout = class(TForm)
    panLogo: TPanel;
    imgLogo: TImage;
    Bevel1: TBevel;
    btnOk: TButton;
    lblPID: TLabel;
    lblVID: TLabel;
    lblCID: TLabel;
    sttQOD: TStaticText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  DatMod1;

{$R *.DFM}
{$R Addon.res}

procedure TfmAbout.FormCreate(Sender: TObject);
var
  jpg:tJPEGImage;
  t:tResourceStream;

begin
  lblPID.Caption:=PID;
  lblVID.Caption:=VID;
  lblCID.Caption:=CID;
  sttQOD.Caption:=QOD;

  jpg:=tJPEGImage.Create;
  t:=tResourceStream.Create(hInstance,'Logo_jpg',rt_RcData);
  try
    jpg.LoadFromStream(t);
    imgLogo.Picture.Bitmap.Assign(jpg);
  finally
    t.Free;
    jpg.Free;
  end;
end;

end.

