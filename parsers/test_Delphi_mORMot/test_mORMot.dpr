program test_mORMot;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes, System.Variants,
  SynCommons;

procedure ProcessFile(const AFileName: string);
var
  FileStream: TFileStream;
  FileSize: Int64;
  Value: RawUTF8;
  Instance: variant;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    FileSize := FileStream.Size;
    SetLength(Value, FileSize);
    FileStream.Read(Value[1], FileSize);

    // Parse
    Instance := _Json(Value);

    if VarIsNull(Instance) or VarIsEmpty(Instance) then
      ExitCode := 1
    else
      ExitCode := 0;
  finally
    FileStream.Free;
  end;
end;

begin
  if ParamCount <> 1 then
  begin
    WriteLn('Usage: ' + ParamStr(0) + ' file.json');
    ExitCode := 1;
    Exit;
  end;

  try
    ProcessFile(ParamStr(1));
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := 2;
    end;
  end;
end.
