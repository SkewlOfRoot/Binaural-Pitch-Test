program DetectionTest;

uses
  Forms,
  SDIMAIN in 'SDIMAIN.PAS' {SDIAppForm},
  CreateNewTestForm in 'Forms\CreateNewTestForm.pas' {CreateNewTest},
  DeviceControlForm in 'Forms\DeviceControlForm.pas' {DeviceControl},
  SaveAsForm in 'Forms\SaveAsForm.pas' {SaveAs},
  VolumeControlForm in 'Forms\VolumeControlForm.pas' {VolumeControl},
  MasterVolAtt in 'Sound\MasterVolAtt.pas',
  MixerUnit in 'Sound\MixerUnit.pas',
  ReadWaveHeader in 'Sound\ReadWaveHeader.pas',
  SoundPlayer in 'Sound\SoundPlayer.pas',
  BinauralPitchTest in 'XML\BinauralPitchTest.pas',
  SoundCardCalib in 'XML\SoundCardCalib.pas',
  ABOUT in 'Forms\ABOUT.PAS' {AboutBox},
  AuditBaseFileFixer in 'Misc\AuditBaseFileFixer.pas',
  Block in 'Misc\Block.pas',
  ConfigFile in 'Misc\ConfigFile.pas',
  PatientData in 'Misc\PatientData.pas',
  ResultData in 'Misc\ResultData.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'BinauralPitchTest';
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.CreateForm(TCreateNewTest, CreateNewTest);
  Application.CreateForm(TDeviceControl, DeviceControl);
  Application.CreateForm(TSaveAs, SaveAs);
  Application.CreateForm(TVolumeControl, VolumeControl);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

