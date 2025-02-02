unit ReadWaveHeader;

interface
uses Classes, SysUtils;
  type
    TReadWaveHeader = class

    private
      chunkSizeDeci : integer;
      subChunk1SizeDeci : integer;
      audioFormatDeci : integer;
      numChannelsDeci : integer;
      sampleRateDeci : integer;
      byteRateDeci : integer;
      blockAlignDeci : integer;
      bitsPerSampleDeci : integer;
      filesizeDeci : integer;
      function HexArrayToDeci(values : array of byte) : integer;
      function GetChunkSize() : integer;
      function GetSubChunk1Size() : integer;
      function GetAudioFormat() : integer;
      function GetNumChannels() : integer;
      function GetSampleRate() : integer;
      function GetByteRate() : integer;
      function GetBlockAlign() : integer;
      function GetBitsPerSample() : integer;
      function GetFileSize() : integer;

    public
      procedure ReadHeader(filename : string);
      property ChunkSize : integer read GetChunkSize;
      property SubChunk1Size : integer read GetSubChunk1Size;
      property AudioFormat : integer read GetAudioFormat;
      property NumChannels : integer read GetNumChannels;
      property SampleRate : integer read GetSampleRate;
      property ByteRate : integer read GetByteRate;
      property BlockAlign : integer read GetBlockAlign;
      property BitsPerSample : integer read GetBitsPerSample;
      property FileSize : integer read GetFileSize;
    end;

implementation

  procedure TReadWaveHeader.ReadHeader(filename: string);
  var stream : TStream;

    chunkIdArr : array[0..3] of byte;
    chunkSizeArr : array[0..3] of byte;
    waveArr : array[0..3] of byte;
    fmtArr : array[0..3] of byte;
    subChunk1SizeArr : array[0..3] of byte;
    audioformatArr : array[0..1] of byte;
    numChannelsArr : array[0..1] of byte;
    sampleRateArr : array[0..3] of byte;
    byteRateArr : array[0..3] of byte;
    blockAlignArr : array[0..1] of byte;
    bitsPerSampleArr : array[0..1] of byte;
  begin
    Stream := TFileStream.Create(filename,fmOpenRead);
    try
      stream.Position := 0;
      stream.Read(chunkIdArr[0],SizeOf(chunkIdArr));
      stream.Read(chunkSizeArr[0],SizeOf(chunkSizeArr));
      stream.Read(waveArr[0],SizeOf(waveArr));
      stream.Read(fmtArr[0],SizeOf(fmtArr));
      stream.Read(subChunk1SizeArr[0],SizeOf(subChunk1SizeArr));
      stream.Read(audioformatArr[0],SizeOf(audioformatArr));
      stream.Read(numChannelsArr[0],SizeOf(numChannelsArr));
      stream.Read(sampleRateArr[0],SizeOf(sampleRateArr));
      stream.Read(byteRateArr[0],SizeOf(byteRateArr));
      stream.Read(blockAlignArr[0],SizeOf(blockAlignArr));
      stream.Read(bitsPerSampleArr[0],SizeOf(bitsPerSampleArr));

      fileSizeDeci := stream.Size;
    finally
      stream.Free;
    end;

      chunkSizeDeci := HexArrayToDeci(chunkSizeArr);
      subChunk1SizeDeci := HexArrayToDeci(subChunk1SizeArr);
      audioformatDeci := HexArrayToDeci(audioformatArr);
      numChannelsDeci := HexArrayToDeci(numChannelsArr);
      sampleRateDeci := HexArrayToDeci(sampleRateArr);
      byteRateDeci := HexArrayToDeci(byteRateArr);
      blockAlignDeci := HexArrayToDeci(blockAlignArr);
      bitsPerSampleDeci := HexArrayToDeci(bitsPerSampleArr);
  end;

  function TReadWaveHeader.HexArrayToDeci(values: array of Byte) : integer;
    var
      i: Integer;
      hex : string;
  begin
    for i := Length(values)-1 downto 0 do
        hex := hex + IntToHex(values[i],0);

        Result := StrToInt('$'+ hex);
  end;

  function TReadWaveHeader.GetChunkSize;
  begin
    Result := chunkSizeDeci;
  end;

  function TReadWaveHeader.GetSubChunk1Size;
  begin
    Result := subChunk1SizeDeci;
  end;

  function TReadWaveHeader.GetAudioFormat;
  begin
    Result := audioFormatDeci;
  end;

  function TReadWaveHeader.GetNumChannels;
  begin
    Result := numChannelsDeci;
  end;

  function TReadWaveHeader.GetSampleRate;
  begin
    Result := sampleRateDeci;
  end;

  //ByteRate = (BitsPerSample/8) * NumberOfChannels * SampleRate
  //Duration = FileSizeInBytes * ByteRate
  function TReadWaveHeader.GetByteRate;
  begin
    //Result := byteRateDeci;
    Result := Trunc(bitsPerSampleDeci/8)*numChannelsDeci*sampleRateDeci;
  end;

  function TReadWaveHeader.GetBlockAlign;
  begin
    Result := blockAlignDeci;
  end;

  function TReadWaveHeader.GetBitsPerSample;
  begin
    Result := bitsPerSampleDeci;
  end;

  function TReadWaveHeader.GetFileSize;
  begin
    Result := filesizeDeci;
  end;
end.
