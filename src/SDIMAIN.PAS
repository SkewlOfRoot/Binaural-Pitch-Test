unit SDIMAIN;

interface

uses Windows, Classes, Graphics, Forms, Controls,  Dialogs, StdCtrls, Buttons,
  SysUtils, IniFiles, SoundPlayer, Types, TypInfo, Grids, Block, xmldom,
  XMLIntf, msxmldom, XMLDoc, BinauralPitchTest, CreateNewTestForm, ExtCtrls,
  ComCtrls, Clipbrd, Menus, VolumeControlForm, DeviceControlForm, About, MixerUnit,
  JvComponentBase, JvHidControllerClass, AuditBaseFileFixer, ConfigFile, SaveAsForm,
  PatientData, ResultData;

type
  TSDIAppForm = class(TForm)
    lblAudioFile: TLabel;
    Timer1: TTimer;
    lblElapsed: TLabel;
    trackPosition: TTrackBar;     
    lblTotalDuration: TLabel;
    drawGrid: TDrawGrid;
    xmlDoc: TXMLDocument;
    btnDetection: TButton;
    openFileDialog: TOpenDialog;
    btnOpenTest: TButton;
    lblTotalDioticBlocks: TLabel;
    lblTotalDichoticBlocks: TLabel;
    grpTestAndResults: TGroupBox;
    grpPatient: TGroupBox;
    btnStartTest: TButton;
    lblDiotic: TLabel;
    lblDichotic: TLabel;
    grpCorrectDetections: TGroupBox;
    lblCorrectDichotic: TLabel;
    lblCorrectDiotic: TLabel;
    lblPercentDiotic: TLabel;
    lblPercentDichotic: TLabel;
    lblPercentDichoticValue: TLabel;
    lblPercentDioticValue: TLabel;
    lblPercentTotal: TLabel;
    lblPercentTotalValue: TLabel;
    btnResetTest: TButton;
    btnCreateTest: TButton;
    btnSaveTestResults: TButton;
    panelTest: TPanel;
    sbTest: TScrollBar;
    saveLocalDialog: TSaveDialog;
    btnPauseTest: TButton;
    editCprFirst: TEdit;
    editCprSecond: TEdit;
    lblCpr: TLabel;
    editFirstname: TEdit;
    editSurname: TEdit;
    lblFirstname: TLabel;
    lblSurname: TLabel;
    memoComment: TMemo;
    lblComment: TLabel;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    menuSaveAs: TMenuItem;
    menuExit: TMenuItem;
    About2: TMenuItem;
    menuControls: TMenuItem;
    menuVolumeControl: TMenuItem;
    N1: TMenuItem;
    btnVolumeControl: TButton;
    hidDeviceController: TJvHidDeviceController;
    menuDeviceControl: TMenuItem;
    btnOpenResult: TButton;
    btnClearAll: TButton;
    chkEnableTrackBar: TCheckBox;
    grpPlayControl: TGroupBox;
    panelColorDetection: TPanel;
    lblPatientInput: TLabel;
    procedure trackPositionChange(Sender: TObject);
    procedure drawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnOpenTestClick(Sender: TObject);
    procedure btnDetectionClick(Sender: TObject);
    procedure btnResetTestClick(Sender: TObject);
    procedure btnStartTestClick(Sender: TObject);
    procedure btnCreateTestClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbTestScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure btnSaveTestResultsClick(Sender: TObject);
    procedure btnPauseTestClick(Sender: TObject);
    procedure btnVolumeControlClick(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure menuExitClick(Sender: TObject);
    procedure menuSaveAsClick(Sender: TObject);
    procedure menuVolumeControlClick(Sender: TObject);
    procedure menuDeviceControlClick(Sender: TObject);
    procedure hidDeviceControllerDeviceChange(Sender: TObject);
    function hidDeviceControllerEnumerate(HidDev: TJvHidDevice;
      const Idx: Integer): Boolean;
    procedure hidDeviceControllerDeviceData(HidDev: TJvHidDevice;
      ReportID: Byte; const Data: Pointer; Size: Word);
    procedure btnOpenResultClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDetectionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDetectionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    type TState = (Loading, Ready, TestStarted, TestPaused, TestResetted);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    defaultWaveDir : string;
    defaultTestDir : string;
    defaultResultDir : string;
    bptExt : string;
    waveFile : string;
    State : TState;
    SoundPlayer : TSoundPlayer;
    blocks : array of TBlock;
    totalDioticBlocks : integer;
    totalDichoticBlocks : integer;
    correctDiotic : integer;
    correctDichotic : integer;
    isTestRunning : boolean;
    fileContainsResults : boolean;
    isTestLoaded : boolean;
    saved : boolean;
    volCtrlForm : TVolumeControl;
    saveAsForm : TSaveAs;
    deviceControlForm : TDeviceControl;
    deviceList : array of TJvHidDevice;
    abFileFixer : TAuditBaseFileFixer;
    inputCount : integer;
    isAdmin : boolean;    
    //If the application is executed via AuditBase,
    //a filename (file on the AuditBase server) will
    //be provided in which the results can be saved.
    auditBaseFileName : string;
    procedure InitializeFromIniFile();
    procedure SetProgramState(Value : TState);
    procedure Play();
    procedure Stop();
    procedure Pause();
    procedure FillBlocks();
    procedure OpenXmlFileDialog(typeToOpen : integer);
    procedure OpenAudioFileDialog();
    procedure LoadTest();
    procedure ResetTest();
    function PercentCorrect(blockType : string) : integer;
    function CalculateBlockColor(block : TBlock) : TColor;
    procedure SetScrollBarValues();
    function ExtractPatientDataFromCB() : boolean;
    function ExtractPatientDataFromXml() : boolean;
    procedure PatientFieldsReadOnly(bool : boolean);
    //function IsPatientDataValid() : boolean;  //Bliver ikke brugt
    procedure InsertResultValuesFromXml();
    procedure ChangePanelColorDetection(buttonDown : Boolean);

  public

  end;
var
  SDIAppForm: TSDIAppForm;

implementation

{$R *.dfm}
{$Optimization Off}

//When the Main form is created.
procedure TSDIAppForm.FormCreate(Sender: TObject);
var
  i: Integer;
  str : string;
begin
  SetProgramState(Loading);
  Application.HintHidePause := 10000;

  SetScrollBarValues; //Sets the scrollbar to match the drawGrid.

  InitializeFromIniFile();
  if isAdmin then
    btnVolumeControl.Visible := true;
  SoundPlayer := TSoundPlayer.Create;
  SoundPlayer.InitDirectSound(Application.Handle);
  volCtrlForm := TVolumeControl.Create(self);
  volCtrlForm.SetFormPosition(Top, Left+Width);
  volCtrlForm.SoundPlayerProp := SoundPlayer;
  volCtrlForm.InitializeMixer(self,application.Handle);
  deviceControlForm := TDeviceControl.Create(self);
  saveAsForm := TSaveAs.Create(self);

  openFileDialog := TOpenDialog.Create(self);
  isTestRunning := false;
  isTestLoaded := false;
  saved := true;

  abFileFixer := TAuditBaseFileFixer.Create;
  //abFileFixer.FixFile(defaultResultsDir+'abtest.bpt');
  str := '';
    for i := 0 to ParamCount do
      str := str + (IntToStr(i)+': '+ ParamStr(i))+Chr(10);
  //ShowMessage(str);
  if ParamCount > 0 then begin
    if (ParamStr(1) <> '')and (LowerCase(ExtractFileExt(ParamStr(1))) = '.'+bptExt) then begin
      xmlDoc.FileName := ParamStr(1);
      auditBaseFileName := ParamStr(1);
      abFileFixer.FixFile(auditBaseFileName);
      FillBlocks;
      LoadTest;
    end;
  end;
end;

//When the form is closed.
procedure TSDIAppForm.FormClose(Sender: TObject; var Action: TCloseAction);
  var buttonSelected : integer;
  const msg : string = 'Do you want to save the test results before exiting?';
begin
  if isTestLoaded and not saved then begin
    buttonSelected := MessageDlg(msg,mtConfirmation,[mbYes,mbNo],0);
    if buttonSelected = mrYes then
      btnSaveTestResultsClick(self);
  end;
end;

//When the main form is destroyed.
procedure TSDIAppForm.FormDestroy(Sender: TObject);
begin
  if volCtrlForm <> nil then
    volCtrlForm.MixerDestroy();
  if SoundPlayer <> nil then begin
    SoundPlayer.CloseFileDirectSound;
    SoundPlayer.CloseDirectSound;
  end;
  openFileDialog.Free;
end;

//Handles KeyDown events on the main form.
procedure TSDIAppForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_NUMPAD0..VK_NUMPAD9] then Key := 2;
  case Key of
    VK_CONTROL: trackPosition.Enabled := true;
    2: begin btnDetectionClick(self); ChangePanelColorDetection(true) end;
    VK_SPACE : begin btnDetectionClick(self); ChangePanelColorDetection(true) end;
    VK_RETURN : begin btnDetectionClick(self); ChangePanelColorDetection(true) end;
  end;
