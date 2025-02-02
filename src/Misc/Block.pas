unit Block;

interface
uses SysUtils;
  type
    TBlock = class

    private
      typeStr : string;
      startTimeInt : integer;
      endTimeInt : integer;
      answerTimeInt : integer;
      detectedBool : boolean;
      failedBool : boolean;

      function GetType() : string;
      procedure SetType(value : string);
      function GetStartTime() : integer;
      procedure SetStartTime(value : integer);
      function GetEndTime() : integer;
      procedure SetEndTime(value : integer);
      function GetAnswerTime() : integer;
      procedure SetAnswerTime(value : integer);
      function GetStartTimePres() : string;
      function GetEndTimePres() : string;
      function SecondsToTimeFormat(totalSec: Integer) : string;
      function GetDetected() : boolean;
      procedure SetDetected(value : boolean);
      function GetFailed() : boolean;
      procedure SetFailed(value : boolean);
    public
      function IsWithinPlayZone(secsElapsed : integer) : boolean;
      function HasDetectionFailed(secsElapsed : integer) : boolean;
      property BlockType : string read GetType write SetType;
      property StartTime : integer read GetStartTime write SetStartTime;
      property StartTimePres : string read GetStartTimePres;
      property EndTime : integer read GetEndTime write SetEndTime;
      property EndTimePres : string read GetEndTimePres;
      property AnswerTime : integer read GetAnswerTime write SetAnswerTime;
      property Detected : boolean read GetDetected write SetDetected;
      property Failed : boolean read GetFailed write SetFailed;

    end;

implementation

  function TBlock.GetType : string;
  begin
    Result := typeStr;
  end;

  procedure TBlock.SetType(value: string);
  begin
    typeStr := value;
  end;

  function TBlock.GetStartTime : integer;
  begin
    Result := startTimeInt;
  end;

  procedure TBlock.SetStartTime(value: integer);
  begin
    startTimeInt := value;
  end;

  function TBlock.GetAnswerTime;
  begin
    Result := answerTimeInt;
  end;

  procedure TBlock.SetAnswerTime(value: Integer);
  begin
    answerTimeInt := value;
  end;

  function TBlock.GetEndTime;
  begin
    Result := endTimeInt;
  end;

  procedure TBlock.SetEndTime(value: Integer);
  begin
    endTimeInt := value;
  end;

  function TBlock.GetStartTimePres;
  begin
    Result := SecondsToTimeFormat(startTimeInt);
  end;

  function TBlock.GetEndTimePres;
  begin
    Result := SecondsToTimeFormat(endTimeInt);
  end;

  function TBlock.SecondsToTimeFormat(totalSec: Integer) : string;
    var h,m,s : integer;
    var mm, ss : string;
  begin
    h := totalSec div 3600;
    m := totalSec div 60 - h*60;
    s := totalSec - (h*3600 + m*60);

    mm := IntToStr(m);
    ss := IntToStr(s);

    if (m >= 0)and(m<10) then
      mm := '0'+mm;

    if (s >= 0)and(s<10) then
      ss := '0'+ss;

    Result := mm+':'+ss;
  end;

  function TBlock.IsWithinPlayZone(secsElapsed : integer) : boolean;
    var isWithin : boolean;
  begin
    isWithin := false;
    if (secsElapsed >= startTimeInt)and(secsElapsed <= (startTimeInt+answerTimeInt)) then
      isWithin := true;
    Result := isWithin;
  end;

  function TBlock.HasDetectionFailed(secsElapsed: Integer) : boolean;
    var hasFailed : boolean;
  begin
    hasFailed := false;
    if (secsElapsed >= startTimeInt+answerTimeInt) and not detectedBool then
      hasFailed := true;
    Result := hasFailed;
  end;

  function TBlock.GetDetected;
  begin
    Result := detectedBool;
  end;

  procedure TBlock.SetDetected(value: Boolean);
  begin
    detectedBool := value;
  end;

  function TBlock.GetFailed() : boolean;
  begin
    Result := failedBool;
  end;

  procedure TBlock.SetFailed(value: Boolean);
  begin
    failedBool := value;
  end;
end.
