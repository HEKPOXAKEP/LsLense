program LsLense;

uses
  Forms,
  Main in 'Main.pas' {fmMain},
  Lense in 'Lense.pas' {fmLense},
  About in 'About.pas' {fmAbout},
  DatMod1 in 'DatMod1.pas' {DM1: TDataModule},
  Props in 'Props.pas' {fmProps},
  Help in 'Help.pas' {fmHelp},
  CaptureTo in 'CaptureTo.pas' {fmCaptureTo};

{$R *.RES}

begin
  Application.Initialize;
  //Application.Title:=PID;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
