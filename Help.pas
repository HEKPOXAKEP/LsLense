unit Help;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxRichEd, Placemnt;

type
  TfmHelp = class(TForm)
    Bevel1: TBevel;
    btnOk: TButton;
    redHelp: TRxRichEdit;
    fsHelp: TFormStorage;
    procedure FormCreate(Sender: TObject);
  private
    procedure LoadHelp;
  public
    { Public declarations }
  end;

implementation

uses
  DatMod1;

{$R *.DFM}

procedure TfmHelp.FormCreate(Sender: TObject);
begin
  fsHelp.IniFileName:=dm1.fIni.FileName;
  LoadHelp;
end;

procedure TfmHelp.LoadHelp;
var
  st:tResourceStream;

begin
  st:=tResourceStream.Create(hInstance,'Help_Rtf','RTF');
  try
    redHelp.Lines.LoadFromStream(st);
    redHelp.Modified:=false;
  finally
    st.Free;
  end; (*TRY*)
end;

end.

