
{************************************************************************}
{                                                                        }
{                            XML Data Binding                            }
{                                                                        }
{         Generated on: 16-10-2008 13:43:36                              }
{       Generated from: C:\DetectionTest\Results\BinauralPitchTest.xml   }
{                                                                        }
{************************************************************************}

unit BinauralPitchTest;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLBinauralPitchTestType = interface;
  IXMLResultsType = interface;
  IXMLBlockResultsType = interface;
  IXMLBlockResultType = interface;
  IXMLPatientInfoType = interface;
  IXMLTestConstructType = interface;
  IXMLBlocksType = interface;
  IXMLBlockType = interface;

{ IXMLBinauralPitchTestType }

  IXMLBinauralPitchTestType = interface(IXMLNode)
    ['{61D73BB7-5540-41CF-9A0A-05EBD700B9BA}']
    { Property Accessors }
    function Get_Results: IXMLResultsType;
    function Get_PatientInfo: IXMLPatientInfoType;
    function Get_TestConstruct: IXMLTestConstructType;
    { Methods & Properties }
    property Results: IXMLResultsType read Get_Results;
    property PatientInfo: IXMLPatientInfoType read Get_PatientInfo;
    property TestConstruct: IXMLTestConstructType read Get_TestConstruct;
  end;

{ IXMLResultsType }

  IXMLResultsType = interface(IXMLNode)
    ['{A1D8AF96-8C6A-407C-BE5E-B1F42A33647D}']
    { Property Accessors }
    function Get_TotalDioticInTest: Integer;
    function Get_TotalDichoticInTest: Integer;
    function Get_CorrectDiotic: Integer;
    function Get_CorrectDichotic: Integer;
    function Get_PercentDiotic: Integer;
    function Get_PercentDichotic: Integer;
    function Get_PercentTotal: Integer;
    function Get_BlockResults: IXMLBlockResultsType;
    procedure Set_TotalDioticInTest(Value: Integer);
    procedure Set_TotalDichoticInTest(Value: Integer);
    procedure Set_CorrectDiotic(Value: Integer);
    procedure Set_CorrectDichotic(Value: Integer);
    procedure Set_PercentDiotic(Value: Integer);
    procedure Set_PercentDichotic(Value: Integer);
    procedure Set_PercentTotal(Value: Integer);
    { Methods & Properties }
    property TotalDioticInTest: Integer read Get_TotalDioticInTest write Set_TotalDioticInTest;
    property TotalDichoticInTest: Integer read Get_TotalDichoticInTest write Set_TotalDichoticInTest;
    property CorrectDiotic: Integer read Get_CorrectDiotic write Set_CorrectDiotic;
    property CorrectDichotic: Integer read Get_CorrectDichotic write Set_CorrectDichotic;
    property PercentDiotic: Integer read Get_PercentDiotic write Set_PercentDiotic;
    property PercentDichotic: Integer read Get_PercentDichotic write Set_PercentDichotic;
    property PercentTotal: Integer read Get_PercentTotal write Set_PercentTotal;
    property BlockResults: IXMLBlockResultsType read Get_BlockResults;
  end;

{ IXMLBlockResultsType }

  IXMLBlockResultsType = interface(IXMLNodeCollection)
    ['{2B35CD54-39E2-42FA-A365-C06B6726749F}']
    { Property Accessors }
    function Get_BlockResult(Index: Integer): IXMLBlockResultType;
    { Methods & Properties }
    function Add: IXMLBlockResultType;
    function Insert(const Index: Integer): IXMLBlockResultType;
    property BlockResult[Index: Integer]: IXMLBlockResultType read Get_BlockResult; default;
  end;

{ IXMLBlockResultType }

  IXMLBlockResultType = interface(IXMLNode)
    ['{19FE01E0-9C64-4F2A-8A5A-441B581405AB}']
    { Property Accessors }
    function Get_Element: Integer;
    function Get_Correct: Boolean;
    function Get_Failed: Boolean;
    procedure Set_Element(Value: Integer);
    procedure Set_Correct(Value: Boolean);
    procedure Set_Failed(Value: Boolean);
    { Methods & Properties }
    property Element: Integer read Get_Element write Set_Element;
    property Correct: Boolean read Get_Correct write Set_Correct;
    property Failed: Boolean read Get_Failed write Set_Failed;
  end;

