#ifndef VPP_CONSTS_H
#define VPP_CONSTS_H
#include <string>
///templates
//Request template
constexpr std::array<char[],1> slName {"Name"};
constexpr std::array<char[],2> slPkm {"Pokémon", "Pokemon"};
constexpr std::array<char[],1> slEvo {"Fully Evolving"};
constexpr std::array<char[],1> slCount {"Post Count"};
constexpr std::array<char[],2> slHemi {"Northern or Southern Hemisphere", "Hemisphere"};
constexpr std::array<char[],1> slRain {"Own a Rainbow Stone"};
constexpr std::array<char[],1> slPartner {"Partner"};

inline const std:string sYES = "Yes";
inline const std:string sNO = "No";
inline const std:string sNorthern = "Northern";
inline const std:string sSouthern = "Southern";

//template for giving out stuff
inline const std::string sPkmRes = "%s @ %d";
inline const std::string sPkmResTT = "%s: %s @ %d / %s @ %d";
inline const std::string sHATCH = "Hatch @ %d";
inline const std::string sHATCHTT = "Hatch: %s @ %d / %s @ %d";

inline const std::string sLvlMaxEvo = "%s @ Level 100 @ %d";
inline const std::string sLvlMaxEvoTT = "%s @ Level 100: %s @ %d / %s @ %d";
inline const std::string sLvlMaxSingle = "Level 100 @ %d";
inline const std::string sLvlMaxSingleTT = "Level 100: %s @ %d / %s @ %d";

inline const std::string sSHINY = "Shiny: %s";
inline const std::string sPOINTS = "Points: %d";

///key words for data structures
//pkm data
inline const std:string sSpecies = "species";
inline const std:string sType1 = "type1";
inline const std:string sType2 = "type2";
inline const std:string sBaseform = "baseform"; //first stage evo
inline const std:string sCategory = "category"; //normal, legendary, ub, ...

//point association
inline const std:string sTagTeam = "tagteam";
inline const std:string sLegend = "legend";
inline const std:string sUb = "ub";
inline const std:string sPair = "pair"; //pairs and sets have different values
inline const std:string sSet = "set";
inline const std:string sUnown = "unown";
inline const std:string sMega = "mega";
inline const std:string sRegional = "regional";
inline const std:string sDmax = "dmax";

//post association
inline const std:string sClub = "club"; //number of post reduction
inline const std:string sSeasonal = "seasonal";
//stPair
//stSet
//...

//seasonal stuff

//...

///internal structure
//const stPokemon = { "basePkm":"", "finalPkm":"", "startCount":0, "hatchCount":0, "endCount":0, "shiny":"No", "points":0 };

inline const std:string sDelim = ':';

//this is where the actual data is found
inline const std:string sVpp = "../data/vpp.json";
inline const std:string sMeta = "../data/meta.json";

#endif