end;

//Handles KeyUp events on the main form.
procedure TSDIAppForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_NUMPAD0..VK_NUMPAD9] then Key := 2;

  case Key of
    VK_CONTROL: trackPosition.Enabled := false;
    2: ChangePanelColorDetection(false);
    VK_SPACE : ChangePanelColorDetection(false);
    VK_RETURN : ChangePanelColorDetection(false);
  end;
end;

//Read values form the ini file.
procedure TSDIAppForm.InitializeFromIniFile();
  var
    inipath : string;
    configFile : TConfigFile;
begin
  inipath := ExtractFileDir(Application.ExeName)+'\DetectionTest.ini';
  configFile := TConfigFile.Create(iniPath);
  try
    defaultWaveDir := configFile.DefaultWaveDir;
    defaultTestDir := configFile.DefaultTestDir;
    defaultResultDir := configFile.DefaultResultDir;
    bptExt := configFile.BptExtension;
    isAdmin := configFile.IsAdmin;
  finally
    configFile.Free;
  end;
end;

//Opens the OpenFileDialog when open test is clicked.
//Type to open: 1 = test, 2 = result.
procedure TSDIAppForm.OpenXmlFileDialog(typeToOpen : integer);
begin
  with openFileDialog do begin
    FileName := '';
    Title := 'Open a Binaural Pitch Test (.'+bptExt+')';
    Filter := 'Binaural Pitch Test files (*.'+ bptExt +')|*.'+ bptExt +'|All files (*.*)|*.*';
    FilterIndex := 1;
    if typeToOpen = 1 then
      InitialDir := defaultTestDir
    else if typeToOpen = 2 then
      InitialDir := defaultResultDir;
  end;
  if openFileDialog.Execute then begin
    if (ExtractFileExt(openFileDialog.FileName) = '.'+bptExt+'')and (FileExists(openFileDialog.FileName)) then begin
      try
        xmlDoc.FileName := openFileDialog.FileName;
      except on Exception do begin
        ShowMessage(UpperCase(bptExt) +'-file was not in the correct format.');
        OpenXmlFileDialog(typeToOpen);
      end;
      end;
    end
    else begin
      ShowMessage('Filetype must be of type '+UpperCase(bptExt)+' and file must exist.');
      OpenXmlFileDialog(typeToOpen);
    end;
  end;
