unit JwHashWorker;

interface

uses
  JwsclTypes,
  JwsclCryptProvider,
  Classes,
  SysUtils;

type
  TJwHashWorker = class
  private
    class function Dump(Loc: Pointer; Len: Cardinal): TBytes;
    class function GetHashString(Algorithm: TJwHashAlgorithm; PData: Pointer;
      DataSize: Integer): string;
  public
    class function GetHash(Data: string; Algorithm: TJwHashAlgorithm; Encoding: TEncoding): string;
  end;

implementation

{ TJwHashWorker }

class function TJwHashWorker.Dump(Loc: Pointer; Len: Cardinal): TBytes;
var
  i: Integer;
begin
  Result := [];
  for i := 1 to Len do
  begin
    Result := Result + [PByte(Loc)^];
    Inc(PByte(Loc), 1);
  end;
end;

class function TJwHashWorker.GetHashString(Algorithm: TJwHashAlgorithm; PData: Pointer;
  DataSize: Integer): string;
var
  Hash: TJwHash;
  HashSize: Cardinal;
  PHashResult: Pointer;
  HashResultDump: TBytes;
  bt: Byte;
begin
  Result := string.Empty;
  Hash := TJwHash.Create(Algorithm);
  try
    Hash.HashData(PData, DataSize);
    PHashResult := Hash.RetrieveHash(HashSize);
    try
      HashResultDump := Dump(PHashResult, HashSize);
      for bt in HashResultDump do
        Result := Result + IntToHex(bt, 2);
    finally
      TJwHash.FreeBuffer(PHashResult);
    end;
  finally
    Hash.Free;
  end;
end;

class function TJwHashWorker.GetHash(Data: string; Algorithm: TJwHashAlgorithm;
  Encoding: TEncoding): string;
var
  DataBytes: TBytes;
begin
  DataBytes := TEncoding.Convert(TEncoding.Unicode, Encoding, TEncoding.Unicode.GetBytes(Data));
  Result := GetHashString(haMD5, Pointer(DataBytes), Length(DataBytes) * SizeOf(Byte));
end;

end.
