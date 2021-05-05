unit vppstruct;

interface

type
  PVppInternal = ^TVppInternal;
  TVppInternal = record
    //from request
    sName,
    sSpecies,
    sTTeam: string;
    vTagTeam: PVppInternal;
    iPost: Integer;
    sHemi: string;
    bClub,
    bStone: Boolean;

    //filling out
    sBase,
    sAssoc: string;
    iPoints,
    iHatch,
    iPostsDone,
    iClubRed: Integer;
    bShiny: Boolean;
  end;

implementation

end.
