unit Help;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxRichEd, Placemnt;

type
  TfmHelp = class(TForm)
    fsHelp: TFormStorage;
    redHelp: TRxRichEdit;
    btnOk: TButton;
    procedure FormCreate(Sender: TObject);
  private
    procedure LoadHelp;
  public
    { Public declarations }
  end;

implementation

uses
  //LsFormScale,
  DatMod1;

{$R *.DFM}

procedure TfmHelp.FormCreate(Sender: TObject);
begin
  //DoAutoScale(Self);
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