{ IXMLPatientInfoType }

  IXMLPatientInfoType = interface(IXMLNode)
    ['{DBA73EA7-3A94-489B-93CB-070A9F5CB137}']
    { Property Accessors }
    function Get_Cpr: string;
    function Get_Firstname: WideString;
    function Get_Surname: WideString;
    function Get_Comment: WideString;
    procedure Set_Cpr(Value: string);
    procedure Set_Firstname(Value: WideString);
    procedure Set_Surname(Value: WideString);
    procedure Set_Comment(Value: WideString);
    { Methods & Properties }
    property Cpr: string read Get_Cpr write Set_Cpr;
    property Firstname: WideString read Get_Firstname write Set_Firstname;
    property Surname: WideString read Get_Surname write Set_Surname;
    property Comment: WideString read Get_Comment write Set_Comment;
  end;

{ IXMLTestConstructType }

  IXMLTestConstructType = interface(IXMLNode)
    ['{B14DD21E-08B7-43EE-AA8B-59DFB55A0FD5}']
    { Property Accessors }
    function Get_WaveFile: WideString;
    function Get_Blocks: IXMLBlocksType;
    procedure Set_WaveFile(Value: WideString);
    { Methods & Properties }
    property WaveFile: WideString read Get_WaveFile write Set_WaveFile;
    property Blocks: IXMLBlocksType read Get_Blocks;
  end;

{ IXMLBlocksType }

  IXMLBlocksType = interface(IXMLNodeCollection)
    ['{FE4C6D36-C529-4D1A-A9A9-EC405D354788}']
    { Property Accessors }
    function Get_Block(Index: Integer): IXMLBlockType;
    { Methods & Properties }
    function Add: IXMLBlockType;
    function Insert(const Index: Integer): IXMLBlockType;
    property Block[Index: Integer]: IXMLBlockType read Get_Block; default;
  end;

{ IXMLBlockType }

  IXMLBlockType = interface(IXMLNode)
    ['{648D505F-9959-44A4-92F4-B314FA9DFF7C}']
    { Property Accessors }
    function Get_Type_: WideString;
    function Get_Element: Integer;
    function Get_AnswerTime: Integer;
    function Get_StartTime: Integer;
    function Get_EndTime: Integer;
    procedure Set_Type_(Value: WideString);
    procedure Set_Element(Value: Integer);
    procedure Set_AnswerTime(Value: Integer);
    procedure Set_StartTime(Value: Integer);
    procedure Set_EndTime(Value: Integer);
    { Methods & Properties }
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Element: Integer read Get_Element write Set_Element;
    property AnswerTime: Integer read Get_AnswerTime write Set_AnswerTime;
    property StartTime: Integer read Get_StartTime write Set_StartTime;
    property EndTime: Integer read Get_EndTime write Set_EndTime;
  end;

{ Forward Decls }

  TXMLBinauralPitchTestType = class;
  TXMLResultsType = class;
  TXMLBlockResultsType = class;
  TXMLBlockResultType = class;
  TXMLPatientInfoType = class;
  TXMLTestConstructType = class;
  TXMLBlocksType = class;
  TXMLBlockType = class;

{ TXMLBinauralPitchTestType }

  TXMLBinauralPitchTestType = class(TXMLNode, IXMLBinauralPitchTestType)
  protected
    { IXMLBinauralPitchTestType }
    function Get_Results: IXMLResultsType;
    function Get_PatientInfo: IXMLPatientInfoType;
    function Get_TestConstruct: IXMLTestConstructType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLResultsType }

  TXMLResultsType = class(TXMLNode, IXMLResultsType)
  protected
    { IXMLResultsType }
    function Get_TotalDioticInTest: Integer;
    function Get_TotalDichoticInTest: Integer;
    function Get_CorrectDiotic: Integer;
    function Get_CorrectDichotic: Integer;
    function Get_PercentDiotic: Integer;
    function Get_PercentDichotic: Integer;
    function Get_PercentTotal: Integer;
    function Get_BlockResults: IXMLBlockResultsType;
    procedure Set_TotalDioticInTest(Value: Integer);
    procedure Set_TotalDichoticInTest(Value: Integer);
    procedure Set_CorrectDiotic(Value: Integer);
    procedure Set_CorrectDichotic(Value: Integer);
    procedure Set_PercentDiotic(Value: Integer);
    procedure Set_PercentDichotic(Value: Integer);
    procedure Set_PercentTotal(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBlockResultsType }

  TXMLBlockResultsType = class(TXMLNodeCollection, IXMLBlockResultsType)
  protected
    { IXMLBlockResultsType }
    function Get_BlockResult(Index: Integer): IXMLBlockResultType;
    function Add: IXMLBlockResultType;
    function Insert(const Index: Integer): IXMLBlockResultType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBlockResultType }

  TXMLBlockResultType = class(TXMLNode, IXMLBlockResultType)
  protected
    { IXMLBlockResultType }
    function Get_Element: Integer;
    function Get_Correct: Boolean;
    function Get_Failed: Boolean;
    procedure Set_Element(Value: Integer);
    procedure Set_Correct(Value: Boolean);
    procedure Set_Failed(Value: Boolean);
  end;

