unit CreateNewTestForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, ComCtrls, IniFiles, Buttons, xmldom,
  XMLIntf, msxmldom, XMLDoc, BinauralPitchTest, Block, ConfigFile;

type
  TCreateNewTest = class(TForm)
    btnAddToExisting: TButton;
    btnAdd: TButton;
    btnSave: TButton;
    cbType: TComboBox;
    editStartTime: TEdit;
    editEndTime: TEdit;
    cbDuration: TComboBox;
    GroupBox1: TGroupBox;
    lblTypeDuration: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    btnDeleteRow: TButton;
    lvBlocks: TListView;
    saveDialog: TSaveDialog;
    openDialog: TOpenDialog;
    sbtnUp: TSpeedButton;
    sbtnDown: TSpeedButton;
    existingXmlDoc: TXMLDocument;
    lblStartTime: TLabel;
    lblEndTime: TLabel;
    lblSeconds1: TLabel;
    lblSeconds2: TLabel;
    lblSeconds3: TLabel;
    btnCancel: TButton;
    chkConstantInterval: TCheckBox;
    editConstantInterval: TEdit;
    lblSeconds4: TLabel;
    btnClear: TButton;
    cbWaveFile: TComboBox;
    Label1: TLabel;
    grpWaveFile: TGroupBox;
    lblWaveDir: TLabel;
    cbOverallAnswer: TComboBox;
    btnOverallAnswerTime: TButton;
    lblOverallAnswerTime: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure sbtnUpClick(Sender: TObject);
    procedure sbtnDownClick(Sender: TObject);
    procedure btnAddToExistingClick(Sender: TObject);
    procedure lvBlocksDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkConstantIntervalClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnOverallAnswerTimeClick(Sender: TObject);
  private
    { Private declarations }
    defaultTestDir : string;
    defaultWaveDir : string;
    bptExt : string;
    inEditMode : boolean;
    editedItemIndex : integer;
    testLoaded : boolean;
    function IsValid() : boolean;
    function IsInteger(str : string) : boolean;
    procedure InitializeFromIniFile();
    procedure SaveXmlDocument(fileName : string);
    function OpenXmlFileDialog() : boolean;
    procedure FillListView();
    procedure FindWaveFiles();

  public
    { Public declarations }
  end;

var
  CreateNewTest: TCreateNewTest;

implementation

{$R *.dfm}
{$Optimization Off}

//When the add (>>>) button is clicked.
procedure TCreateNewTest.btnAddClick(Sender: TObject);
  var
    item : TListItem;
    oldStartTime : integer;
    oldEndTime : integer;
    constTimeInt : integer;
begin
  if IsValid then begin
    if not inEditMode then begin
      item := lvBlocks.Items.Add;
      item.Caption := (cbType.Items.Strings[cbType.ItemIndex]);
      item.SubItems.Add(cbDuration.Items.Strings[cbDuration.ItemIndex]);
      item.SubItems.Add(editStartTime.Text);
      item.SubItems.Add(editEndTime.Text);
    end
    else begin
      item := TListItem.Create(lvBlocks.Items);
      item.Caption := cbType.Items.Strings[cbType.ItemIndex];
      item.SubItems.Add(cbDuration.Items.Strings[cbDuration.ItemIndex]);
      item.SubItems.Add(editStartTime.Text);
      item.SubItems.Add(editEndTime.Text);

      lvBlocks.Items[editedItemIndex] := item;
      inEditMode := false;
    end;
    if chkConstantInterval.Checked then begin
      oldStartTime := StrToInt(editStartTime.Text);
      oldEndTime := StrToInt(editEndTime.Text);
      constTimeInt := StrToInt(editConstantInterval.Text);
      editStartTime.Text := IntToStr(oldStartTime+constTimeInt);
      editEndTime.Text := IntToStr(oldEndTime+constTimeInt);
    end
    else begin
      editStartTime.Text := editEndTime.Text;
      editEndTime.Text := '';
    end;
  end
  else
    ShowMessage('Invalid values detected. Check for typoes.');
end;

//When Add To Existing button is clicked.
procedure TCreateNewTest.btnAddToExistingClick(Sender: TObject);
begin
  if OpenXmlFileDialog then begin
    lvBlocks.Items.Clear;
    FillListView;
  end
  else
    ShowMessage('ListView could not be filled.');
end;

//Procedure is called when Add to existing button is clicked.
function TCreateNewTest.OpenXmlFileDialog() : boolean;
  var loaded : boolean;