end;

//Opens the OpenFileDialog when open test is clicked.
procedure TSDIAppForm.OpenAudioFileDialog;
begin
  with openFileDialog do begin
    FileName := '';
    Title := 'Select an audio-file (.wav)';
    Filter := 'Wave files (*.wav)|*.wav|All files (*.*)|*.*';
    FilterIndex := 1;
    InitialDir := defaultWaveDir;
  end;
  if openFileDialog.Execute then begin
    if (ExtractFileExt(openFileDialog.FileName)='.wav')and(FileExists(openFileDialog.FileName)) then begin
      waveFile := openFileDialog.FileName;
    end
    else begin
      ShowMessage('Filetype must be of type Wav and file must exist.');
      OpenAudioFileDialog;
    end;
  end;
end;

//Procedure is called every time the Timer 'tics'.
procedure TSDIAppForm.Timer1Timer(Sender: TObject);
begin
  if (State = TestStarted) then begin
    lblElapsed.Caption := SoundPlayer.TimeElapsedPresentation;
    if chkEnableTrackBar.Checked then
      trackPosition.Position := SoundPlayer.PlayPosition;

    if isTestRunning then begin
      drawGrid.Refresh;
      lblCorrectDiotic.Caption := IntToStr(correctDiotic);
      lblCorrectDichotic.Caption := IntToStr(correctDichotic);
      lblPercentDioticValue.Caption := IntToStr(PercentCorrect('Diotic'))+'%';
      lblPercentDichoticValue.Caption := IntToStr(PercentCorrect('Dichotic'))+'%';
      lblPercentTotalValue.Caption := IntToStr(PercentCorrect('Total'))+'%';
    end;
  end;
end;

procedure TSDIAppForm.Timer2Timer(Sender: TObject);
begin
  if (State = TestStarted) then begin
    trackPosition.Position := SoundPlayer.PlayPosition;
  end;
end;

//When the Open Test button is clicked.
procedure TSDIAppForm.btnOpenTestClick(Sender: TObject);
begin
  OpenXmlFileDialog(1);
  ResetTest();
  LoadTest();
  drawGrid.Refresh();
end;

//When the Open Result button is clicked.
procedure TSDIAppForm.btnOpenResultClick(Sender: TObject);
begin
  OpenXmlFileDialog(2);
  ResetTest();
  LoadTest();
  drawGrid.Refresh();
end;

