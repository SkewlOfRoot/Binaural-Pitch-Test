unit VolumeControlForm;

interface

uses
  Windows, SysUtils, Forms, Dialogs, SoundPlayer, MMSystem, IniFiles,
  xmldom, XMLIntf, msxmldom, XMLDoc, SoundCardCalib, MasterVolAtt, ComCtrls,
  StdCtrls, Classes, Controls, MixerUnit, ConfigFile;

type
  TVolumeControl = class(TForm)
    grpPlayControl: TGroupBox;
    btnVolumeDefault: TButton;
    chkMute: TCheckBox;
    lblPan: TLabel;
    lblVolume: TLabel;
    trackPan: TTrackBar;
    trackVolume: TTrackBar;
    GroupBox2: TGroupBox;
    trackSpl: TTrackBar;
    Label2: TLabel;
    xmlDoc: TXMLDocument;
    editSplLevel: TEdit;
    btnSetSpl: TButton;
    lblSplLevel: TLabel;
    btnClose: TButton;
    procedure trackPanChange(Sender: TObject);
    procedure trackVolume1Change(Sender: TObject);
    procedure btnVolumeDefaultClick(Sender: TObject);
    procedure chkMuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trackVolumeChange(Sender: TObject);
    procedure trackSplChange(Sender: TObject);
    procedure btnSetSplClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    configFile : TConfigFile;
    soundPlayer : TSoundPlayer;
    lastPos : integer;
    soundCardCalibFilePath : string;
    defaultSplLevel : integer;
    splOffset : integer;
    calibValues : array of TMasterVolAtt;
    mixer : TnsMixerControl;
    mixerMasterVol : integer;
    initialWaveOutVol : integer;
    initialMasterVol : integer;
    appHandle : HWND;
    procedure SetSoundPlayer(value : TSoundPlayer);
    procedure InitializeFromIniFile();
    procedure ExtractSoundCardCalibValues();
    function IsSplLevelValid() : boolean;

  public
    { Public declarations }
    procedure InitializeMixer(_aOwner:TComponent; _Handle:HWND);
    procedure MixerDestroy();
    procedure SetFormPosition(_top,_left : integer);
    property SoundPlayerProp : TSoundPlayer write SetSoundPlayer;
  end;

var
  VolumeControl: TVolumeControl;

implementation
uses SDIMain;
{$R *.dfm}
{$Optimization Off}

procedure TVolumeControl.FormCreate(Sender: TObject);
begin
  InitializeFromIniFile();
  ExtractSoundCardCalibValues();
  trackSpl.Max := Length(calibValues)-1;
  lblSplLevel.Caption := 'Enter SPL level between '+IntToStr(trackSpl.Min+splOffset)+' and '+IntToStr(trackSpl.Max+splOffset)+':';
  trackVolume.Frequency := trackVolume.LineSize;
  trackPan.Frequency := trackPan.LineSize;
end;


procedure TVolumeControl.FormDestroy(Sender: TObject);
begin
  configFile.Free;
end;

procedure TVolumeControl.MixerDestroy();
begin
  //Sets the Master- and Wave-out volume to its original values.
  if mixer <> nil then begin

    //mixer.SetControlValue(initialMasterVol);
   //mixer.Destroy;
    //mixer:= TnsMixerControl.aCreate(self, AppHandle,MIXERLINE_COMPONENTTYPE_DST_SPEAKERS,
                                  //MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT, {Indstiller "Wave"}
                                  //MIXERCONTROL_CONTROLTYPE_VOLUME);
    //mixer.SetControlValue(initialWaveOutVol);
    //mixer.Destroy;
    configFile.MixerMasterVol := mixer.GetControlValue;
    mixer.Destroy;
  end;
end;

procedure TVolumeControl.InitializeFromIniFile();
  var
    inipath : string;
begin
    inipath := ExtractFileDir(Application.ExeName)+'\DetectionTest.ini';
    configFile := TConfigFile.Create(iniPath);
  try
    soundCardCalibFilePath := configFile.SoundCardCalibDir;
    defaultSplLevel := configFile.DefaultSplLevel;
    splOffset := configFile.SplOffset;
    mixerMasterVol := configFile.MixerMasterVol;
  finally
    //configFile.Free;
  end;
end;

