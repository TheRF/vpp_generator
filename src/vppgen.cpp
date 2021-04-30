#include "../inc/vppgen.hpp"
#include "../inc/vppconsts.hpp"
#include "../inc/vppstruct.hpp"
#include <string>
#include <vector>

//split the line on the deliminator, ignoring whitespaces
//returns array of split line
void splitLine(const std::string sLine, const char sDelim,
  std::vector<std::vectors<std::string>> &slOut) {
  size_t start;
  size_t end = 0;

  while ((start = str.find_first_not_of(delim, end)) != std::string::npos)
  {
      end = str.find(delim, start);
      slOut.push_back(str.substr(start, end - start));
  }

  //trim white space
  for (size_t i = 0; i < slLine.length(); i++) {
    slOut[i] = slOut[i].trim();
  }
}

//generate the template that gets posted
std::vector<std::string> buildTemplate(const VppInternal &data){
  std::vector<std::string> vRet;

  //species
  if(data.vTagTeam)
    vRet.push_back(std::format(sPkmResTT, data.sBase, data.sName, data.iPost,
      data.vTagTeam.sName, data.vTagTeam.iPost));
  else
    vRet.push_back(std::format(sPkmRes, data.sBase, data.iPost));

  //hatch
  if(data.vTagTeam)
    vRet.push_back(std::format(sHATCHTT, data.sName, data.iPost + data.iHatch,
      data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iHatch));
  else
    vRet.push_back(std::format(sHATCH, data.iPost + data.iHatch));

  //complete
  if(data.sSpecies.compare(data.sBase)==0){
    if(data.vTagTeam)
      vRet.push_back(std::format(sLvlMaxSingleTT, data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iPostsDone));
    else
      vRet.push_back(std::format(sLvlMaxSingle, data.iPost + data.iPostsDone));
  }
  else{
    if(data.vTagTeam)
      vRet.push_back(std::format(sLvlMaxEvoTT, data.sSpecies, data.sName, data.iPost + data.iPostsDone,
        data.vTagTeam.sName, data.vTagTeam.iPost + data.vTagTeam.iPostsDone));
    else
      vRet.push_back(std::format(sLvlMaxEvo, data.sSpecies, data.iPost + data.iPostsDone));
  }

  //shiny
  vRet.push_back(std::format(sSHINY, data.bShiny ? sYES : sNO));

  //points
  vRet.push_back(std::format(sPOINTS, data.iPoints));
}

void fillEntry(std::vector<std::string> &slLine, VppInternal &stRet){
  //TODO
}

//build up the structure
//return structure with sorted data
VppInternal fillStruct(const std::vector<std::string> slInput,
  bool bClub = false) {
  VppInternal stRet;
  stRet.bClub = bClub;

  //split all the values of the lines
  std::vector<std::vector<std::string>> slLine;
  for (var i = 0; i < slInput.length(); i++) {
    splitLine(slInput[i], stDelim, slLine);
  }

  //fill in the right property from request
  for(size_t i=0; i<slLine.length(); i++){
    fillEntry(slLine, stRet);
  }

  //TODO: fill in from files


  return stRet;
}

std::vector<std::string> parseAll(const std::vector<std::string> &slInputLeft,
  const std::vector<std::string> &slInputRight, bool bClub){
  //get the requests as structures
  VppInternal stLeftSet = FillStruct(slInputLeft);
  VppInternal stRightSet = FillStruct(slInputRight);

  //tag team?
  if(stLeftSet.sTagTeam.length()>0 && slInputLeft.sTTeam.equals(stRightSet.sName)){
    stLeftSet.vTagTeam = &stRightSet;
    stLeftSet.bClub = false;
  }

  //build output
  std::vector<std::string> vRet = buildTemplate(stLeftSet);

  //return output
  return vRet;
}