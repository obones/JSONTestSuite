program test_JSONDataObjects;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes,
  JSONDataObjects;

procedure ProcessFile(const AFileName: string);
var
  FileStream: TFileStream;
  Value: string;
  Content: TStringList;
  Instance: TJsonBaseObject;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    Content := TStringList.Create;
    try
      // get file content as string
      try
        Content.LoadFromStream(FileStream, TEncoding.UTF8);
        Value := Content.Text;

      // Parse
        Instance := TJsonObject.Parse(Value);

        if Assigned(Instance) then
          ExitCode := 0
        else
          ExitCode := 1;
      except
        on EEncodingError do
          ExitCode := 1;
        on EJsonParserException do
          ExitCode := 1;
      end;
    finally
      Content.Free;
    end;
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