//Loads the test-xml doc, wave file and sets up various information.
procedure TSDIAppForm.LoadTest();
begin
  //Loads the patient data (cpr, name) from either the clipboard or from the result-file. 
  if not ExtractPatientDataFromCB() then begin
    if not ExtractPatientDataFromXml() then
      PatientFieldsReadOnly(false)
    else
      PatientFieldsReadOnly(true);
  end
  else
    PatientFieldsReadOnly(true);

  FillBlocks(); //Fill the blocks array

  lblTotalDioticBlocks.Caption := 'Diotic blocks: '+ IntToStr(totalDioticBlocks);
  lblTotalDichoticBlocks.Caption := 'Dichotic blocks: '+ IntToStr(totalDichoticBlocks);
  //Setup the drawGrid so it matches the blocks length.
  drawGrid.RowCount := Length(blocks)+1;
  drawGrid.Height := (drawGrid.DefaultRowHeight * drawGrid.RowCount)+4; //+4 to avoid scrollbar
  SetScrollBarValues; //Sets the scrollbar to match the drawGrid.

  if waveFile = '' then begin
    OpenAudioFileDialog();
  end;

  if FileExists(waveFile) then begin
    if not SoundPlayer.LoadFileDirectSound(waveFile) then
      ShowMessage('File was not loaded!')
    else begin
      lblAudioFile.Caption := 'Audio-file loaded: '+ ExtractFileName(waveFile);
      lblAudioFile.Hint := 'ChunkSize: ' +IntToStr(SoundPlayer.ReadWaveHeaderObj.ChunkSize)+ ' bytes'+
        Chr(10) + 'AudioFormat: '+IntToStr(SoundPlayer.ReadWaveHeaderObj.AudioFormat)+
        Chr(10) + 'NumOfChannels: ' +IntToStr(SoundPlayer.ReadWaveHeaderObj.NumChannels)+
        Chr(10) + 'SampleRate: ' +IntToStr(SoundPlayer.ReadWaveHeaderObj.SampleRate) + ' Hz'+
        Chr(10) + 'ByteRate: ' +IntToStr(SoundPlayer.ReadWaveHeaderObj.ByteRate) + ' bytes/sec'+
        Chr(10) + 'BlockAlign: ' +IntToStr(SoundPlayer.ReadWaveHeaderObj.BlockAlign)+
        Chr(10) + 'BitsPerSample: '+ IntToStr(SoundPlayer.ReadWaveHeaderObj.BitsPerSample) + ' bits';
        trackPosition.Min := 0;
        trackPosition.Max := SoundPlayer.ReadWaveHeaderObj.ChunkSize;
        lblTotalDuration.Caption := SoundPlayer.DurationPresentation;
    end;
      SetProgramState(Ready);
      isTestRunning := false;
      saved := false;
  end
  else
    ShowMessage('Wavefile '+ ExtractFileName(waveFile)+' was not found!');
end;

//When save results button is clicked.
procedure TSDIAppForm.btnSaveTestResultsClick(Sender: TObject);
  var
    patientData : TPatientData;
    resultData : TResultData;
begin
  if isTestLoaded then begin
    //if IsPatientDataValid then begin
    patientData := TPatientData.Create;
    patientData.Cpr := editCprFirst.Text + editCprSecond.Text;
    patientData.FirstName := editFirstname.Text;
    patientData.Surname := editSurname.Text;
    patientData.Comment := memoComment.Text;

    resultData := TResultData.Create;
    resultData.TotalDiotic := IntToStr(totalDioticBlocks);
    resultData.TotalDichotic := IntToStr(totalDichoticBlocks);
    resultData.CorrectDiotic := IntToStr(correctDiotic);
    resultData.CorrectDichotic := IntToStr(correctDichotic);
    resultData.PercentDiotic := IntToStr(PercentCorrect('Diotic'));
    resultData.PercentDichotic := IntToStr(PercentCorrect('Dichotic'));
    resultData.PercentTotal := IntToStr(PercentCorrect('Total'));

    saveAsForm.SetData(blocks,patientData,resultData,auditBaseFileName,ExtractFileName(waveFile));
    saveAsForm.ShowModal();

    saved := saveAsForm.Saved;
    //end
    //else
      //ShowMessage('Some patient data is of invalid format!');
  end
  else
    ShowMessage('Can not save. No test is loaded.');
end;

//When Volume Control button is clicked.
procedure TSDIAppForm.btnVolumeControlClick(Sender: TObject);
begin
  volCtrlForm.SetFormPosition(Top,Left+Width);
  volCtrlForm.Show();
end;

//StartTest button is clicked.
procedure TSDIAppForm.btnStartTestClick(Sender: TObject);
begin
  isTestRunning := true;
  Play;
  SetProgramState(TestStarted);
end;

//PauseTest button is clicked.
procedure TSDIAppForm.btnPauseTestClick(Sender: TObject);
begin
  isTestRunning := false;
  Pause;
  SetProgramState(TestPaused);
end;

//StopTest button is clicked.
procedure TSDIAppForm.btnResetTestClick(Sender: TObject);
  var buttonSelected : integer;
  const messageStr : string = 'Are you sure you want to reset the test? All unsaved data will be lost!';
