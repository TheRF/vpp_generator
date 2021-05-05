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
procedure buildTemplate(const data: TVppInternal; const sl: TStringList;
  const dataTagTeam: TVppInternal);
begin
  sl.Clear;

  //species
  if data.vTagTeam<>nil then
    sl.Add(format(sPkmResTT, [data.sBase, data.sName, data.iPost,
      data.vTagTeam^.sName, data.vTagTeam^.iPost]))
  else
    sl.Add(format(sPkmRes, [data.sBase, data.iPost]));

  //hatch
  if data.vTagTeam<>nil then
    sl.Add(format(sHATCHTT, [data.sName, data.iPost + data.iHatch,
      data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iHatch]))
  else
    sl.Add(format(sHATCH, [data.iPost + data.iHatch]));

  //complete
  if data.sSpecies=data.sBase then
  begin
    if data.vTagTeam<>nil then
      sl.Add(format(sLvlMaxSingleTT, [data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iPostsDone]))
    else
      sl.Add(format(sLvlMaxSingle, [data.iPost + data.iPostsDone]));
  end
  else
  begin
    if data.vTagTeam<>nil then
      sl.Add(format(sLvlMaxEvoTT, [data.sSpecies, data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam^.sName, data.vTagTeam^.iPost + data.vTagTeam^.iPostsDone]))
    else
      sl.Add(format(sLvlMaxEvo, [data.sSpecies, data.iPost + data.iPostsDone]));
  end;

  //shiny
  if data.bShiny then
    sl.Add(format(sSHINY, [sYES]))
  else
    sl.Add(format(sSHINY, [sNO]));

  //points
  sl.Add(format(sPOINTS, [data.iPoints]));
end;

procedure fillEntry(const slLine: TStringList; var stRet: TVppInternal);
begin
  //TODO
end;

//build up the structure
//return structure with sorted data
function fillStruct(const slInput: TStringList;
  bClub: Boolean = false): TVppInternal;
var
  stRet: TVppInternal;
  aLine: TStringArray;
  aLines: array of TStringArray;
  i: Integer;
begin
  stRet.bClub := bClub;

  //split all the values of the lines
  for i := 0 to slInput.Count-1 do
  begin
    splitLine(slInput[i], sDelim, aLine);
    aLines := aLines + [aLine];
  end;

  //fill in the right property from request
  for i := 0 to aLine.Count-1 do
    fillEntry(aLine, stRet);

  //TODO: fill in from files


  result := stRet;
end

TStringList parseAll(const TStringList &slInputLeft,
  const TStringList &slInputRight, bool bClub)
begin
  //get the requests as structures
  VppInternal stLeftSet = FillStruct(slInputLeft);
  VppInternal stRightSet = FillStruct(slInputRight);

  //tag team?
  if(stLeftSet.sTagTeam.length()>0 && slInputLeft.sTTeam.equals(stRightSet.sName)) then
  begin
    stLeftSet.vTagTeam = &stRightSet;
    stLeftSet.bClub = false;
  end

  //build output
  TStringList vRet = buildTemplate(stLeftSet);

  //return output
  return vRet;
end

end.