procedure TVolumeControl.InitializeMixer(_aOwner: TComponent; _Handle: HWND);
begin
  appHandle := _Handle;
  if _aOwner = nil then
    mixer := nil
  else begin
    //Initializes the mixer to handle the Wave-out volume.
    mixer := TnsMixerControl.aCreate(_aOwner,appHandle,MIXERLINE_COMPONENTTYPE_DST_SPEAKERS,
                                                      MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT,
                                                      MIXERCONTROL_CONTROLTYPE_VOLUME);
    //initialWaveOutVol := mixer.GetControlValue();
    mixer.SetControlValue(65535);   //Sets Wave-out volume to max so there is no wave-damping.
    mixer.Destroy;
    //Initializes the mixer to handle the Master volume.
    mixer := TnsMixerControl.aCreate(_aOwner, appHandle,MIXERLINE_COMPONENTTYPE_DST_SPEAKERS,
                                                        NO_SOURCE,
                                                        MIXERCONTROL_CONTROLTYPE_VOLUME);
    //initialMasterVol := mixer.GetControlValue();
    mixer.SetControlValue(mixerMasterVol);
    trackSpl.Position := defaultSplLevel-splOffset;
  end;
end;


procedure TVolumeControl.btnCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TVolumeControl.btnSetSplClick(Sender: TObject);
begin
  if IsSplLevelValid then
    trackSpl.Position := StrToInt(editSplLevel.Text)-splOffset
  else
    ShowMessage('Entered SPL level is invalid. SPL level must be an integer '+
                'between '+IntToStr(trackSpl.Min+splOffset)+' and' +
                IntToStr(trackSpl.Max+splOffset)+'.');
end;

//When the Default button is clicked.
procedure TVolumeControl.btnVolumeDefaultClick(Sender: TObject);
begin
  trackPan.Position := 0;
  if not chkMute.Checked then
    //trackSpl.Position := defaultSplLevel-splOffset;
    trackVolume.Position := trackVolume.Max-mixerMasterVol;
    //trackVolume.Position := trackVolume.Min;
end;

//When the mute checkbox is checked.
procedure TVolumeControl.chkMuteClick(Sender: TObject);
begin
  if chkMute.Checked then begin
    lastPos := trackVolume.Position;
    trackVolume.Position := trackVolume.Max;
  end
  else
    trackVolume.Position := lastPos;
end;

procedure TVolumeControl.SetSoundPlayer(value : TSoundPlayer);
begin
  soundPlayer := value;
end;

//Set the audio volume level.
procedure TVolumeControl.trackVolume1Change(Sender: TObject);
begin
  soundPlayer.Volume := - trackVolume.Position;
end;

//Set the audio pan level.
procedure TVolumeControl.trackPanChange(Sender: TObject);
begin
  soundPlayer.Pan := trackPan.Position;
end;

procedure TVolumeControl.trackVolumeChange(Sender: TObject);
  var volume : integer;
begin
  volume := trackVolume.Max-trackVolume.Position;
  mixer.SetControlValue(volume);
end;

procedure TVolumeControl.trackSplChange(Sender: TObject);
var
  i: Integer;
  volume : integer;
  spl : integer;
begin
  spl := 0;
  for i := 0 to Length(calibValues) - 1 do begin
    if trackSpl.Position = calibValues[i].DB then begin
      volume := calibValues[i].SoundCardVal;
      trackVolume.Position := trackVolume.Max - volume;
      spl := calibValues[i].DBValInSPL;
    end;
  end;
  Label2.Caption := IntToStr(spl)+' dB SPL';
end;



procedure TVolumeControl.ExtractSoundCardCalibValues();
  var
    soundCardCalibDoc : IXMLSoundCardCalibType;
    masterVolAttXml : IXMLMasterVolAttType;
    masterVolAtt : TMasterVolAtt;
    i : integer;
    numOfValues : integer;
begin
  if FileExists(soundCardCalibFilePath) then begin
    xmlDoc.FileName := soundCardCalibFilePath;
    soundCardCalibDoc := SoundCardCalib.GetSoundCardCalib(xmlDoc);
    numOfValues := soundCardCalibDoc.MasterVolume.Count;
    SetLength(calibValues,numOfValues);
    for i := 0 to numOfValues - 1 do begin
      masterVolAttXml := soundCardCalibDoc.MasterVolume[i];
      masterVolAtt := TMasterVolAtt.Create;
      masterVolAtt.DB := masterVolAttXml.DB;
      masterVolAtt.SoundCardVal := masterVolAttXml.SoundCardVal;
      calibValues[i] := masterVolAtt;
    end;
  end
  else
    ShowMessage(soundCardCalibFilePath +' was not found.');
end;

function TVolumeControl.IsSplLevelValid() : boolean;
  var
    isValid : boolean;
    spl : integer;
    int : integer;
begin
  isValid := true;
  if(editSplLevel.Text <> '') and (TryStrToInt(editSplLevel.Text,int)) then begin
    spl := StrToInt(editSplLevel.Text);
    if (spl < trackSpl.Min+splOffset) or (spl > trackSpl.Max+splOffset) then
      isValid := false;
  end
  else
    isValid := false;
  Result := isValid;
end;

procedure TVolumeControl.SetFormPosition(_top: Integer; _left: Integer);
begin
  Top := _top;
  Left := _left;
end;

end.
