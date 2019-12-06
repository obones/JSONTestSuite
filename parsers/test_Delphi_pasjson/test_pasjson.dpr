program test_pasjson;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes,
  pasjson;

procedure ProcessFile(const AFileName: string);
var
  FileStream: TFileStream;
  Value: string;
  Content: TStringList;
  Instance: TPasJSONItem;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
//    Content := TStringList.Create;
//    try
      // get file content as string
      try
//        Content.LoadFromStream(FileStream, TEncoding.UTF8);
//        Value := Content.Text;

        // Parse
        Instance := TPasJSON.Parse(FileStream, [TPasJSONModeFlag.Comments], TPasJSONEncoding.UTF8);

        if Assigned(Instance) then
          ExitCode := 0
        else
          ExitCode := 1;
      except
//        on EEncodingError do
//          ExitCode := 1;
//        on EChimeraException do
//          ExitCode := 1;
//        on EParserError do
//          ExitCode := 1;
      end;
//    finally
//      Content.Free;
//    end;
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