begin
  buttonSelected := MessageDlg(messageStr,mtConfirmation,[mbYes,mbNo],0);
  if buttonSelected = mrYes then begin
    isTestRunning := false;
    Stop;
    ResetTest;
    SetProgramState(TestResetted);
  end;
end;

//Clear All button is clicked.
procedure TSDIAppForm.btnClearAllClick(Sender: TObject);
  var buttonSelected : integer;
  i: Integer;
  const messageStr : string = 'Are you sure you want to clear all? All unsaved data will be lost!';
begin
  buttonSelected := MessageDlg(messageStr,mtConfirmation,[mbYes,mbNo],0);
  if buttonSelected = mrYes then begin
    isTestRunning := false;
    Stop;
    ResetTest;

    editCprFirst.Text := '';
    editCprSecond.Text := '';
    editFirstname.Text := '';
    editSurname.Text := '';
    memoComment.Text := '';

    for i := 0 to Length(blocks) - 1 do
      blocks[i] := nil;

    SetLength(blocks,0);

    lblTotalDuration.Caption := '00:00:00';
    lblAudioFile.Caption := 'Audio-file loaded:';
    lblTotalDioticBlocks.Caption := 'Diotic blocks: 0';
    lblTotalDichoticBlocks.Caption := 'Dichotic blocks: 0';

    drawGrid.Refresh();
    saved := true;  //Test is really not saved, but all is cleared as if no test is loaded.
    isTestLoaded := false;
    SetProgramState(Loading);
  end;
end;

//Detection button is clicked.
procedure TSDIAppForm.btnDetectionClick(Sender: TObject);
var
  i: Integer;
  btype : string;
begin
  for i := 0 to Length(blocks) - 1 do begin
    btype := blocks[i].BlockType;
    if (btype = 'Diotic') or (btype = 'Dichotic') then begin
      if not(blocks[i].Detected)and(blocks[i].IsWithinPlayZone(SoundPlayer.TimeElapsedSec)) then begin
        if not blocks[i].HasDetectionFailed(SoundPlayer.TimeElapsedSec) then begin
          blocks[i].Detected := true;
          if btype = 'Diotic' then
            inc(correctDiotic)
          else if btype = 'Dichotic' then
            inc(correctDichotic);
        end;
      end;
    end;
  end;
end;

//When the mouse is down on the Detection button.
procedure TSDIAppForm.btnDetectionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChangePanelColorDetection(true);
end;

//When the mouse is released from the Detection button.
procedure TSDIAppForm.btnDetectionMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChangePanelColorDetection(false);
end;

//Opens the CreateNewTest form.
procedure TSDIAppForm.btnCreateTestClick(Sender: TObject);
  var cntForm : TCreateNewTest;
begin
  cntForm := TCreateNewTest.Create(nil);
  cntForm.ShowModal();
  cntForm.Release();
end;

//Plays the audio file.
procedure TSDIAppForm.Play;
begin
  SoundPlayer.Play;
  Timer1.Enabled := true;
end;

//Stops the audio file.
procedure TSDIAppForm.Stop;
begin
    SoundPlayer.Stop;
    Timer1.Enabled := false;
    trackPosition.Position := 0;
    lblElapsed.Caption := SoundPlayer.TimeElapsedPresentation;
end;

//Pauses the autio file.
procedure TSDIAppForm.Pause;
begin
    SoundPlayer.Pause;
    Timer1.Enabled := false;
end;

//Sets the playposition of the played audiofile.
procedure TSDIAppForm.trackPositionChange(Sender: TObject);
begin
  if trackPosition.Position < SoundPlayer.ReadWaveHeaderObj.ChunkSize then
    SoundPlayer.PlayPosition := trackPosition.Position;
end;

//Procedure is called for every cell that needs to be redrawn.
procedure TSDIAppForm.drawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  var block : TBlock;
begin
  drawGrid.Canvas.Brush.Color := clLtGray;
  drawGrid.Canvas.FillRect(Rect);

  if (ACol = 0) and (ARow = 0) then
    drawGrid.Canvas.TextOut(Rect.Left,Rect.Top,'Diotic');
  if (ACol = 1) and (ARow = 0) then
    drawGrid.Canvas.TextOut(Rect.Left,Rect.Top,'Dichotic');

  if(length(blocks)>0) then begin
    block := blocks[ARow-1];

  if (ARow > 0)and(ARow < Length(blocks)+1) then begin
    //If block is of type Void
    if block.BlockType = 'Void' then begin
      drawGrid.Canvas.Brush.Color := clDkGray;
      drawGrid.Canvas.FillRect(Rect);
    end;
    //If block is of type Diotic
    if (block.BlockType = 'Diotic')and(ACol = 0) then begin
      if block.HasDetectionFailed(SoundPlayer.TimeElapsedSec) then
        block.Failed := true;
      drawGrid.Canvas.Brush.Color := CalculateBlockColor(block);
      drawGrid.Canvas.FillRect(Rect);
      drawGrid.Canvas.TextOut(Rect.Left+15,Rect.Top,block.StartTimePres);
    end;
    //If block is of type Dichotic
    if (block.BlockType = 'Dichotic')and(ACol = 1) then begin
      if block.HasDetectionFailed(SoundPlayer.TimeElapsedSec) then
        block.Failed := true;
      drawGrid.Canvas.Brush.Color := CalculateBlockColor(block);
      drawGrid.Canvas.FillRect(Rect);
      drawGrid.Canvas.TextOut(Rect.Left+15,Rect.Top,block.StartTimePres);
    end;
  end;
  end;
