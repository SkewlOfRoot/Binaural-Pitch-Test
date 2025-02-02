unit SaveAsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PatientData, ResultData, Block, ConfigFile;

type
  TSaveAs = class(TForm)
    Panel1: TPanel;
    rgSave: TRadioGroup;
    btnCancel: TButton;
    btnSave: TButton;
    saveLocalDialog: TSaveDialog;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    defaultResultDir : string;
    bptExt : string;
    blocks : array of TBlock;
    patientData : TPatientData;
    resultData : TResultData;
    abFileName : string;
    waveFile : string;
    savedBool : boolean;
    procedure InitializeFromIniFile();
    procedure SaveResults(fileName : string);
    function SaveLocallyFileDialog() : string;
    function GetSaved() : boolean;
  public
    { Public declarations }
    property Saved : boolean read GetSaved;
    procedure SetData(testBlocks : array of TBlock; patientData : TPatientData; resultData : TResultData; abFileName : string; waveFile : string);
  end;

var
  SaveAs: TSaveAs;

implementation

{$R *.dfm}
{$Optimization Off}

procedure TSaveAs.FormCreate(Sender: TObject);
begin
  savedBool := false;
  InitializeFromIniFile();
end;

procedure TSaveAs.InitializeFromIniFile();
  var
    inipath : string;
    configFile : TConfigFile;
begin
    inipath := ExtractFileDir(Application.ExeName)+'\DetectionTest.ini';
    configFile := TConfigFile.Create(iniPath);
  try
    defaultResultDir := configFile.DefaultResultDir;
    bptExt := configFile.BptExtension;

  finally
    configFile.Free;
  end;
end;

//When Cancel button is clicked.
procedure TSaveAs.btnCancelClick(Sender: TObject);
begin
  Close();
end;


//When Save button is clicked.
procedure TSaveAs.btnSaveClick(Sender: TObject);
begin
  if rgSave.Buttons[0].Checked then //Locally only
    SaveResults(SaveLocallyFileDialog);
  if rgSave.Buttons[1].Checked then //AuditBase only
    SaveResults(abFileName);
  if rgSave.Buttons[2].Checked then begin //Both
    SaveResults(SaveLocallyFileDialog);
    SaveResults(abFileName);
  end;
  Close();
end;

procedure TSaveAs.SetData(testBlocks: array of TBlock; patientData: TPatientData; resultData: TResultData; abFileName: string; waveFile : string);
var
  i: Integer;
begin
  SetLength(blocks,Length(testBlocks));
  for i := 0 to Length(testBlocks) - 1 do
    blocks[i] := testBlocks[i];
  self.patientData := patientData;
  self.resultData := resultData;
  self.abFileName := abFileName;
  self.waveFile := waveFile;
end;

procedure TSaveAs.SaveResults(fileName: string);
  var
    resultsFile : TextFile;
    i: Integer;
    block : TBlock;
  const
    xmlHeader : string = '<?xml version="1.0" encoding="iso-8859-1"?>';
begin
  if (blocks <> nil) and (patientData <> nil) and (resultData <> nil) then begin

  if fileName <> '' then begin
    AssignFile(resultsFile, fileName);
    Rewrite(resultsFile);
    Writeln(resultsFile,xmlHeader);
    Writeln(resultsFile,'<BinauralPitchTest>');
    Writeln(resultsFile,'<Results>');
    Writeln(resultsFile, '<TotalDioticInTest>'+resultData.TotalDiotic+'</TotalDioticInTest>');
    Writeln(resultsFile, '<TotalDichoticInTest>'+resultData.TotalDichotic+'</TotalDichoticInTest>');
    Writeln(resultsFile, '<CorrectDiotic>'+resultData.CorrectDiotic+'</CorrectDiotic>');
    Writeln(resultsFile, '<CorrectDichotic>'+resultData.CorrectDichotic+'</CorrectDichotic>');
    Writeln(resultsFile, '<PercentDiotic>'+resultData.PercentDiotic+'</PercentDiotic>');
    Writeln(resultsFile, '<PercentDichotic>'+resultData.PercentDichotic+'</PercentDichotic>');
    Writeln(resultsFile, '<PercentTotal>'+resultData.PercentTotal+'</PercentTotal>');
    Writeln(resultsFile,  '<BlockResults>');
    for i := 0 to Length(blocks)-1 do begin
      Writeln(resultsFile,'<BlockResult>');
      Writeln(resultsFile,  '<Element>'+IntToStr(i+1)+'</Element>');
      Writeln(resultsFile,  '<Correct>'+BoolToStr(blocks[i].Detected)+'</Correct>');
      Writeln(resultsFile,  '<Failed>'+BoolToStr(blocks[i].Failed)+'</Failed>');
      Writeln(resultsFile,'</BlockResult>');
    end;
    Writeln(resultsFile,  '</BlockResults>');
    Writeln(resultsFile,'</Results>');

    WriteLn(resultsFile,'<PatientInfo>');
    WriteLn(resultsFile, '<Cpr>'+patientData.Cpr+'</Cpr>');
    WriteLn(resultsFile, '<Firstname>'+patientData.FirstName+'</Firstname>');
    WriteLn(resultsFile, '<Surname>'+patientData.Surname+'</Surname>');
    WriteLn(resultsFile, '<Comment>'+patientData.Comment+'</Comment>');
    WriteLn(resultsFile,'</PatientInfo>');

    Writeln(resultsFile,'<TestConstruct>');
    Writeln(resultsFile,'<WaveFile>'+waveFile+'</WaveFile>');
    Writeln(resultsFile, '<Blocks>');
    for i := 0 to length(blocks) - 1 do begin
      block := blocks[i];
      Writeln(resultsFile, '<Block>');
      Writeln(resultsFile, '<Type>'+block.BlockType+'</Type>');
      Writeln(resultsFile, '<Element>'+IntToStr(i+1)+'</Element>');
      Writeln(resultsFile, '<AnswerTime>'+IntToStr(block.AnswerTime)+'</AnswerTime>');
      Writeln(resultsFile, '<StartTime>'+IntToStr(block.StartTime)+'</StartTime>');
      Writeln(resultsFile, '<EndTime>'+IntToStr(block.EndTime)+'</EndTime>');
      Writeln(resultsFile, '</Block>');
    end;
    Writeln(resultsFile, '</Blocks>');
    Writeln(resultsFile,'</TestConstruct>');
    Writeln(resultsFile,'</BinauralPitchTest>');
    CloseFile(resultsFile);

    savedBool := true;
    end;
  end;
end;

function TSaveAs.SaveLocallyFileDialog() : string;
  begin
    saveLocalDialog := TSaveDialog.Create(self);
    with saveLocalDialog do begin
      InitialDir := defaultResultDir;
      DefaultExt := bptExt;
      Filter := 'Binaural Pitch Test files (*.'+bptExt+')|*.'+bptExt+'|All files (*.*)|*.*';
      FilterIndex := 1;
      Title := 'Save Test Results As';
    end;
    if saveLocalDialog.Execute then
      Result := saveLocalDialog.FileName
    else
      Result := '';
  end;

function TSaveAs.GetSaved() : boolean;
begin
  Result := savedBool;
end;
end.
