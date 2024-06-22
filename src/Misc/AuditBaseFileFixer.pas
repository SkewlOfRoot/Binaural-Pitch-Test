unit AuditBaseFileFixer;

interface
uses SysUtils, Classes, Dialogs, Windows;

  type
    TAuditBaseFileFixer = class

    private

    public
      function FixFile(fileName : string) : boolean;
    
    end;

implementation

{$Optimization Off}

function TAuditBaseFileFixer.FixFile(fileName: string) : boolean;
  var
    stream : TFileStream;
    filedata : array of byte;
    theFile : File of byte;
    i : integer;
    delCount : integer;
    value : byte;
begin
  if FileExists(fileName) then begin
    AssignFile(theFile,fileName);
    Reset(theFile);
    SetLength(filedata,FileSize(theFile));
    Close(theFile);

    stream := TFileStream.Create(fileName,fmOpenRead);
    try
      stream.Read(filedata[0],stream.Size);
      delCount := 0;
      for i := Length(filedata)-1 downto 0 do begin
        value := filedata[i];
        if not (value = 62) then begin  //62 is the deci value for the ascii char '>'(that should be the last char in the file).
          filedata[i] := 0;
          inc(delCount);
        end
        else
          Break;
      end;
    finally
      stream.Free;
    end;
    SetLength(filedata,Length(filedata)-delCount);

    DeleteFile(PChar(fileName));
    stream := TFileStream.Create(fileName,fmCreate);
    try
      for i := 0 to Length(filedata) - 1 do begin
        value := filedata[i];
        stream.Write(value,1);
      end;

    finally
      stream.Free;
    end;
      Result := true;
  end
  else
    Result := false;
end;
end.