{ TXMLPatientInfoType }

  TXMLPatientInfoType = class(TXMLNode, IXMLPatientInfoType)
  protected
    { IXMLPatientInfoType }
    function Get_Cpr: string;
    function Get_Firstname: WideString;
    function Get_Surname: WideString;
    function Get_Comment: WideString;
    procedure Set_Cpr(Value: string);
    procedure Set_Firstname(Value: WideString);
    procedure Set_Surname(Value: WideString);
    procedure Set_Comment(Value: WideString);
  end;

{ TXMLTestConstructType }

  TXMLTestConstructType = class(TXMLNode, IXMLTestConstructType)
  protected
    { IXMLTestConstructType }
    function Get_WaveFile: WideString;
    function Get_Blocks: IXMLBlocksType;
    procedure Set_WaveFile(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBlocksType }

  TXMLBlocksType = class(TXMLNodeCollection, IXMLBlocksType)
  protected
    { IXMLBlocksType }
    function Get_Block(Index: Integer): IXMLBlockType;
    function Add: IXMLBlockType;
    function Insert(const Index: Integer): IXMLBlockType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBlockType }

  TXMLBlockType = class(TXMLNode, IXMLBlockType)
  protected
    { IXMLBlockType }
    function Get_Type_: WideString;
    function Get_Element: Integer;
    function Get_AnswerTime: Integer;
    function Get_StartTime: Integer;
    function Get_EndTime: Integer;
    procedure Set_Type_(Value: WideString);
    procedure Set_Element(Value: Integer);
    procedure Set_AnswerTime(Value: Integer);
    procedure Set_StartTime(Value: Integer);
    procedure Set_EndTime(Value: Integer);
  end;

{ Global Functions }

function GetBinauralPitchTest(Doc: IXMLDocument): IXMLBinauralPitchTestType;
function LoadBinauralPitchTest(const FileName: WideString): IXMLBinauralPitchTestType;
function NewBinauralPitchTest: IXMLBinauralPitchTestType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetBinauralPitchTest(Doc: IXMLDocument): IXMLBinauralPitchTestType;
begin
  Result := Doc.GetDocBinding('BinauralPitchTest', TXMLBinauralPitchTestType, TargetNamespace) as IXMLBinauralPitchTestType;
end;

function LoadBinauralPitchTest(const FileName: WideString): IXMLBinauralPitchTestType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('BinauralPitchTest', TXMLBinauralPitchTestType, TargetNamespace) as IXMLBinauralPitchTestType;
end;

function NewBinauralPitchTest: IXMLBinauralPitchTestType;
begin
  Result := NewXMLDocument.GetDocBinding('BinauralPitchTest', TXMLBinauralPitchTestType, TargetNamespace) as IXMLBinauralPitchTestType;
end;

{ TXMLBinauralPitchTestType }

procedure TXMLBinauralPitchTestType.AfterConstruction;
begin
  RegisterChildNode('Results', TXMLResultsType);
  RegisterChildNode('PatientInfo', TXMLPatientInfoType);
  RegisterChildNode('TestConstruct', TXMLTestConstructType);
  inherited;
end;

function TXMLBinauralPitchTestType.Get_Results: IXMLResultsType;
begin
  Result := ChildNodes['Results'] as IXMLResultsType;
end;