end;

//Calculates the color the block should be assigned.
function TSDIAppForm.CalculateBlockColor(block : TBlock) : TColor;
begin
      if block.Failed then
        Result := clRed
      else if block.IsWithinPlayZone(SoundPlayer.TimeElapsedSec)and not block.Detected then
        Result := clYellow
      else if block.IsWithinPlayZone(SoundPlayer.TimeElapsedSec)and block.Detected then
        Result := clLime
      else if block.Detected then
        Result := clLime
      else
        Result := clWhite;
end;

//When the MenuItem Exit is clicked.
procedure TSDIAppForm.menuExitClick(Sender: TObject);
begin
  Close();
end;

//When the MenuItem Save As is clicked.
procedure TSDIAppForm.menuSaveAsClick(Sender: TObject);
begin
  btnSaveTestResultsClick(self);
end;


//When the MenuItem Device Control is clicked.
procedure TSDIAppForm.menuDeviceControlClick(Sender: TObject);
begin
  deviceControlForm.SetFormPosition(Top+volCtrlForm.Height,Left+Width);
  deviceControlForm.Show();
end;

//When the MenuItem Volume Control is clicked.
procedure TSDIAppForm.menuVolumeControlClick(Sender: TObject);
begin
  btnVolumeControlClick(self);
end;

//When MenuItem About is clicked.
procedure TSDIAppForm.About2Click(Sender: TObject);
  var about : TAboutBox;
begin
  about := TAboutBox.Create(self);
  about.ShowModal();
  about.Release();
end;

//When the ScrollBar next to the DrawGrid is used.
procedure TSDIAppForm.sbTestScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  drawGrid.Top := (-1*ScrollPos)+1;
end;

//Sets the current state of the applicaton and displays it on the Form Title.
procedure TSDIAppForm.SetProgramState(Value: TSDIAppForm.TState);
  const titleText : string = 'Binaural Pitch Test';
begin
  State := Value;
  case State of
    Loading: begin
      btnStartTest.Enabled := false;
      btnPauseTest.Enabled := false;
      btnResetTest.Enabled := false;
    end;
    Ready: begin
      if fileContainsResults then begin
        btnStartTest.Enabled := false;
        btnResetTest.Enabled := true;
      end
      else begin
        btnStartTest.Enabled := true;
        btnResetTest.Enabled := false;
      end;
      btnPauseTest.Enabled := false;
      trackPosition.Enabled := false;
    end;
    TestStarted: begin
      btnResetTest.Enabled := true;
      btnPauseTest.Enabled := true;
      btnStartTest.Enabled := false;
      trackPosition.Enabled := false;
    end;
    TestPaused: begin
      btnPauseTest.Enabled := false;
      btnResetTest.Enabled := true;
      btnStartTest.Enabled := true;
      trackPosition.Enabled := false;
    end;
    TestResetted: begin
      btnResetTest.Enabled := false;
      btnPauseTest.Enabled := false;
      btnStartTest.Enabled := true;
      trackPosition.Enabled := true;
    end;
  end;
end;

//Fills the blocks array with TBlock objects containing data from the XML file.
procedure TSDIAppForm.FillBlocks;
var
  i: Integer;
  block : TBlock;
  xmlBlock : IXMLBlockType;
  xmlBlockResult : IXMLBlockResultType;
  binauralPitchTestDoc : IXMLBinauralPitchTestType;
  tempWaveFile : string;
