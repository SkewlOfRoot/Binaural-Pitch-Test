unit PatientData;

interface
uses SysUtils;

type
  TPatientData = class

  private
    cprStr : string;
    firstNameStr : string;
    surnameStr : string;
    commentStr : string;
    function GetCpr() : string;
    function GetFirstName() : string;
    function GetSurname() : string;
    function GetComment() : string;
    procedure SetCpr(value : string);
    procedure SetFirstName(value : string);
    procedure SetSurname(value : string);
    procedure SetComment(value : string);
  public
    property Cpr : string read GetCpr write SetCpr;
    property FirstName : string read GetFirstName write SetFirstName;
    property Surname : string read GetSurname write SetSurname;
    property Comment : string read GetComment write SetComment;
  end;

implementation

function TPatientData.GetCpr() : string;
begin
  Result := cprStr;
end;

function TPatientData.GetFirstName() : string;
begin
  Result := firstNameStr;
end;

function TPatientData.GetSurname() : string;
begin
  Result := surnameStr;
end;

function TPatientData.GetComment() : string;
begin
  Result := commentStr;
end;

procedure TPatientData.SetCpr(value: string);
begin
  cprStr := value;
end;

procedure TPatientData.SetFirstName(value: string);
begin
  firstNameStr := value;
end;

procedure TPatientData.SetSurname(value: string);
begin
  surnameStr := value;
end;

procedure TPatientData.SetComment(value: string);
begin
  commentStr := value;
end;
end.

