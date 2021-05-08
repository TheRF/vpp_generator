unit DlgMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TVppGenForm }

  TVppGenForm = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public

  end;

var
  VppGenForm: TVppGenForm;

implementation

{$R *.lfm}

uses
  Inifiles, lcltype;

{ TVppGenForm }

procedure TVppGenForm.btnGenerateClick(Sender: TObject);
var
  i: Integer;
begin
  //Generate VPP

  //show debug stuff
  if cbDebug.Checked then
  begin
    for i:=0 to slOutput.Count()-1 do
    begin

    end;
  end;

  //show vpp
  for i := 0 to slOutput.Count()-1 do
  begin

  end;

end;

const
  APP_SEC = 'General';
  APP_TOP = 'top';
  APP_LEFT = 'left';
  APP_WIDTH = 'width';
  APP_HEIGHT = 'height';

  INI_EXT = '.ini';

procedure TVppGenForm.FormCreate(Sender: TObject);
var
  sIni: string;
  iniConfig: TIniFile;
begin
  //properly position the window
  sIni := ApplicationName()+INI_EXT;

  iniConfig := TIniFile.Create(sIni);
  try
    Top := iniConfig.ReadInteger(APP_SEC, APP_TOP, Top);
    Left := iniConfig.ReadInteger(APP_SEC, APP_LEFT, Left);
    Width := iniConfig.ReadInteger(APP_SEC, APP_WIDTH, Width);
    Height := iniConfig.ReadInteger(APP_SEC, APP_HEIGHT, Height);
  finally
    FreeAndNil(iniConfig);
  end;

  MakeFullyVisible();
end;

procedure TVppGenForm.FormDestroy(Sender: TObject);
var
  sIni: string;
  iniConfig: TIniFile;
begin
  //save the window position
  sIni := ApplicationName()+INI_EXT;

  iniConfig := TIniFile.Create(sIni);
  try
    //keep 4k monitors in mind
    iniConfig.WriteInteger(APP_SEC, APP_TOP, Top);
    iniConfig.WriteInteger(APP_SEC, APP_LEFT, Left);
    iniConfig.WriteInteger(APP_SEC, APP_WIDTH,
      MulDiv(Width, 96, Screen.PixelsPerInch));
    iniConfig.WriteInteger(APP_SEC, APP_HEIGHT,
      MulDiv(Top, 96, Screen.PixelsPerInch));
  finally
    FreeAndNil(iniConfig);
  end;
end;

end.

