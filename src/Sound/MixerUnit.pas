unit MixerUnit;

// thanks to the example from Alexander Fedorov
// http://codeguru.developer.com/multimedia/simple_mixer.shtml


interface

uses
  Windows, Messages, SysUtils, Classes, MMSystem;

const NO_SOURCE = 0;

type
  TnsMixerControl = class(TComponent)
  protected
    m_HMixer: THandle;
    m_iMixerControlID: Integer;
    mmr: UINT;
    m_dwChannels: DWORD;
    m_bSuccess: BOOL;

    procedure ZeroAll;
  public
    constructor aCreate(aOwner:TComponent;
                        DstType,SrcType,ControlType:DWORD); overload;
    constructor aCreate(aOwner:TComponent; hwnd:HWND;
                        DstType,SrcType,ControlType:DWORD); overload;
    destructor Destroy; override;

    property IsOk: BOOL read m_bSuccess;
    function mixerOn:BOOL;
    function mixerOff:BOOL;
    function GetControlValue: DWORD;
    function SetControlValue(dw: DWORD): BOOL;
  end;

//var
//  mixer:TnsMixerControl;


implementation

procedure TnsMixerControl.ZeroAll;
begin
  m_HMixer := 0;
  m_iMixerControlID := 0;
  mmr := 0;
  m_dwChannels := 0;
  m_bSuccess := FALSE;
end;

constructor TnsMixerControl.aCreate(aOwner:TComponent;
DstType,SrcType,ControlType:DWORD);
var mxl:TMIXERLINE; nconn,j:UINT; DstIndex:DWORD; mxc:TMIXERCONTROL;
mxlc:TMIXERLINECONTROLS;
begin
  inherited Create(aOwner);
  ZeroAll;
  if (mixerGetNumDevs < 1) then Abort;
  mmr := mixerOpen(@m_HMixer, 0, 0, 0, CALLBACK_NULL);
  if (mmr <> MMSYSERR_NOERROR) then Abort;
  // get dwLineID
  mxl.cbStruct := sizeof(MIXERLINE);
  // DstType
  mxl.dwComponentType := DstType;
  if (mixerGetLineInfo(m_HMixer, @mxl,
         MIXER_OBJECTF_HMIXER or MIXER_GETLINEINFOF_COMPONENTTYPE)
        <>
      MMSYSERR_NOERROR)
  then
    Abort;
  // SrcType
  if ( SrcType <> NO_SOURCE ) then
  begin
    nconn := mxl.cConnections;
    DstIndex := mxl.dwDestination;
    for j:=0 to nconn-1 do
    begin
      mxl.cbStruct := sizeof( MIXERLINE );
      mxl.dwSource := j;
      mxl.dwDestination := DstIndex;
      if (mixerGetLineInfo(m_HMixer, @mxl, MIXER_GETLINEINFOF_SOURCE ) <>
MMSYSERR_NOERROR) then Abort;
      if ( mxl.dwComponentType = SrcType ) then break;
    end;
  end;
  // get dwControlID
  mxlc.cbStruct := sizeof(TMIXERLINECONTROLS);
  mxlc.dwLineID := mxl.dwLineID;
  mxlc.dwControlType := ControlType;
  mxlc.cControls := 1;
  mxlc.cbmxctrl := sizeof(TMIXERCONTROL);
  mxlc.pamxctrl := @mxc;
  if (mixerGetLineControls(m_HMixer, @mxlc, MIXER_OBJECTF_HMIXER or
MIXER_GETLINECONTROLSF_ONEBYTYPE) <> MMSYSERR_NOERROR) then Abort;
  m_iMixerControlID := mxc.dwControlID;
  m_dwChannels := mxl.cChannels;
  if (m_dwChannels > 0) then dec(m_dwChannels);
  m_bSuccess := TRUE;
end;

constructor TnsMixerControl.aCreate(aOwner:TComponent; hwnd:HWND;
DstType,SrcType,ControlType:DWORD);
var
  mxl:TMIXERLINE;
  nconn,j:UINT;
  DstIndex:DWORD;
  //iii : DWORD;
  mxc:TMIXERCONTROL;
  mxlc:TMIXERLINECONTROLS;
