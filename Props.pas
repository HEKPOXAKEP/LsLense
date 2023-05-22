(*
  He-he, not implemented yet ;-)
*)
unit Props;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfmProps = class(TForm)
    PageControl1: TPageControl;
    btnOk: TButton;
    btnCancel: TButton;
    TabSheet1: TTabSheet;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfmProps.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TfmProps.btnOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