begin
  loaded := false;
  with openDialog do begin
    openDialog.FileName := '';
    Title := 'Open a Binaural Pitch Test file (.'+bptExt+')';
    Filter := 'All files|*.*|Binarual Pitch Test files (*.'+bptExt+')|*.'+bptExt;
    FilterIndex := 2;
    InitialDir := defaultTestDir;
  end;
  if openDialog.Execute then begin
    if (ExtractFileExt(openDialog.FileName) = '.'+bptExt)and (FileExists(openDialog.FileName)) then begin
      try
        existingXmlDoc.FileName := openDialog.FileName;
        loaded := true;
      except on Exception do begin
        ShowMessage(UpperCase(bptExt)+'-file was not in the correct format.');
        OpenXmlFileDialog;
      end;
      end;
    end
    else begin
      ShowMessage('Filetype must be of type '+UpperCase(bptExt)+' and file must exist.');
      OpenXmlFileDialog;
    end;
  end;
  Result := loaded;
end;

//When Delete row button is clicked.
procedure TCreateNewTest.btnDeleteRowClick(Sender: TObject);
  var buttonSelected : integer;
  const messageStr : string = 'Are you sure you want to delete the selected row?';
begin
  if lvBlocks.Selected <> nil then begin
    if not inEditMode then begin
      buttonSelected := MessageDlg(messageStr,mtConfirmation,[mbYes,mbNo],0);
      if buttonSelected = mrYes then
        lvBlocks.DeleteSelected;
    end
    else
      ShowMessage('Cannot delete selected item. Application is in editmode.');
  end;
end;

//When Save button is clicked.
procedure TCreateNewTest.btnSaveClick(Sender: TObject);
begin
  if cbWaveFile.ItemIndex <> -1 then begin
    saveDialog := TSaveDialog.Create(self);
    with saveDialog do begin
      Title := 'Save your Binaural Pitch Test as';
      InitialDir := defaultTestDir;
      Filter := 'Binaural Pitch Test files (*.'+bptExt+')|*.'+bptExt+'|All files (*.*)|*.*';
      FilterIndex := 1;
      DefaultExt := bptExt;
    end;
    if saveDialog.Execute then begin
      SaveXmlDocument(saveDialog.FileName);
      Close();
    end
    else
      ShowMessage('Save was cancelled!');
    end
    else
      ShowMessage('An associated wave-file must be selected.');
end;

procedure TCreateNewTest.btnOverallAnswerTimeClick(Sender: TObject);
var
  i: Integer;
begin
  if testLoaded and not inEditMode then begin
    for i := 0 to lvBlocks.items.Count - 1 do begin
      lvBlocks.Items[i].SubItems[0] := cbOverallAnswer.Text;
    end;
  end;
end;

//When the Constant Block Interval checkbox is clicked.
procedure TCreateNewTest.chkConstantIntervalClick(Sender: TObject);
begin
  if chkConstantInterval.Checked then
    editConstantInterval.Enabled := true
  else
    editConstantInterval.Enabled := false;
end;

//When the Cancel button is clicked.
procedure TCreateNewTest.btnCancelClick(Sender: TObject);
begin
  self.Close();
end;

//Clears the entire ListView.
procedure TCreateNewTest.btnClearClick(Sender: TObject);
  var buttonSelected : integer;
  const messageStr : string = 'Are you sure you want to clear the entire table?';
begin
  if lvBlocks.Items.Count > 0 then begin
    buttonSelected := MessageDlg(messageStr,mtConfirmation,[mbYes,mbNo],0);
    if buttonSelected = mrYes then
      lvBlocks.Clear;
    testLoaded := false;
  end;
end;

//When the CreateNewTest form is created.
procedure TCreateNewTest.FormCreate(Sender: TObject);
begin
  InitializeFromIniFile();
  FindWaveFiles();
  lblWaveDir.Caption := 'Looking in: '+defaultWaveDir;
end;

//Checks if the values are correct.
function TCreateNewTest.IsValid() : boolean;
  var valid : boolean;
begin
  valid := true;
  if (editConstantInterval.Text = '') or not IsInteger(editConstantInterval.Text) then
    valid := false;
  if (cbType.ItemIndex < 0)or(cbType.ItemIndex >= cbType.Items.Count) then
    valid := false;
  if (cbDuration.ItemIndex < 0)and(cbDuration.ItemIndex >= cbDuration.Items.Count) then
    valid := false;
  if (editStartTime.Text = '') or not IsInteger(editStartTime.Text) then
    valid := false;
  if (editEndTime.Text = '') or not IsInteger(editEndTime.Text) then
    valid := false;

  Result := valid;
