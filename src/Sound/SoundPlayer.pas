unit SoundPlayer;

interface
uses
  Windows, SysUtils, MMsystem, DDirectSound, DSound, Wave, Classes, Dialogs,
    ReadWaveHeader ;

  type
    TSoundPlayer = class

    Private
      DS:         TDirectSound;
      pbData:     PBYTE;               // Pointer to actual data of file.
      cbSize:     Longint;             // Size of data.
      pwfx:       PWAVEFORMATEX;          // Pointer to waveformatex structure.
      //dwVol:      Longint;          // Total volume.
      //fHardware:  Boolean;      // Is this a hardware buffer?
      DSB:        TDirectSoundBuffer; // Pointer to direct sound buffer.
      FileLoaded: boolean;
      DS_Range : integer;       //May not need to be global.
      DS_dBfactor : integer;    //May not need to be global.
      fileName : string;
      ReadWaveHeader : TReadWaveHeader;
      procedure NewDirectSoundBuffer;
      procedure ReleaseDirectSoundBuffer;
      function GetReadWaveHeaderObj() : TReadWaveHeader;
      function GetVolume() : integer;
      procedure SetVolume(value : integer);
      function GetPan() : integer;
      procedure SetPan(value : integer);
      function GetPlayPosition() : integer;
      procedure SetPlayPosition(value : integer);
      procedure ReadHeader(filename : string);
      function GetDurationSec() : integer;
      function GetDurationPresentation() : string;
      function GetTimeElapsedSec() : integer;
      function GetTimeElapsedPresentation() : string;
      function SecondsToTimeFormat(totalSec : integer) : string;
      function GetFileLoaded() : boolean;

    Public
      procedure InitDirectSound(applicationHandle : HWND);
      procedure CloseDirectSound;
      function LoadFileDirectSound(_LF:string):boolean;
      procedure CloseFileDirectSound;
      procedure Play;
      procedure Stop;
      procedure Pause;

      //Public properties
      property ReadWaveHeaderObj : TReadWaveHeader read GetReadWaveHeaderObj;
      property Volume : integer read GetVolume write SetVolume;
      property Pan : integer read GetPan write SetPan;
      property PlayPosition : integer read GetPlayPosition write SetPlayPosition;
      property DurationSec : integer read GetDurationSec;
      property DurationPresentation : string read GetDurationPresentation;
      property TimeElapsedSec : integer read GetTimeElapsedSec;
      property TimeElapsedPresentation : string read GetTimeElapsedPresentation;
      property HasFileLoaded : boolean read GetFileLoaded;
    end;

