program ChekAnka;

uses
  Forms,
  uChekAnka in 'uChekAnka.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
