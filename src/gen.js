///templates
//Request template
const tName = ["Name"]
const tPkm = ["Pokémon", "Pokemon"];
const tEvo = ["Fully Evolving"];
const tCount = ["Post Count"];
const tHemi = ["Northern or Southern Hemisphere", "Hemisphere"];
const tRain = ["Own a Rainbow Stone"];
const tPartner = ["Partner"];

const tYes = "Yes";
const tNo = "No";
const tNorthern = "Northern";
const tSouthern = "Southern";

//template for giving out stuff
const tPkmRes = "_ @ &";
const tHatch = "Hatch @ _";
const tLvlMax1 = "_ @ Level 100: &";
const tLvlMax2 = "Level 100 @ _";
const tShiny = "Shiny: _";
const tPoints = "Points: _";

///key words for data structures
//pkm data
const stSpecies = "species";
const stType1 = "type1";
const stType2 = "type2";
const stBaseform = "baseform"; //first stage evo
const stCategory = "category"; //normal, legendary, ub, ...

//point association
const stTagTeam = "tagteam";
const stLegend = "legend";
const stUb = "ub";
const stPair = "pair"; //pairs and sets have different values
const stSet = "set";
const stUnown = "unown";
const stMega = "mega";
const stRegional = "regional";
const stDmax = "dmax";

//post association
const stClub = "club"; //number of post reduction
const stSeasonal = "seasonal";
//stPair
//stSet
//...

//seasonal stuff

//...

///internal structure
//const stPokemon = { "basePkm":"", "finalPkm":"", "startCount":0, "hatchCount":0, "endCount":0, "shiny":"No", "points":0 };

const stDelim = ":"

//this is where the actual data is found
const pVpp = "../data/vpp.json";
const pMeta = "../data/meta.json";

//split the line on the deliminator
//returns array of split line
function SplitLine(sLine, sDelim) {
  //do the splitting
  var slLine = sLine.split(sDelim);

  //trim white space
  for (var i = slLine.length - 1; i >= 0; i--) {
    slLine[i] = slLine[i].trim();
  }

  return slLine;
}

//build up the structure
function FillStruct(sText) {
  //do the splitting
  var slLine = sLine.split(sDelim);

  //trim white space
  for (var i = slLine.length - 1; i >= 0; i--) {
    slLine[i] = slLine[i].trim();
  }

  return slLine;
}

const taLeft = "taLeft";
const taLeft = "taRight";
function ParseAll(){
  var slText1 = document.getElementById(taLeft).value.split("\n");
  var slText2 = document.getElementById(taRight).value.split("\n");
}