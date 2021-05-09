unit vppgen;

{$mode DELPHI}{$H+}

interface

uses
  Classes;

function parseAll(const slInputLeft, slInputRight: TStringList;
  bClub: Boolean): TStringList;

implementation

uses
  SysUtils, vppconsts, vppstruct;

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
var
  s: string;
begin
  //TODO
  if slLine.Count<2 then
    Exit;

  //go through all the keywords
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

    //TODO: fill in from files



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
  //get the requests as structures
  stLeftSet := FillStruct(slInputLeft, bClub);
  stRightSet := FillStruct(slInputRight, bClub);

  //tag team?
  if (Length(stLeftSet.sTTeam)>0) and
    (stLeftSet.sTTeam=stRightSet.sName) then
  begin
    stLeftSet.vTagTeam := @stRightSet;
    stLeftSet.bClub := false;
  end;

  //build output
  result := buildTemplate(stLeftSet);
end;

end.