implementation
  procedure TSoundPlayer.NewDirectSoundBuffer;
    var
      bd, bd2: Pointer;
      dsbd: TDSBufferDesc;
      Len, Len2: DWord;
  begin
    try
      // Set up the direct sound buffer.
      ZeroMemory( @dsbd, sizeof(dsbd) );
      dsbd.dwSize := sizeof(TDSBUFFERDESC);
      dsbd.dwFlags := 0 or DSBCAPS_STATIC;
      // Use new GetCurrentPosition() accuracy (DirectX 2 feature)
      dsbd.dwFlags := dsbd.dwFlags or DSBCAPS_CTRLDEFAULT
       or DSBCAPS_GETCURRENTPOSITION2 or DSBCAPS_GLOBALFOCUS;

      dsbd.dwBufferBytes := cbSize;
      dsbd.lpwfxFormat := pwfx;

      DSB := TDirectSoundBuffer.Create( DS, dsbd );

      // Ok, lock the sucker down, and copy the memory to it.
      DSB.Lock( 0, cbSize, bd, Len, bd2, Len2, 0 );
      try
        CopyMemory( bd, pbData, cbSize );
      finally
        // Ok, now unlock the buffer, we don't need it anymore.
        DSB.Unlock( bd, cbSize, nil, 0 );
      end;

      bd := nil;

      DSB.Volume := 0;
      DSB.Pan := 0;
      //Check if its a hardware buffer.
      //if (DSB.Caps.dwFlags and DSBCAPS_LOCHARDWARE) <> 0 then fHardware := True
      //else fHardware := False;
    except
      on EDirectSoundError do
      begin
        DSB.Free;
        DSB := nil;
        raise;
      end;
    end;
  end;

  procedure TSoundPlayer.ReleaseDirectSoundBuffer;
  begin
    if DSB<>nil then DSB.Free;
    DSB := nil;
  end;

  procedure TSoundPlayer.InitDirectSound(applicationHandle : HWND);
    var appHandle : HWND;
  begin
    appHandle := applicationHandle;
    DS := TDirectSound.Create( nil, 0 );
    // Note we need to set the level to be priority to set the
    // format of the primary buffer
    DS.SetCooperativeLevel( appHandle, DSSCL_PRIORITY ); // ???????
    DS.PrimaryBuffer.Play( DSBPLAY_LOOPING );
    DS_Range:=60;      // dB
    DS_dBfactor:= 100; // DirectSound step pr. dB
    FileLoaded:=false;
  end;

  procedure TSoundPlayer.CloseDirectSound;
  begin
    // Destroy the direct sound
    DS.Free;
    DSB:=nil;
    CloseFileDirectSound;
  end;

  function TSoundPlayer.LoadFileDirectSound(_LF:string):boolean;
    var OK:boolean;
      //fileName : string;
  begin
    OK:=true;
    CloseFileDirectSound;
    fileName:=_LF;
    try
      WaveLoadFile( fileName, cbSize, pwfx, Pointer(pbData) );
    except
      on exception do OK:=false;
    end;
    if OK then begin
      NewDirectSoundBuffer;
      DSB.Volume:=0;
    end;
    LoadFileDirectSound:=OK;
    FileLoaded:=OK;
    ReadHeader(fileName);
  end;

  procedure TSoundPlayer.CloseFileDirectSound;
  begin
    if FileLoaded then begin
      ReleaseDirectSoundBuffer;
      FreeMem( pwfx );
      FreeMem( pbData );
      FileLoaded:=false;
    end;
  end;

  procedure TSoundPlayer.Play;
  begin
    if (DSB.Status and DSBSTATUS_PLAYING <> 0) then
      // Don't bother playing, just restart
  //      DSB.PlayPosition := 0
    else
      if FileLoaded then
        DSB.Play( 0 );
  end;

  procedure TSoundPlayer.Stop;
  begin
    if FileLoaded then begin
      DSB.Stop;
      DSB.PlayPosition := 0;
    end;
  end;

  procedure TSoundPlayer.Pause;
  begin
    if FileLoaded then
      DSB.Stop;
  end;

  function TSoundPlayer.GetVolume() : integer;
  begin
    if FileLoaded then
      Result := DSB.Volume
    else
      Result := 0;
  end;

  procedure TSoundPlayer.SetVolume(value: Integer);
  begin
    if FileLoaded then
      DSB.Volume := value;
  end;

  function TSoundPlayer.GetPan() : integer;
  begin
    if FileLoaded then
      Result := DSB.Pan
    else
      Result := 0;
  end;

  procedure TSoundPlayer.SetPan(value: Integer);
  begin
    if FileLoaded then
      DSB.Pan := value;
  end;

  function TSoundPlayer.GetPlayPosition;
  begin
    Result := DSB.PlayPosition;
  end;

  procedure TSoundPlayer.SetPlayPosition(value: Integer);
  begin
    if FileLoaded then
      DSB.PlayPosition := value;
  end;

  function TSoundPlayer.GetReadWaveHeaderObj : TReadWaveHeader;
  begin
    if FileLoaded then
      Result := ReadWaveHeader
    else
      Result := nil;
  end;

  function TSoundPlayer.GetDurationSec : integer;
  begin
    Result := Trunc(ReadWaveHeader.ChunkSize / ReadWaveHeader.ByteRate);
  end;

  function TSoundPlayer.GetDurationPresentation : string;
  begin
    Result := SecondsToTimeFormat(DurationSec);
  end;

  function TSoundPlayer.GetTimeElapsedSec : integer;
    var byteRate : integer;
  begin
    if FileLoaded then begin
      byteRate := Trunc((ReadWaveHeader.BitsPerSample/8))*ReadWaveHeader.NumChannels*ReadWaveHeader.SampleRate;
      Result := Trunc(DSB.PlayPosition / byteRate);
    end
    else
      Result := 0;
  end;

  function TSoundPlayer.GetTimeElapsedPresentation : string;
  begin
    Result := SecondsToTimeFormat(TimeElapsedSec);
  end;

  function TSoundPlayer.GetFileLoaded() : boolean;
  begin
    Result := FileLoaded;
  end;

  function TSoundPlayer.SecondsToTimeFormat(totalSec: Integer) : string;
    var h,m,s : integer;
    var hh, mm, ss : string;
  begin
    h := totalSec div 3600;
    m := totalSec div 60 - h*60;
    s := totalSec - (h*3600 + m*60);

    hh := IntToStr(h);
    mm := IntToStr(m);
    ss := IntToStr(s);

    if (h >= 0)and(h<10) then
      hh := '0'+hh;

    if (m >= 0)and(m<10) then
      mm := '0'+mm;

    if (s >= 0)and(s<10) then
      ss := '0'+ss;

    Result := hh+':'+mm+':'+ss;
  end;

  procedure TSoundPlayer.ReadHeader(filename : string);
  begin
    ReadWaveHeader := TReadWaveHeader.Create;
    ReadWaveHeader.ReadHeader(filename);
  end;
end.