function TXMLBinauralPitchTestType.Get_PatientInfo: IXMLPatientInfoType;
begin
  Result := ChildNodes['PatientInfo'] as IXMLPatientInfoType;
end;

function TXMLBinauralPitchTestType.Get_TestConstruct: IXMLTestConstructType;
begin
  Result := ChildNodes['TestConstruct'] as IXMLTestConstructType;
end;

{ TXMLResultsType }

procedure TXMLResultsType.AfterConstruction;
begin
  RegisterChildNode('BlockResults', TXMLBlockResultsType);
  inherited;
end;

function TXMLResultsType.Get_TotalDioticInTest: Integer;
begin
  Result := ChildNodes['TotalDioticInTest'].NodeValue;
end;

procedure TXMLResultsType.Set_TotalDioticInTest(Value: Integer);
begin
  ChildNodes['TotalDioticInTest'].NodeValue := Value;
end;

function TXMLResultsType.Get_TotalDichoticInTest: Integer;
begin
  Result := ChildNodes['TotalDichoticInTest'].NodeValue;
end;

procedure TXMLResultsType.Set_TotalDichoticInTest(Value: Integer);
begin
  ChildNodes['TotalDichoticInTest'].NodeValue := Value;
end;

function TXMLResultsType.Get_CorrectDiotic: Integer;
begin
  Result := ChildNodes['CorrectDiotic'].NodeValue;
end;

procedure TXMLResultsType.Set_CorrectDiotic(Value: Integer);
begin
  ChildNodes['CorrectDiotic'].NodeValue := Value;
end;

function TXMLResultsType.Get_CorrectDichotic: Integer;
begin
  Result := ChildNodes['CorrectDichotic'].NodeValue;
end;

procedure TXMLResultsType.Set_CorrectDichotic(Value: Integer);
begin
  ChildNodes['CorrectDichotic'].NodeValue := Value;
end;

function TXMLResultsType.Get_PercentDiotic: Integer;
begin
  Result := ChildNodes['PercentDiotic'].NodeValue;
end;

procedure TXMLResultsType.Set_PercentDiotic(Value: Integer);
begin
  ChildNodes['PercentDiotic'].NodeValue := Value;
end;

function TXMLResultsType.Get_PercentDichotic: Integer;
begin
  Result := ChildNodes['PercentDichotic'].NodeValue;
end;

procedure TXMLResultsType.Set_PercentDichotic(Value: Integer);
begin
  ChildNodes['PercentDichotic'].NodeValue := Value;
end;

function TXMLResultsType.Get_PercentTotal: Integer;
begin
  Result := ChildNodes['PercentTotal'].NodeValue;
end;

procedure TXMLResultsType.Set_PercentTotal(Value: Integer);
begin
  ChildNodes['PercentTotal'].NodeValue := Value;
end;

function TXMLResultsType.Get_BlockResults: IXMLBlockResultsType;
begin
  Result := ChildNodes['BlockResults'] as IXMLBlockResultsType;
end;

{ TXMLBlockResultsType }

procedure TXMLBlockResultsType.AfterConstruction;
begin
  RegisterChildNode('BlockResult', TXMLBlockResultType);
  ItemTag := 'BlockResult';
  ItemInterface := IXMLBlockResultType;
  inherited;
end;

function TXMLBlockResultsType.Get_BlockResult(Index: Integer): IXMLBlockResultType;
begin
  Result := List[Index] as IXMLBlockResultType;
end;

function TXMLBlockResultsType.Add: IXMLBlockResultType;
begin
  Result := AddItem(-1) as IXMLBlockResultType;
end;

function TXMLBlockResultsType.Insert(const Index: Integer): IXMLBlockResultType;
begin
  Result := AddItem(Index) as IXMLBlockResultType;
end;

{ TXMLBlockResultType }

function TXMLBlockResultType.Get_Element: Integer;
begin
  Result := ChildNodes['Element'].NodeValue;
end;

procedure TXMLBlockResultType.Set_Element(Value: Integer);
begin
  ChildNodes['Element'].NodeValue := Value;
end;

function TXMLBlockResultType.Get_Correct: Boolean;
begin
  Result := ChildNodes['Correct'].NodeValue;
end;

procedure TXMLBlockResultType.Set_Correct(Value: Boolean);
begin
  ChildNodes['Correct'].NodeValue := Value;
