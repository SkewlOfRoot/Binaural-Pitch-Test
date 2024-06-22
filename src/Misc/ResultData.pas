unit ResultData;

interface
uses SysUtils;

type
  TResultData = class
    private
      totalDioticStr : string;
      totalDichoticStr : string;
      correctDioticStr : string;
      correctDichoticStr : string;
      percentDioticStr: string;
      percentDichoticStr : string;
      percentTotalStr : string;
      function GetTotalDiotic() : string;
      function GetTotalDichotic() : string;
      function GetCorrectDiotic() : string;
      function GetCorrectDichotic() : string;
      function GetPercentDiotic() : string;
      function GetPercentDichotic() : string;
      function GetPercentTotal() : string;
      procedure SetTotalDiotic(value : string);
      procedure SetTotalDichotic(value : string);
      procedure SetCorrectDiotic(value : string);
      procedure SetCorrectDichotic(value :string);
      procedure SetPercentDiotic(value : string);
      procedure SetPercentDichotic(value : string);
      procedure SetPercentTotal(value : string);
    public
      property TotalDiotic : string read GetTotalDiotic write SetTotalDiotic;
      property TotalDichotic : string read GetTotalDichotic write SetTotalDichotic;
      property CorrectDiotic : string read GetCorrectDiotic write SetCorrectDiotic;
      property CorrectDichotic : string read GetCorrectDichotic write SetCorrectDichotic;
      property PercentDiotic : string read GetPercentDiotic write SetPercentDiotic;
      property PercentDichotic : string read GetPercentDichotic write SetPercentDichotic;
      property PercentTotal : string read GetPercentTotal write SetPercentTotal;
  end;

implementation

//Functions
function TResultData.GetTotalDiotic() : string;
begin
  Result := totalDioticStr;
end;

function TResultData.GetTotalDichotic() : string;
begin
  Result := totalDichoticStr;
end;

function TResultData.GetCorrectDiotic() : string;
begin
  Result := correctDioticStr;
end;

function TResultData.GetCorrectDichotic() : string;
begin
  Result := correctDichoticStr;
end;

function TResultData.GetPercentDiotic() : string;
begin
  Result := percentDioticStr;
end;

function TResultData.GetPercentDichotic() : string;
begin
  Result := percentDichoticStr;
end;

function TResultData.GetPercentTotal() : string;
begin
  Result := percentTotalStr;
end;

//Procedures
procedure TResultData.SetTotalDiotic(value: string);
begin
  totalDioticStr := value;
end;

procedure TResultData.SetTotalDichotic(value: string);
begin
  totalDichoticStr := value;
end;

procedure TResultData.SetCorrectDiotic(value: string);
begin
  correctDioticStr := value;
end;

procedure TResultData.SetCorrectDichotic(value: string);
begin
  correctDichoticStr := value;
end;

procedure TResultData.SetPercentDiotic(value: string);
begin
  percentDioticStr := value;
end;

procedure TResultData.SetPercentDichotic(value: string);
begin
  percentDichoticStr := value;
end;

procedure TResultData.SetPercentTotal(value: string);
begin
  percentTotalStr := value;
end;
end.
