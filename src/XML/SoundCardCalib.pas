
{*************************************************************}
{                                                             }
{                      XML Data Binding                       }
{                                                             }
{         Generated on: 16-10-2008 10:06:56                   }
{       Generated from: C:\DetectionTest\SoundCardCalib.xml   }
{                                                             }
{*************************************************************}

unit SoundCardCalib;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLSoundCardCalibType = interface;
  IXMLMasterVolumeType = interface;
  IXMLMasterVolAttType = interface;

{ IXMLSoundCardCalibType }

  IXMLSoundCardCalibType = interface(IXMLNode)
    ['{1725E493-983D-422A-B2FE-EFA09CFA6236}']
    { Property Accessors }
    function Get_MasterVolume: IXMLMasterVolumeType;
    { Methods & Properties }
    property MasterVolume: IXMLMasterVolumeType read Get_MasterVolume;
  end;

{ IXMLMasterVolumeType }

  IXMLMasterVolumeType = interface(IXMLNodeCollection)
    ['{0C0A8453-1AFA-43B5-ADD1-15024585CDB5}']
    { Property Accessors }
    function Get_MasterVolAtt(Index: Integer): IXMLMasterVolAttType;
    { Methods & Properties }
    function Add: IXMLMasterVolAttType;
    function Insert(const Index: Integer): IXMLMasterVolAttType;
    property MasterVolAtt[Index: Integer]: IXMLMasterVolAttType read Get_MasterVolAtt; default;
  end;

{ IXMLMasterVolAttType }

  IXMLMasterVolAttType = interface(IXMLNode)
    ['{FF9B4328-5516-4D59-88F1-CDA5F992BE85}']
    { Property Accessors }
    function Get_DB: Integer;
    function Get_SoundCardVal: Integer;
    procedure Set_DB(Value: Integer);
    procedure Set_SoundCardVal(Value: Integer);
    { Methods & Properties }
    property DB: Integer read Get_DB write Set_DB;
    property SoundCardVal: Integer read Get_SoundCardVal write Set_SoundCardVal;
  end;

{ Forward Decls }

  TXMLSoundCardCalibType = class;
  TXMLMasterVolumeType = class;
  TXMLMasterVolAttType = class;

{ TXMLSoundCardCalibType }

  TXMLSoundCardCalibType = class(TXMLNode, IXMLSoundCardCalibType)
  protected
    { IXMLSoundCardCalibType }
    function Get_MasterVolume: IXMLMasterVolumeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMasterVolumeType }

  TXMLMasterVolumeType = class(TXMLNodeCollection, IXMLMasterVolumeType)
  protected
    { IXMLMasterVolumeType }
    function Get_MasterVolAtt(Index: Integer): IXMLMasterVolAttType;
    function Add: IXMLMasterVolAttType;
    function Insert(const Index: Integer): IXMLMasterVolAttType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMasterVolAttType }

  TXMLMasterVolAttType = class(TXMLNode, IXMLMasterVolAttType)
  protected
    { IXMLMasterVolAttType }
    function Get_DB: Integer;
    function Get_SoundCardVal: Integer;
    procedure Set_DB(Value: Integer);
    procedure Set_SoundCardVal(Value: Integer);
  end;

{ Global Functions }

function GetSoundCardCalib(Doc: IXMLDocument): IXMLSoundCardCalibType;
function LoadSoundCardCalib(const FileName: WideString): IXMLSoundCardCalibType;
function NewSoundCardCalib: IXMLSoundCardCalibType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetSoundCardCalib(Doc: IXMLDocument): IXMLSoundCardCalibType;
begin
  Result := Doc.GetDocBinding('SoundCardCalib', TXMLSoundCardCalibType, TargetNamespace) as IXMLSoundCardCalibType;
end;

function LoadSoundCardCalib(const FileName: WideString): IXMLSoundCardCalibType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('SoundCardCalib', TXMLSoundCardCalibType, TargetNamespace) as IXMLSoundCardCalibType;
end;

function NewSoundCardCalib: IXMLSoundCardCalibType;
begin
  Result := NewXMLDocument.GetDocBinding('SoundCardCalib', TXMLSoundCardCalibType, TargetNamespace) as IXMLSoundCardCalibType;
end;

{ TXMLSoundCardCalibType }

procedure TXMLSoundCardCalibType.AfterConstruction;
begin
  RegisterChildNode('MasterVolume', TXMLMasterVolumeType);
  inherited;
end;

function TXMLSoundCardCalibType.Get_MasterVolume: IXMLMasterVolumeType;
begin
  Result := ChildNodes['MasterVolume'] as IXMLMasterVolumeType;
end;

{ TXMLMasterVolumeType }

procedure TXMLMasterVolumeType.AfterConstruction;
begin
  RegisterChildNode('MasterVolAtt', TXMLMasterVolAttType);
  ItemTag := 'MasterVolAtt';
  ItemInterface := IXMLMasterVolAttType;
  inherited;
end;

function TXMLMasterVolumeType.Get_MasterVolAtt(Index: Integer): IXMLMasterVolAttType;
begin
  Result := List[Index] as IXMLMasterVolAttType;
end;

function TXMLMasterVolumeType.Add: IXMLMasterVolAttType;
begin
  Result := AddItem(-1) as IXMLMasterVolAttType;
end;

function TXMLMasterVolumeType.Insert(const Index: Integer): IXMLMasterVolAttType;
begin
  Result := AddItem(Index) as IXMLMasterVolAttType;
end;

{ TXMLMasterVolAttType }

function TXMLMasterVolAttType.Get_DB: Integer;
begin
  Result := ChildNodes['DB'].NodeValue;
end;

procedure TXMLMasterVolAttType.Set_DB(Value: Integer);
begin
  ChildNodes['DB'].NodeValue := Value;
end;

function TXMLMasterVolAttType.Get_SoundCardVal: Integer;
begin
  Result := ChildNodes['SoundCardVal'].NodeValue;
end;

procedure TXMLMasterVolAttType.Set_SoundCardVal(Value: Integer);
begin
  ChildNodes['SoundCardVal'].NodeValue := Value;
end;

end.