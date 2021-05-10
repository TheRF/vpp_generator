program vpp_generator;

{$mode DELPHI}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  DlgMain in 'src\DlgMain.pas',
  vppconsts in 'src\vppconsts.pas',
  vppgen in 'src\vppgen.pas',
  vppstruct in 'src\vppstruct.pas',
  jsontools in 'JsonTools\jsontools.pas'
  ;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TVppGenForm, VppGenForm);
  Application.Run;
end.

