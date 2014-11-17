unit telaDepositoFinal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TfrDepositoFinal }

  TfrDepositoFinal = class(TForm)
    btFinalizarOperacao: TButton;
    Image3: TImage;
    lbDepositoSucesso: TLabel;
    lbDeposito: TLabel;
    procedure btFinalizarOperacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frDepositoFinal: TfrDepositoFinal;

implementation
 uses LimparForms, telaInicial;
{$R *.lfm}

{ TfrDepositoFinal }

procedure TfrDepositoFinal.FormCreate(Sender: TObject);
begin
end;

procedure TfrDepositoFinal.btFinalizarOperacaoClick(Sender: TObject);
begin
  frDepositoFinal.Close;
  Form1.Show;
end;

procedure TfrDepositoFinal.FormKeyPress(Sender: TObject; var Key: char);
begin

   //enter
   if Key = #13 then
   btFinalizarOperacaoClick(self);
end;

end.

