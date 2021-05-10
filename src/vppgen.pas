unit vppgen;

{$mode DELPHI}{$H+}

interface

uses
  Classes;

function parseAll(const slInputLeft, slInputRight: TStringList;
  bClub: Boolean): TStringList;

var
  slDebug: TStringList;

implementation

uses
  SysUtils, vppconsts, vppstruct;

procedure dbMessage(const sMsg: string);
begin
  slDebug.Add(format('%s %s', [sDebugIdent, sMsg]));
end;

//split the line on the deliminator, ignoring whitespaces
//returns array of split line
procedure splitLine(const sLine, sDelim: string;
  const slOut: TStringList);
var
  i: Integer;
  a: TStringArray;
begin
  slOut.Clear;
  a := sLine.Split(sDelim);

  for i := 0 to High(a) do
    slOut.Add(a[i]);

  for i := 0 to slOut.Count-1 do
    slOut[i] := Trim(slOut[i]);
end;

//generate the template that gets posted
function buildTemplate(const data: TVppInternal): TStringList;
begin
  //species
  result := TStringList.Create;

  if data.vTagTeam<>nil then
    result.Add(Format(sPkmResTT,
      [data.sBase, data.sName, data.iPost,
       data.vTagTeam^.sName, data.vTagTeam^.iPost]))
  else
    result.Add(Format(sPkmRes, [data.sBase, data.iPost]));

  //hatch
  if data.vTagTeam<>nil then
    result.Add(Format(sHATCHTT,
      [data.sName, data.iPost + data.iHatch,
       data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iHatch]))
  else
    result.Add(Format(sHATCH, [data.iPost + data.iHatch]));

  //complete
  if data.sSpecies=data.sBase then
  begin
    if data.vTagTeam<>nil then
      result.Add(Format(sLvlMaxSingleTT, [data.sName,
        data.iPost + data.iPostsDone,
        data.vTagTeam^.sName, data.vTagTeam^.iPost +
          data.vTagTeam^.iPostsDone]))
    else
      result.Add(Format(sLvlMaxSingle,
        [data.iPost + data.iPostsDone]));
  end
  else
  begin
    if data.vTagTeam<>nil then
      result.Add(Format(sLvlMaxEvoTT,
        [data.sSpecies, data.sName, data.iPost + data.iPostsDone,
         data.vTagTeam^.sName,
         data.vTagTeam^.iPost + data.vTagTeam^.iPostsDone]))
    else
      result.Add(Format(sLvlMaxEvo, [data.sSpecies,
        data.iPost + data.iPostsDone]));
  end;

  //shiny
  if data.bShiny then
    result.Add(Format(sSHINY, [sYES]))
  else
    result.Add(Format(sSHINY, [sNO]));

  //points
  result.Add(format(sPOINTS, [data.iPoints]));
end;

procedure fillEntry(const slLine: TStringList; var stRet: TVppInternal);
  function IsEqual(const s1, s2: string): Boolean;
  begin
    result := lowercase(s1)=lowercase(s2);
  end;

var
  s: string;
begin
  if slLine.Count<2 then
    Exit;

  //Name
  for s in slName do
    if IsEqual(slLine[0], s) then
    begin
      stRet.sName:=slLine[1];
      break;
    end;

  //Species
  for s in slPkm do
    if IsEqual(slLine[0], s) then
    begin
      stRet.sSpecies:=slLine[1];
      break;
    end;

  //Tag Team
  for s in slPkm do
    if IsEqual(slLine[0], s) then
    begin
      stRet.sTTeam:=slLine[1];
      break;
    end;

  //PostCount
  for s in slPkm do
    if IsEqual(slLine[0], s) then
    begin
      slLine[1] := StringReplace(slLine[1], ',', '', []);
      slLine[1] := StringReplace(slLine[1], '.', '', []);
      stRet.iPost:=StrToInt(slLine[1]);
      break;
    end;

  //Hemisphere
  for s in slPkm do
    if IsEqual(slLine[0], s) then
    begin
      stRet.sHemi:=slLine[1];
      break;
    end;

  //Rainbow Stone
  for s in slPkm do
    if IsEqual(slLine[0], s) then
    begin
      //some people put a '!' at the end so we just look if there is a 'yes'
      stRet.bStone:=AnsiPos(lowercase(sYES), lowercase(slLine[1])>0;
      break;
    end;
end;

//build up the structure
//return structure with sorted data
function fillStruct(const slInput: TStringList;
  bClub: Boolean = false): TVppInternal;
var
  stRet: TVppInternal;
  slLines: TStringList;
  i: Integer;
begin
  stRet.bClub := bClub;
  slLines := TStringList.Create;
  try
    //split all the values of the lines
    for i := 0 to slInput.Count-1 do
    begin
      slLines.AddObject('', TStringList.Create);
      splitLine(slInput[i], sDelim, slLines.Objects[i] as TStringList);
    end;

    //fill in the right property from request
    for i := 0 to slLines.Count-1 do
      fillEntry(slLines.Objects[i] as TStringList, stRet);

    //TODO: fill in from json files



  finally
    for i := 0 to slLines.Count-1 do
      (slLines.Objects[i] as TStringList).Free;
  end;
  result := stRet;
end;

function parseAll(const slInputLeft, slInputRight: TStringList;
  bClub: Boolean): TStringList;
var
  stLeftSet, stRightSet: TVppInternal;
begin
  slDebug.Clear;
  dbMessage('---start debug information---');

  //get the requests as structures
  stLeftSet := FillStruct(slInputLeft, bClub);
  stRightSet := FillStruct(slInputRight, bClub);

  //tag team?
  if (Length(stLeftSet.sTTeam)>0) and
    (stLeftSet.sTTeam=stRightSet.sName) then
  begin
    stLeftSet.vTagTeam := @stRightSet;
    stLeftSet.bClub := false;
    dbMessage('club membership ignored!');
  end;

  //build output
  result := buildTemplate(stLeftSet);

  dbMessage('---end debug information---');
end;

initialization
  slDebug := TStringList.Create;
finalization
  FreeAndNil(slDebug);

end.
