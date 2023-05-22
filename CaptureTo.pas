unit CaptureTo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, ExtCtrls;

type
  TfmCaptureTo = class(TForm)
    rgrpCaptureTo: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
    fsCaptureTo: TFormStorage;
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

procedure TfmCaptureTo.FormCreate(Sender: TObject);
begin
  fsCaptureTo.IniFileName:=dm1.fIni.FileName;
end;

end.
