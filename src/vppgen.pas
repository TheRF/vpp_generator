unit vppgen;

interface

type
  TStringArray = specialize TArray<string>;
  TAStringArray = specialize TArray<TStringArray>;

implementation

//split the line on the deliminator, ignoring whitespaces
//returns array of split line
procedure splitLine(const sLine, sDelim: string;
  var slOut: TAStringArray);
var
  iStart, iEnd: Integer;
begin
  iStart := 0;
  iEnd := 0;

  while ((start = str.find_first_not_of(delim, end)) != string::npos)
  begin
      end = str.find(delim, start);
      slOut.push_back(str.substr(start, end - start));
  end

  //trim white space
  for var i: Integer = 0 to slLine.Count-1 do
  begin
    slOut[i] = slOut[i].trim();
  end
end;

//generate the template that gets posted
function buildTemplate(const data VppInternal; const sl: TStringList);
begin
  sl.Clear;

  //species
  if data.vTagTeam<>nil then
    sl.Add(format(sPkmResTT, data.sBase, data.sName, data.iPost,
      data.vTagTeam.sName, data.vTagTeam.iPost));
  else
    vRet.push_back(format(sPkmRes, data.sBase, data.iPost));

  //hatch
  if(data.vTagTeam)
    sl.Add(format(sHATCHTT, data.sName, data.iPost + data.iHatch,
      data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iHatch));
  else
    sl.Add(format(sHATCH, data.iPost + data.iHatch));

  //complete
  if data.sSpecies.compare(data.sBase)=0 then
  begin
    if(data.vTagTeam) then
      vRet.push_back(format(sLvlMaxSingleTT, data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iPostsDone))
    else
      vRet.push_back(format(sLvlMaxSingle, data.iPost + data.iPostsDone));
  end
  else
  begin
    if(data.vTagTeam)
      vRet.push_back(format(sLvlMaxEvoTT, data.sSpecies, data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iPostsDone));
    else
      vRet.push_back(format(sLvlMaxEvo, data.sSpecies, data.iPost + data.iPostsDone));
  end;

  //shiny
  vRet.push_back(format(sSHINY, data.bShiny ? sYES : sNO));

  //points
  vRet.push_back(format(sPOINTS, data.iPoints));
end;

void fillEntry(TStringList &slLine, VppInternal &stRet)
begin
  //TODO
end

//build up the structure
//return structure with sorted data
VppInternal fillStruct(const TStringList slInput,
  bool bClub = false)
begin
  VppInternal stRet;
  stRet.bClub = bClub;

  //split all the values of the lines
  vector<TStringList> slLine;
  for (var i = 0; i < slInput.length(); i++) begin
    splitLine(slInput[i], stDelim, slLine);
  end

  //fill in the right property from request
  for(size_t i=0; i<slLine.length(); i++)
  begin
    fillEntry(slLine, stRet);
  end

  //TODO: fill in from files


  return stRet;
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
