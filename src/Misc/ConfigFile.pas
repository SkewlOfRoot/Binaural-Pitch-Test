unit ConfigFile;

interface
uses SysUtils,IniFiles,Dialogs;

  type
    TConfigFile = class

    private
      iniFilePath : string;
      waveDir : string;
      testDir : string;
      resultDir : string;
      soundCardDir : string;
      splLevel : integer;
      splOff : integer;
      bptExt : string;
      isAdminBool : boolean;
      mixerMasterVolInt : integer;
      function GetDefaultWaveDir() : string;
      function GetDefaultTestDir() : string;
      function GetDefaultResultDir() : string;
      function GetSoundCardCalibDir() : string;
      function GetDefaultSplLevel() : integer;
      function GetSplOffset() : integer;
      function GetBptExtension() : string;
      function GetAdmin() : boolean;
      function GetMixerMasterVol() : integer;
      procedure SetMixerMasterVol(value : integer);

    public
      property DefaultWaveDir : string read GetDefaultWaveDir;
      property DefaultTestDir : string read GetDefaultTestDir;
      property DefaultResultDir : string read GetDefaultResultDir;
      property SoundCardCalibDir : string read GetSoundCardCalibDir;
      property DefaultSplLevel : integer read GetDefaultSplLevel;
      property SplOffset : integer read GetSplOffset;
      property BptExtension : string read GetBptExtension;
      property IsAdmin : boolean read GetAdmin;
      property MixerMasterVol : integer read GetMixerMasterVol write SetMixerMasterVol;

    published
      constructor Create(iniPath : string);
    end;

implementation

constructor TConfigFile.Create(iniPath: string);
  var iniFile : TIniFile;
begin
  iniFilePath := iniPath;
  if FileExists(iniFilePath) then begin
    iniFile := TIniFile.Create(iniFilePath);
    try
      waveDir := iniFile.ReadString('Const','Default wave dir', 'C:\DetectionTest\Wave\');
      testDir := iniFile.ReadString('Const','Default tests dir', 'C:\DetectionTest\Tests\');
      resultDir := iniFile.ReadString('Const','Default results dir', 'C:\DetectionTest\Results\');
      soundCardDir := iniFile.ReadString('Const','SoundCardCalib','C:\DetectionTest\SoundCardCalib.xml');
      splLevel := iniFile.ReadInteger('Const','DefaultSplLevel',55);
      splOff := iniFile.ReadInteger('Const','SplOffset',55);
      bptExt := iniFile.ReadString('Const','BptExt','bpt');
      isAdminBool := iniFile.ReadBool('Const','Admin', false);
      mixerMasterVolInt := iniFile.ReadInteger('Const','MixerMasterVol',65535);
    finally
      if iniFile <> nil then
        iniFile.Free;
    end
  end
  else
    ShowMessage('DetectionTest.ini was not found!');
end;

function TConfigFile.GetDefaultWaveDir() : string; begin Result := waveDir; end;
function TConfigFile.GetDefaultTestDir() : string; begin Result := testDir; end;
function TConfigFile.GetDefaultResultDir() : string; begin Result := resultDir; end;
function TConfigFile.GetSoundCardCalibDir() : string; begin Result := soundCardDir; end;
function TConfigFile.GetDefaultSplLevel():integer; begin Result := splLevel; end;
function TConfigFile.GetSplOffset():integer; begin Result := splOff; end;
function TConfigFile.GetBptExtension():string; begin Result := bptExt; end;
function TConfigFile.GetAdmin():boolean; begin Result := isAdminBool; end;
function TConfigFile.GetMixerMasterVol():integer; begin Result := mixerMasterVolInt; end;

procedure TConfigFile.SetMixerMasterVol(value: Integer);
  var iniFile : TIniFile;
begin
  if FileExists(iniFilePath) then begin
    iniFile := TIniFile.Create(iniFilePath);
    try
      iniFile.WriteString('Const','MixerMasterVol',IntToStr(value));
    finally
      iniFile.Free;
    end;
  end;
  mixerMasterVolInt := value;
end;
end.
