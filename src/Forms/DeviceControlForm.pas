unit DeviceControlForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvHidControllerClass, StdCtrls;

type
  TDeviceControl = class(TForm)
    hidDeviceController: TJvHidDeviceController;
    listDevice: TListBox;
    grpDevices: TGroupBox;
    btnClose: TButton;
    Label1: TLabel;
    lblInput: TLabel;
    Label2: TLabel;
    procedure hidDeviceControllerDeviceChange(Sender: TObject);
    function hidDeviceControllerEnumerate(HidDev: TJvHidDevice;
      const Idx: Integer): Boolean;
    procedure hidDeviceControllerDeviceData(HidDev: TJvHidDevice;
      ReportID: Byte; const Data: Pointer; Size: Word);
    procedure btnCloseClick(Sender: TObject);
    procedure SetFormPosition(_top,_left : integer);
  private
    { Private declarations }
    hidOk : boolean;
  public
    { Public declarations }
  end;

var
  DeviceControl: TDeviceControl;

implementation

{$R *.dfm}
{$Optimization Off}

procedure TDeviceControl.btnCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TDeviceControl.hidDeviceControllerDeviceChange(Sender: TObject);
  var
    dev : TJvHidDevice;
    i : integer;
begin
  hidOk := false;
  for i := 0 to listDevice.Items.Count - 1 do begin
    dev := TJvHidDevice(listDevice.Items.Objects[i]);
    hidDeviceController.CheckIn(dev);
    listDevice.Items.Objects[i] := nil;
  end;
  Label1.Caption := 'No input!';
  listDevice.Clear;
  hidDeviceController.Enumerate;
end;

procedure TDeviceControl.hidDeviceControllerDeviceData(HidDev: TJvHidDevice;
  ReportID: Byte; const Data: Pointer; Size: Word);
  var
    str : string;
  i: Integer;
  dataInt : integer;
begin
  dataInt := 0;
  str := HidDev.ProductName+'  '+HidDev.VendorName;
  for i := 0 to Size - 1 do
    dataInt := dataInt or Cardinal(PChar(Data)[i]);

  if dataInt <> 0 then
    Label1.Caption := 'Input from '+HidDev.ProductName+'!'
  else
    Label1.Caption := 'No input!';

end;

function TDeviceControl.hidDeviceControllerEnumerate(HidDev: TJvHidDevice;
  const Idx: Integer): Boolean;
  var
    dev : TJvHidDevice;
    n : integer;
begin
  if HidDev.ProductName <> '' then
    n := listDevice.Items.Add(HidDev.ProductName)
  else
    n := listDevice.Items.Add(Format('Device VID=%x PID=%x',
      [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID]));

  hidDeviceController.CheckOutByIndex(dev,Idx);
  listDevice.Items.Objects[n] := dev;

  if HidDev.IsPluggedIn then begin
    hidOk := true;
    //Caption := HidDev.ProductName;
  end;

  Result := true;
end;

procedure TDeviceControl.SetFormPosition(_top: Integer; _left: Integer);
begin
  Top := _top;
  Left := _left;
end;
end.