end;

//When a row from the ListView is dobbel-clicked.
procedure TCreateNewTest.lvBlocksDblClick(Sender: TObject);
  var item : TListItem;
begin
  if lvBlocks.Selected <> nil then begin
    inEditMode := true;
    item := lvBlocks.Selected;
    editedItemIndex := lvBlocks.Items.IndexOf(item);

    cbType.ItemIndex := cbType.Items.IndexOf(item.Caption);
    cbDuration.ItemIndex := cbDuration.Items.IndexOf(item.SubItems[0]);
    editStartTime.Text := item.SubItems[1];
    editEndTime.Text := item.SubItems[2];
  end;
end;

//Checks if a string value can på parsed to an integer. 
function TCreateNewTest.IsInteger(str: string) : boolean;
  var int : integer;
begin
    Result := TryStrToInt(str, int);
end;

//Read values form the ini file.
procedure TCreateNewTest.InitializeFromIniFile();
  var
    inipath : string;
    configFile : TConfigFile;
begin
  inipath := ExtractFileDir(Application.ExeName)+'\DetectionTest.ini';
  configFile := TConfigFile.Create(iniPath);
  try
    defaultWaveDir := configFile.DefaultWaveDir;
    defaultTestDir := configFile.DefaultTestDir;
    bptExt := configFile.BptExtension;
  finally
    configFile.Free;
  end;
end;

//Creates a new xml document with the blocks from the ListView.
procedure TCreateNewTest.SaveXmlDocument(fileName: string);
  var
    xmlFile : TextFile;
    i: Integer;
    item : TListItem;
  const
    xmlHeader : string = '<?xml version="1.0" encoding="ISO-8859-1"?>';
begin
  AssignFile(xmlFile,fileName);
  Rewrite(xmlFile);

  Writeln(xmlFile,xmlHeader);
  Writeln(xmlFile,'<BinauralPitchTest>');
  Writeln(xmlFile,'<Results>');
  Writeln(xmlFile, '<TotalDioticInTest></TotalDioticInTest>');
  Writeln(xmlFile, '<TotalDichoticInTest></TotalDichoticInTest>');
  Writeln(xmlFile, '<CorrectDiotic></CorrectDiotic>');
  Writeln(xmlFile, '<CorrectDichotic></CorrectDichotic>');
  Writeln(xmlFile, '<PercentDiotic></PercentDiotic>');
  Writeln(xmlFile, '<PercentDichotic></PercentDichotic>');
  Writeln(xmlFile, '<PercentTotal></PercentTotal>');

  Writeln(xmlFile,  '<BlockResults>');
  Writeln(xmlFile,'<BlockResult>');
  Writeln(xmlFile,  '<Element></Element>');
  Writeln(xmlFile,  '<Correct></Correct>');
  Writeln(xmlFile,  '<Failed></Failed>');
  Writeln(xmlFile,'</BlockResult>');
  Writeln(xmlFile,'</BlockResults>');
  Writeln(xmlFile,'</Results>');

  WriteLn(xmlFile,'<PatientInfo>');
  WriteLn(xmlFile, '<Cpr></Cpr>');
  WriteLn(xmlFile, '<Firstname></Firstname>');
  WriteLn(xmlFile, '<Surname></Surname>');
  WriteLn(xmlFile, '<Comment></Comment>');
  WriteLn(xmlFile,'</PatientInfo>');

  Writeln(xmlFile,'<TestConstruct>');
  Writeln(xmlFile,'<WaveFile>'+cbWaveFile.Text+'</WaveFile>');
  Writeln(xmlFile,'<Blocks>');
  for i := 0 to lvBlocks.Items.Count - 1 do begin
    item := lvBlocks.Items[i];
    Writeln(xmlFile,'<Block>');
    Writeln(xmlFile,'<Type>'+item.Caption+'</Type>');
    Writeln(xmlFile,'<Element>'+IntToStr(i+1)+'</Element>');
    Writeln(xmlFile,'<AnswerTime>'+item.SubItems[0]+'</AnswerTime>');
    Writeln(xmlFile,'<StartTime>'+item.SubItems[1]+'</StartTime>');
    Writeln(xmlFile,'<EndTime>'+item.SubItems[2]+'</EndTime>');
    Writeln(xmlFile,'</Block>');
  end;
  Writeln(xmlFile,'</Blocks>');
  Writeln(xmlFile,'</TestConstruct>');
  Writeln(xmlFile,'</BinauralPitchTest>');
  CloseFile(xmlFile);
