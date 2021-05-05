unit vppgen;

interface

type
  TStringArray = specialize TArray<string>;
  TAStringArray = specialize TArray<TStringArray>;

implementation

uses
  SysUtils, vppconsts, vppstruct, Classes;

//split the line on the deliminator, ignoring whitespaces
//returns array of split line
procedure splitLine(const sLine, sDelim: string;
  var slOut: TStringArray);
var
  iStart, iEnd: Integer;
  var i: Integer;
begin
  iStart := 0;
  iEnd := 0;
  SetLength(slOut, 0);

  slOut := sLine.Split(sDelim);

  for i := 0 to High(slOut) do
    slOut[i] := Trim(slOut[i]);
end;

//generate the template that gets posted
function buildTemplate(const data, dataTagTeam: TVppInternal): TStringArray;
begin
  //species
  SetLength(result, 1);
  if data.vTagTeam<>nil then
    result[High(result)] := format(sPkmResTT,
      [data.sBase, data.sName, data.iPost,
       data.vTagTeam^.sName, data.vTagTeam^.iPost])
  else
    result[High(result)] := format(sPkmRes, [data.sBase, data.iPost]);

  //hatch
  SetLength(result, Length(result)+1);
  if data.vTagTeam<>nil then
    result[High(result)] := format(sHATCHTT,
      [data.sName, data.iPost + data.iHatch,
       data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iHatch])
  else
    result[High(result)] := format(sHATCH, [data.iPost + data.iHatch]);

  //complete
  SetLength(result, Length(result)+1);
  if data.sSpecies=data.sBase then
  begin
    if data.vTagTeam<>nil then
      result[High(result)] := format(sLvlMaxSingleTT, [data.sName,
        data.iPost + data.iPostsDone,
        data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iPostsDone])
    else
      result[High(result)] := format(sLvlMaxSingle,
        [data.iPost + data.iPostsDone]);
  end
  else
  begin
    if data.vTagTeam<>nil then
      result[High(result)] := format(sLvlMaxEvoTT,
        [data.sSpecies, data.sName, data.iPost + data.iPostsDone,
         data.vTagTeam^.sName,
         data.vTagTeam^.iPost + data.vTagTeam^.iPostsDone])
    else
      result[High(result)] := format(sLvlMaxEvo, [data.sSpecies,
        data.iPost + data.iPostsDone]);
  end;

  //shiny
  SetLength(result, Length(result)+1);
  if data.bShiny then
    result[High(result)] := format(sSHINY, [sYES])
  else
    result[High(result)] := format(sSHINY, [sNO]);

  //points
  SetLength(result, Length(result)+1);
  result[High(result)] := format(sPOINTS, [data.iPoints]);
end;

procedure fillEntry(const slLine: TStringArray; var stRet: TVppInternal);
begin
  //TODO
end;

//build up the structure
//return structure with sorted data
function fillStruct(const aInput: TStringArray;
  bClub: Boolean = false): TVppInternal;
var
  stRet: TVppInternal;
  aLine: TStringArray;
  aLines: array of TStringArray;
  i: Integer;
begin
  stRet.bClub := bClub;

  setLength(aLines, 0);
  //split all the values of the lines
  for i := 0 to High(aInput) do
  begin
    splitLine(aInput[i], sDelim, aLine);
    SetLength(aLines, Length(aLines)+1);
    aLines[High(aLines)] := aLine;
  end;

  //fill in the right property from request
  for i := 0 to High(aLine) do
    fillEntry(aLine, stRet);

  //TODO: fill in from files


  result := stRet;
end;

function parseAll(const aInputLeft, aInputRight: TStringArray;
  bClub: Boolean): TStringArray;
var
  stLeftSet, stRightSet: TVppInternal;
begin
  //get the requests as structures
  stLeftSet := FillStruct(aInputLeft, bClub);
  stRightSet := FillStruct(aInputRight, bClub);

  //tag team?
  if (Length(stLeftSet.sTTeam)>0) and
    (stLeftSet.sTTeam=stRightSet.sName) then
  begin
    stLeftSet.vTagTeam := @stRightSet;
    stLeftSet.bClub := false;
  end;

  //build output
  result := buildTemplate(stLeftSet, stRightSet);
end;

end.