begin

  binauralPitchTestDoc := BinauralPitchTest.GetBinauralPitchTest(xmlDoc);
  SetLength(blocks, binauralPitchTestDoc.TestConstruct.Blocks.Count);
  totalDioticBlocks := 0;
  totalDichoticBlocks := 0;

  tempWaveFile := binauralPitchTestDoc.TestConstruct.WaveFile;
  if (tempWaveFile <> '')and(ExtractFileExt(tempWaveFile)='.wav') then
    waveFile := defaultWaveDir + tempWaveFile;

  fileContainsResults := false;
  if binauralPitchTestDoc.Results.BlockResults.Count > 1 then
    fileContainsResults := true;

  for i := 0 to Length(blocks) - 1 do begin
    xmlBlock := binauralPitchTestDoc.TestConstruct.Blocks.Block[i];
    block := TBlock.Create;
    block.BlockType := xmlBlock.Type_;
    block.StartTime := xmlBlock.StartTime;
    block.EndTime := xmlBlock.EndTime;
    block.AnswerTime := xmlBlock.AnswerTime;
    if fileContainsResults then begin
      xmlBlockResult := binauralPitchTestDoc.Results.BlockResults[i];
      block.Detected := xmlBlockResult.Correct;
      block.Failed := xmlBlockResult.Failed;
    end;
    blocks[i] := block;
    if block.BlockType = 'Diotic' then
      Inc(totalDioticBlocks)
    else if block.BlockType = 'Dichotic' then
      Inc(totalDichoticBlocks);
      
    isTestLoaded := true;
    if fileContainsResults then
      InsertResultValuesFromXml();
  end;
end;

//Gets the correct answers in percentage.
function TSDIAppForm.PercentCorrect(blockType: string) : integer;
begin
  if (blockType = 'Diotic')and (totalDioticBlocks > 0) then
    Result := Round((correctDiotic/totalDioticBlocks)*100)
  else if (blockType = 'Dichotic')and(totalDichoticBlocks > 0) then
    Result := Round((correctDichotic/totalDichoticBlocks)*100)
  else if (blockType = 'Total')and ((totalDioticBlocks+totalDichoticBlocks) > 0) then begin
    if totalDioticBlocks+totalDichoticBlocks > 0 then
      Result := Round(((correctDiotic+correctDichotic)/(totalDioticBlocks+totalDichoticBlocks)*100))
    else
      Result := 0;
  end
  else
    Result := 0;
end;

//Clears all results labels.
procedure TSDIAppForm.ResetTest();
var
  i: Integer;
begin
  lblCorrectDiotic.Caption := '0';
  lblCorrectDichotic.Caption := '0';
  lblPercentDioticValue.Caption := '0%';
  lblPercentDichoticValue.Caption := '0%';
  lblPercentTotalValue.Caption := '0%';
  correctDiotic := 0;
  correctDichotic := 0;
  inputCount := 0;
  panelColorDetection.Caption := '0';
  for i := 0 to length(blocks) - 1 do begin
    blocks[i].Detected := false;
    blocks[i].Failed := false;
  end;
  drawGrid.Refresh;
  end;

  //Sets the Test-ScrollBar to match the height of drawGrid.
  procedure TSDIAppForm.SetScrollBarValues;
  begin
    if drawGrid.Height > panelTest.Height then begin
      sbTest.Enabled := true;
      sbTest.Max := drawGrid.Height - panelTest.Height+3;
    end
    else begin
      sbTest.Enabled := false;
    end;
  end;

//Extracts the patient data from the clipboard and loads them into the editFields.
//The clipboard contains the patients firstname, surname, address and cpr-nr. if
//application is executed via AuditBase. Function returns false if no usefull
//information was found.
function TSDIAppForm.ExtractPatientDataFromCB() : boolean;
  var
    text : string;
    int : integer;
    name,address,city,birth,cpr : string;
begin
  if Clipboard.AsText <> '' then begin
    text := Clipboard.AsText;
    name := Copy(text,0,AnsiPos(Chr(10),text)-2);
    Delete(text,1,AnsiPos(Chr(10),text));
    address := Copy(text,0,AnsiPos(Chr(10),text)-1);
    Delete(text,1,AnsiPos(Chr(10),text));
    city := Copy(text,0,AnsiPos(Chr(10),text)-1);
    Delete(text,1,AnsiPos(Chr(10),text));
    birth := Copy(text,0,AnsiPos(Chr(10),text)-1);
    Delete(text,1,AnsiPos(Chr(10),text));
    cpr := Copy(text,10,length(text));

    cpr := StringReplace(cpr,'-','',[rfReplaceAll]);
    if TryStrToInt(cpr, int) and (Length(cpr) = 10) then begin //If string contains a cpr nr.
      editCprFirst.Text := Copy(cpr,0,6);
      editCprSecond.Text := Copy(cpr,7,10);

      editFirstname.Text := Copy(name,0,AnsiPos(' ',name));
      Delete(name,1,AnsiPos(' ',name));
      editSurname.Text := name;

      Result := true;
    end
    else
      Result := false;
  end
  else
    Result := false;
end;


//If no patient data was passed from AuditBase, we will look for patient data in
//the xml file (if such a file is loaded). 
function TSDIAppForm.ExtractPatientDataFromXml() : boolean;
  var binauralPitchTestDoc : IXMLBinauralPitchTestType;
  cpr : string;
  int : int64;
  valid : boolean;