begin
  inherited Create(aOwner);
  ZeroAll;
  //iii:=mixerGetNumDevs;
  if (mixerGetNumDevs < 1) then Abort;
  mmr := mixerOpen(@m_HMixer, 0, hwnd, 0, CALLBACK_WINDOW);
  if (mmr <> MMSYSERR_NOERROR) then Abort;
  // get dwLineID
  mxl.cbStruct := sizeof(MIXERLINE);
  // DstType
  mxl.dwComponentType := DstType;
  //iii:=mixerGetLineInfo(m_HMixer, @mxl,
  //MIXER_OBJECTF_HMIXER or MIXER_GETLINEINFOF_COMPONENTTYPE);
  if (mixerGetLineInfo(m_HMixer, @mxl,
  MIXER_OBJECTF_HMIXER or MIXER_GETLINEINFOF_COMPONENTTYPE) <> MMSYSERR_NOERROR)
  then
    Abort;
  // SrcType
  if ( SrcType <> NO_SOURCE ) then
  begin
    nconn := mxl.cConnections;
    DstIndex := mxl.dwDestination;
    for j := 0 to nconn-1 do
    begin
      mxl.cbStruct := sizeof( MIXERLINE );
      mxl.dwSource := j;
      mxl.dwDestination := DstIndex;
      if (mixerGetLineInfo(m_HMixer, @mxl, MIXER_GETLINEINFOF_SOURCE ) <>
MMSYSERR_NOERROR) then Abort;
      if ( mxl.dwComponentType = SrcType ) then break;
    end;
  end;
  // get dwControlID
  mxlc.cbStruct := sizeof(MIXERLINECONTROLS);
  mxlc.dwLineID := mxl.dwLineID;
  mxlc.dwControlType := ControlType;
  mxlc.cControls := 1;
  mxlc.cbmxctrl := sizeof(TMIXERCONTROL);
  mxlc.pamxctrl := @mxc;
  if (mixerGetLineControls(m_HMixer, @mxlc, MIXER_OBJECTF_HMIXER or
                    MIXER_GETLINECONTROLSF_ONEBYTYPE) <> MMSYSERR_NOERROR) then
    Abort;
  m_iMixerControlID := mxc.dwControlID;
  m_dwChannels := mxl.cChannels;
  if (m_dwChannels > 0) then dec(m_dwChannels);
  m_bSuccess := TRUE;
end;

destructor TnsMixerControl.Destroy;
begin
  if (m_HMixer <> 0) then mixerClose(m_HMixer);
  inherited;
end;

////////////////////////////////////////

function TnsMixerControl.GetControlValue: DWORD;
var mxcd:TMIXERCONTROLDETAILS; mxcd_u:TMIXERCONTROLDETAILS_UNSIGNED;
begin
  if (not m_bSuccess) then
  begin
    Result:=0;
    exit;
  end;

  m_bSuccess := FALSE;
  mxcd.cbStruct := sizeof(mxcd);
  mxcd.dwControlID := m_iMixerControlID;
  mxcd.cChannels := m_dwChannels;
  mxcd.cMultipleItems := 0;
  mxcd.cbDetails := sizeof(mxcd_u);
  mxcd.paDetails := @mxcd_u;
  mmr := mixerGetControlDetails(m_HMixer, @mxcd, 0);
  if (MMSYSERR_NOERROR <> mmr) then
  begin
    Result:=0;
    exit;
  end;
  m_bSuccess := TRUE;
  Result := mxcd_u.dwValue;
end;

function TnsMixerControl.SetControlValue(dw: DWORD): BOOL;
var
  mxcd:TMIXERCONTROLDETAILS;
  mxcd_u:TMIXERCONTROLDETAILS_UNSIGNED;
begin
  if (not m_bSuccess) then
  begin
    Result := m_bSuccess;
    exit;
  end;
  m_bSuccess := FALSE;
  mxcd.cbStruct := sizeof(mxcd);
  mxcd.dwControlID := m_iMixerControlID;
  mxcd.cChannels := m_dwChannels;
  mxcd.cMultipleItems := 0;
  mxcd.cbDetails := sizeof(mxcd_u);
  mxcd.paDetails := @mxcd_u;
  mmr := mixerGetControlDetails(m_HMixer, @mxcd, 0);
  if (MMSYSERR_NOERROR <> mmr) then
  begin
    Result := m_bSuccess;
    exit;
  end;
  mxcd_u.dwValue  := dw;
  mmr := mixerSetControlDetails(m_HMixer, @mxcd, 0);
  if (MMSYSERR_NOERROR <> mmr) then
  begin
    Result := m_bSuccess;
    exit;
  end;
  m_bSuccess := TRUE;
  Result := m_bSuccess;
end;

function TnsMixerControl.mixerOn:BOOL;
begin
  Result := SetControlValue(0);
end;

function TnsMixerControl.mixerOff:BOOL;
begin
  Result := SetControlValue(1);
end;

end.




