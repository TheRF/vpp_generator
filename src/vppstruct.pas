unit vppstruct;

interface

type
  TVppInternal = record
    //from request
    sName;
    sSpecies;
    sTTeam: string;
    vTagTeam: TVppInternal;
    iPost: Integer;
    sHemi: string;
    bClub,
    bStone: Boolean;

    //filling out
    sBase;
    sAssoc: string;
    iPoints,
    iHatch,
    iPostsDone,
    iClubRed: Integer;
    bShiny: Boolean;
  end;

implementation

end.
