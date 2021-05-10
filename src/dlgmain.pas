unit DlgMain;

{$mode DELPHI}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TVppGenForm }

  TVppGenForm = class(TForm)
    btnGenerate: TButton;
    cbDebug: TCheckBox;
    cbClub: TCheckBox;
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
  Inifiles, StrUtils, lcltype, vppgen, vppconsts;

{ TVppGenForm }

procedure TVppGenForm.btnGenerateClick(Sender: TObject);
  function GetLinesFromMemo(const mm: TMemo): TStringList;
  var
    s: string;
  begin
    result := TStringList.Create;

    for s in mm.Lines do
      result.Add(s);
  end;
var
  i: Integer;
  slLeft, slRight, slOut: TStringList;
begin
  mmDebug.Clear;

  //Generate VPP
  slLeft := GetLinesFromMemo(mmLeft);
  slRight := GetLinesFromMemo(mmRight);
  try
    slOut := parseAll(slLeft, slRight, cbClub.Checked);
    try
      //show debug stuff
      if cbDebug.Checked then
      begin
        mmDebug.Lines.Add('Debug Information:');
        for i:=0 to slDebug.Count-1 do
          mmDebug.Lines.Add(slDebug[i]);
        mmDebug.Lines.Add('');
      end;

      //show vpp
      mmDebug.Lines.Add('VPP Information:');
      for i := 0 to slOut.Count-1 do
        if not StartsStr(sDebugIdent, slOut[i]) then
          mmDebug.Lines.Add(slOut[i]);
    finally
      FreeAndNil(slOut);
    end;
  finally
    FreeAndNil(slRight);
    FreeAndNil(slLeft);
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

