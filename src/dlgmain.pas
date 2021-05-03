unit DlgMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnGenerate: TButton;
    cbDebug: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    mmDebug: TMemo;
    mmLeft: TMemo;
    mmRight: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnGenerateClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnGenerateClick(Sender: TObject);
begin
  //
end;

end.