begin
  binauralPitchTestDoc := BinauralPitchTest.GetBinauralPitchTest(xmlDoc);
  if not (binauralPitchTestDoc.PatientInfo.Cpr = '') then begin
    cpr := binauralPitchTestDoc.PatientInfo.Cpr;
    if TryStrToInt64 (cpr, int) and (Length(cpr) = 10) then begin //If string contains a cpr nr.
      editCprFirst.Text := Copy(cpr,0,6);
      editCprSecond.Text := Copy(cpr,7,10);

      editFirstname.Text := binauralPitchTestDoc.PatientInfo.Firstname;
      editSurname.Text := binauralPitchTestDoc.PatientInfo.Surname;

      valid := true;
    end
    else
      valid := false;
  end
  else
    valid := false;
  memoComment.Text := binauralPitchTestDoc.PatientInfo.Comment;
  if not valid then begin
    editCprFirst.Clear;
    editCprSecond.Clear;
    editFirstname.Clear;
    editSurname.Clear;
  end;
  Result := valid;
end;

//Sets the patient data editFields readonly property to true/false
procedure TSDIAppForm.PatientFieldsReadOnly(bool: Boolean);
begin
  editCprFirst.ReadOnly := bool;
  editCprSecond.ReadOnly := bool;
  editFirstname.ReadOnly := bool;
  editSurname.ReadOnly := bool;
end;
{
//Checks if the data entered in the patient data editFields is valid.
function TSDIAppForm.IsPatientDataValid() : boolean;
  var isValid : boolean;
    int : integer;
begin
  isValid := true;

  if (editCprFirst.Text = '')and not(TryStrToInt(editCprFirst.Text,int)) then
    isValid := false;
  if (editCprSecond.Text = '')and not(TryStrToInt(editCprSecond.Text,int)) then
    isValid := false;
  if editFirstname.Text = '' then
    isValid := false;
  if editSurname.Text = '' then
    isValid := false;

  Result := isValid;
end;
 }

procedure TSDIAppForm.hidDeviceControllerDeviceChange(Sender: TObject);
var
  i: Integer;
  dev : TJvHidDevice;
begin

  for i := 0 to Length(deviceList) - 1 do begin
    dev := TJvHidDevice(deviceList[i]);
    hidDeviceController.CheckIn(dev);
  end;
  for i := 0 to Length(deviceList) - 1 do
    deviceList[i] := nil;
  SetLength(deviceList,0);
  hidDeviceController.Enumerate();
end;

procedure TSDIAppForm.hidDeviceControllerDeviceData(HidDev: TJvHidDevice;
  ReportID: Byte; const Data: Pointer; Size: Word);
  var
    dataInt : integer;
    i : integer;
begin
  dataInt := 0;
  for i := 0 to Size - 1 do
    dataInt := dataInt or Cardinal(PChar(Data)[i]);
  if dataInt <> 0 then begin
    ChangePanelColorDetection(true);
    btnDetectionClick(self);
  end
  else
    ChangePanelColorDetection(false);
end;

function TSDIAppForm.hidDeviceControllerEnumerate(HidDev: TJvHidDevice;
  const Idx: Integer): Boolean;
  var dev : TJvHidDevice;
begin
  hidDeviceController.CheckOutByIndex(dev,Idx);
  SetLength(deviceList,Length(deviceList)+1);
  deviceList[Length(deviceList)-1] := dev;

  Result := true;
end;

//Loads the result labels with data from the loaded xml file.
procedure TSDIAppForm.InsertResultValuesFromXml();
  var binPitchTestDoc : IXMLBinauralPitchTestType;
begin
  binPitchTestDoc := BinauralPitchTest.GetBinauralPitchTest(xmlDoc);
  lblCorrectDiotic.Caption := IntToStr(binPitchTestDoc.Results.CorrectDiotic);
  lblCorrectDichotic.Caption := IntToStr(binPitchTestDoc.Results.CorrectDichotic);
  lblPercentDioticValue.Caption := IntToStr(binPitchTestDoc.Results.PercentDiotic)+'%';
  lblPercentDichoticValue.Caption := IntToStr(binPitchTestDoc.Results.PercentDichotic)+'%';
  lblPercentTotalValue.Caption := IntToStr(binPitchTestDoc.Results.PercentTotal)+'%';
end;

//Changes the patient input panel color.
procedure TSDIAppForm.ChangePanelColorDetection(buttonDown: Boolean);
begin
  if buttonDown then begin
    panelColorDetection.Color := clRed;
    Inc(inputCount);
    panelColorDetection.Caption := IntToStr(inputCount);
  end
  else
    panelColorDetection.Color := clGreen;
end;
end.


