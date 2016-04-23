(*
  This demonstration computes and dumps the md5 hash of a given string.
*)
program SimpleMD5;

{$APPTYPE CONSOLE}

uses
  JwsclTypes,
  SysUtils,
  Winapi.Windows,
  JwHashWorker in 'JwHashWorker.pas';

var
  Data: string;

const
  s1 = '▼ ▲ § ¶ ► ◄';
  s2 = 'Ъ ъ Ё ё';

begin
  try
    SetConsoleOutputCP(CP_UTF8);
    Writeln('Windows console input in UTF8 is completely broken, so we will hash hardcoded strings');
    Writeln('Hash "' + s1 + '" = ' + TJwHashWorker.GetHash(s1, haMD5, TEncoding.UTF8));
    Writeln('Hash "' + s2 + '" = ' + TJwHashWorker.GetHash(s2, haMD5, TEncoding.UTF8));
    Readln;
  except
    on E: Exception do
    begin
      Writeln(E.Classname, ':', E.Message);
      Readln;
    end;
  end;

end.