end;

//Moves the selected element one place up in the ListView.
procedure TCreateNewTest.sbtnUpClick(Sender: TObject);
  var
    index : integer;
    replacedItem : TListItem;
    rep : string;
    fill : TListItem;
begin
  if not inEditMode then begin
    index := lvBlocks.ItemIndex;
    if index > 0 then begin
      replacedItem := lvBlocks.Items[index-1];
      rep := replacedItem.Caption;
      fill := TListItem.Create(lvBlocks.Items);
      fill.Caption := replacedItem.Caption;
      fill.SubItems.Add(replacedItem.SubItems[0]);
      fill.SubItems.Add(replacedItem.SubItems[1]);
      fill.SubItems.Add(replacedItem.SubItems[2]);

      lvBlocks.Items[index-1] := lvBlocks.Items[index];
      fill.Caption := rep;
      lvBlocks.Items[index] := fill;
      lvBlocks.Selected := lvBlocks.Items[index-1];
    end;
  end
  else
    ShowMessage('Cannot move the selected item. Application is in editmode.');
end;

//Moves the selected element one place down in the ListView.
procedure TCreateNewTest.sbtnDownClick(Sender: TObject);
var
    index : integer;
    replacedItem : TListItem;
    rep : string;
    fill : TListItem;
begin
  if not inEditMode then begin
    index := lvBlocks.ItemIndex;
    if index < lvBlocks.Items.Count-1 then begin
      replacedItem := lvBlocks.Items[index+1];
      rep := replacedItem.Caption;
      fill := TListItem.Create(lvBlocks.Items);
      fill.Caption := replacedItem.Caption;
      fill.SubItems.Add(replacedItem.SubItems[0]);
      fill.SubItems.Add(replacedItem.SubItems[1]);
      fill.SubItems.Add(replacedItem.SubItems[2]);

      lvBlocks.Items[index+1] := lvBlocks.Items[index];
      fill.Caption := rep;
      lvBlocks.Items[index] := fill;
      lvBlocks.Selected := lvBlocks.Items[index+1];
    end;
  end
  else
    ShowMessage('Cannot move the selected item. Application is in editmode.');
end;

//Fills the ListView with data from the opened test file.
procedure TCreateNewTest.FillListView;
  var
    binauralPitchTestDoc : IXMLBinauralPitchTestType;
    i: Integer;
    item : TListItem;
    xmlBlock : IXMLBlockType;
    waveExists : boolean;
begin
  binauralPitchTestDoc := BinauralPitchTest.GetBinauralPitchTest(existingXmlDoc);

  for i := 0 to binauralPitchTestDoc.TestConstruct.Blocks.Count - 1 do begin
    xmlBlock := binauralPitchTestDoc.TestConstruct.Blocks.Block[i];
    item := lvBlocks.Items.Add;
    item.Caption := xmlBlock.Type_;
    item.SubItems.Add(IntToStr(xmlBlock.AnswerTime));
    item.SubItems.Add(IntToStr(xmlBlock.StartTime));
    item.SubItems.Add(IntToStr(xmlBlock.EndTime));
  end;

  waveExists := false;
  for i := 0 to cbWaveFile.Items.Count - 1 do begin
    if cbWaveFile.Items[i] = binauralPitchTestDoc.TestConstruct.WaveFile then
      waveExists := true;
  end;
  cbWaveFile.SelText := '';
  cbWaveFile.Text := '';

  if not waveExists then begin
    ShowMessage('The associated wave-file does not exist in the default wave folder: "'+defaultWaveDir+'".');
  end
  else
    cbWaveFile.SelText := binauralPitchTestDoc.TestConstruct.WaveFile;
  testLoaded := true;
end;

procedure TCreateNewTest.FindWaveFiles();
  var isFound : boolean;
  sr : TSearchRec;
begin
  isFound := FindFirst(defaultWaveDir+'*.wav',faArchive-faDirectory,sr) = 0;
  while isFound do begin
    cbWaveFile.Items.Add(sr.Name);
    isFound := FindNext(sr) = 0;
  end;
end;
end.
