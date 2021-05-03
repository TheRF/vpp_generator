unit vppconsts;

interface
///templates
//Request template
const slName: array[0..0] of string = ('Name');
const slPkm: array[0..1] of string = ('Pokémon', 'Pokemon');
const slEvo: array[0..0] of string = ('Fully Evolving');
const slCount: array[0..0] of string = ('Post Count');
const slHemi: array[0..1] of string = ('Northern or Southern Hemisphere', 'Hemisphere');
const slRain: array[0..0] of string = ('Own a Rainbow Stone');
const slPartner: array[0..0] of string = ('Partner');

const sYES = 'Yes';
const sNO = 'No';
const sNorthern = 'Northern';
const sSouthern = 'Southern';

//template for giving out stuff
const sPkmRes = '%s @ %d';
const sPkmResTT = '%s: %s @ %d / %s @ %d';
const sHATCH = 'Hatch @ %d';
const sHATCHTT = 'Hatch: %s @ %d / %s @ %d';

const sLvlMaxEvo = '%s @ Level 100 @ %d';
const sLvlMaxEvoTT = '%s @ Level 100: %s @ %d / %s @ %d';
const sLvlMaxSingle = 'Level 100 @ %d';
const sLvlMaxSingleTT = 'Level 100: %s @ %d / %s @ %d';

const sSHINY = 'Shiny: %s';
const sPOINTS = 'Points: %d';

///key words for data structures
//pkm data
const sSpecies = 'species';
const sType1 = 'type1';
const sType2 = 'type2';
const sBaseform = 'baseform'; //first stage evo
const sCategory = 'category'; //normal, legendary, ub, ...

//point association
const sTagTeam = 'tagteam';
const sLegend = 'legend';
const sUb = 'ub';
const sPair = 'pair'; //pairs and sets have different values
const sSet = 'set';
const sUnown = 'unown';
const sMega = 'mega';
const sRegional = 'regional';
const sDmax = 'dmax';

//post association
const sClub = 'club'; //number of post reduction
const sSeasonal = 'seasonal';
//stPair
//stSet
//...

//seasonal stuff

//...

///internal structure
//const stPokemon = { 'basePkm':'', 'finalPkm':'', 'startCount':0, 'hatchCount':0, 'endCount':0, 'shiny':'No', 'points':0 };

const sDelim = ':';

//this is where the actual data is found
const sVpp = '../data/vpp.json';
const sMeta = '../data/meta.json';

implementation

end.
