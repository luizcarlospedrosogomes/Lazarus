unit carregamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls;

type

  { Tcarregar }

  Tcarregar = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  carregar: Tcarregar;

implementation

{$R *.lfm}
uses telaInicial;
{ Tcarregar }

procedure Tcarregar.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Position:=10;
  Sleep(100);

  ProgressBar1.Position:=50;
  Sleep(500);

  ProgressBar1.Position:=100;
  Sleep(1000);
  carregar.Destroy;
  Form1.Show;
end;

end.

