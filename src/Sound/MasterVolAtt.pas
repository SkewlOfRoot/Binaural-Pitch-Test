unit MasterVolAtt;

interface
uses SysUtils;

  type
    TMasterVolAtt = class
    private
      dbInt : integer;
      soundCardValInt : integer;
      function GetDB() : integer;
      function GetSoundCardVal() : integer;
      function GetDBInSPL() : integer;
      procedure SetDB(value : integer);
      procedure SetSoundCardVal(value : integer);
    public
      property DB : integer read GetDB write SetDB;
      property SoundCardVal : integer read GetSoundCardVal write SetSoundCardVal;
      property DBValInSPL : integer read GetDBInSPL;
  end;

implementation

function TMasterVolAtt.GetDB() : integer;
begin
  Result := dbInt;
end;

procedure TMasterVolAtt.SetDB(value: Integer);
begin
  dbInt := value;
end;

function TMasterVolAtt.GetSoundCardVal() : integer;
begin
  Result := soundCardValInt;
end;

procedure TMasterVolAtt.SetSoundCardVal(value: Integer);
begin
  soundCardValInt := value;
end;

function TMasterVolAtt.GetDBInSPL() : integer;
begin
  Result := dbInt + 55;
end;
end.