end;

function TXMLBlockResultType.Get_Failed: Boolean;
begin
  Result := ChildNodes['Failed'].NodeValue;
end;

procedure TXMLBlockResultType.Set_Failed(Value: Boolean);
begin
  ChildNodes['Failed'].NodeValue := Value;
end;

{ TXMLPatientInfoType }

function TXMLPatientInfoType.Get_Cpr: string;
begin
  Result := ChildNodes['Cpr'].Text;
end;

procedure TXMLPatientInfoType.Set_Cpr(Value: string);
begin
  ChildNodes['Cpr'].NodeValue := Value;
end;

function TXMLPatientInfoType.Get_Firstname: WideString;
begin
  Result := ChildNodes['Firstname'].Text;
end;

procedure TXMLPatientInfoType.Set_Firstname(Value: WideString);
begin
  ChildNodes['Firstname'].NodeValue := Value;
end;

function TXMLPatientInfoType.Get_Surname: WideString;
begin
  Result := ChildNodes['Surname'].Text;
end;

procedure TXMLPatientInfoType.Set_Surname(Value: WideString);
begin
  ChildNodes['Surname'].NodeValue := Value;
end;

function TXMLPatientInfoType.Get_Comment: WideString;
begin
  Result := ChildNodes['Comment'].Text;
end;

procedure TXMLPatientInfoType.Set_Comment(Value: WideString);
begin
  ChildNodes['Comment'].NodeValue := Value;
end;

{ TXMLTestConstructType }

procedure TXMLTestConstructType.AfterConstruction;
begin
  RegisterChildNode('Blocks', TXMLBlocksType);
  inherited;
end;

function TXMLTestConstructType.Get_WaveFile: WideString;
begin
  Result := ChildNodes['WaveFile'].Text;
end;

procedure TXMLTestConstructType.Set_WaveFile(Value: WideString);
begin
  ChildNodes['WaveFile'].NodeValue := Value;
end;

function TXMLTestConstructType.Get_Blocks: IXMLBlocksType;
begin
  Result := ChildNodes['Blocks'] as IXMLBlocksType;
end;

{ TXMLBlocksType }

procedure TXMLBlocksType.AfterConstruction;
begin
  RegisterChildNode('Block', TXMLBlockType);
  ItemTag := 'Block';
  ItemInterface := IXMLBlockType;
  inherited;
end;

function TXMLBlocksType.Get_Block(Index: Integer): IXMLBlockType;
begin
  Result := List[Index] as IXMLBlockType;
end;

function TXMLBlocksType.Add: IXMLBlockType;
begin
  Result := AddItem(-1) as IXMLBlockType;
end;

function TXMLBlocksType.Insert(const Index: Integer): IXMLBlockType;
begin
  Result := AddItem(Index) as IXMLBlockType;
end;

{ TXMLBlockType }

function TXMLBlockType.Get_Type_: WideString;
begin
  Result := ChildNodes['Type'].Text;
end;

procedure TXMLBlockType.Set_Type_(Value: WideString);
begin
  ChildNodes['Type'].NodeValue := Value;
end;

function TXMLBlockType.Get_Element: Integer;
begin
  Result := ChildNodes['Element'].NodeValue;
end;

procedure TXMLBlockType.Set_Element(Value: Integer);
begin
  ChildNodes['Element'].NodeValue := Value;
end;

function TXMLBlockType.Get_AnswerTime: Integer;
begin
  Result := ChildNodes['AnswerTime'].NodeValue;
end;

procedure TXMLBlockType.Set_AnswerTime(Value: Integer);
begin
  ChildNodes['AnswerTime'].NodeValue := Value;
end;

function TXMLBlockType.Get_StartTime: Integer;
begin
  Result := ChildNodes['StartTime'].NodeValue;
end;

procedure TXMLBlockType.Set_StartTime(Value: Integer);
begin
  ChildNodes['StartTime'].NodeValue := Value;
end;

function TXMLBlockType.Get_EndTime: Integer;
begin
  Result := ChildNodes['EndTime'].NodeValue;
end;

procedure TXMLBlockType.Set_EndTime(Value: Integer);
begin
  ChildNodes['EndTime'].NodeValue := Value;
end;

end.