unit telaDeposito;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  maskedit, ExtCtrls;

type

  { TfrDeposito }

  TfrDeposito = class(TForm)
    btDepositoAvancar: TButton;
    btDepositoCancelar: TButton;
    edDepositoAgencia: TEdit;
    edDepositoConta: TEdit;
    Image3: TImage;
    Image4: TImage;
    lbError: TLabel;
    lbDeposito: TLabel;
    lbTransferenciaAgencia: TLabel;
    lbDepositoConta: TLabel;
    lbDepositoValor: TLabel;
    edDepositoValor: TMaskEdit;
    procedure btDepositoAvancarClick(Sender: TObject);
    procedure btDepositoCancelarClick(Sender: TObject);
    procedure btDepositoContaClick(Sender: TObject);
    procedure edDepositoAgenciaKeyPress(Sender: TObject; var Key: char);
    procedure edDepositoContaKeyPress(Sender: TObject; var Key: char);
    procedure edDepositoValorChange(Sender: TObject);
    procedure edDepositoValorKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frDeposito: TfrDeposito;

implementation
uses LimparForms, FuncoesDeDeposito, telaStatusDeposito, FuncoesDeTransferencia,telaInicial;
{$R *.lfm}

{ TfrDeposito }

procedure TfrDeposito.edDepositoValorKeyPress(Sender: TObject; var Key: char);
begin
 if not (Key in['0'..'9',Chr(8)]) then
  begin
    Key:= #0;
     lbError.Caption:='Insira somente numeros para o Valor';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';

  end;
end;

procedure TfrDeposito.FormKeyPress(Sender: TObject; var Key: char);
begin
     //x ou X
   if (Key = #88) OR (Key = #120) then
   btDepositoCancelarClick(self);
    //enter
   if key = #13 then
   btDepositoAvancarClick(self);

end;

procedure TfrDeposito.FormShow(Sender: TObject);
begin
  edDepositoValor.SetFocus;
end;

procedure TfrDeposito.edDepositoAgenciaKeyPress(Sender: TObject; var Key: char);
begin
     if not (Key in['0'..'9',Chr(8)]) then
  begin
    Key:= #0;
     lbError.Caption:='Insira somente numeros para a Agencia';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';

  end;
end;

procedure TfrDeposito.btDepositoAvancarClick(Sender: TObject);
begin

  case validaDeposito(edDepositoConta.Text, edDepositoValor.Text, edDepositoAgencia.Text) of
  1:begin
      dadosContaDestino(edDepositoConta.Text);
      frStatusDeposito.Show;
      frDeposito.Close;

    end;
  2:begin
     lbError.Caption:='Conta Não Existe';
     Application.ProcessMessages;
     Sleep(3000);
     lbError.Caption:='';
    end;
  3:begin
     lbError.Caption:='Todos Campos São Obrigatorios';
     Application.ProcessMessages;
     Sleep(3000);
     lbError.Caption:='';
    end;

  end;
end;

procedure TfrDeposito.btDepositoCancelarClick(Sender: TObject);
begin
  limparFormDeposito();
  frDeposito.Close;
  Form1.Show;
end;

procedure TfrDeposito.btDepositoContaClick(Sender: TObject);
begin
    if edDepositoValor.Text = '' then
    begin
    lbError.Caption:='Insira o Valor do Deposito ';
    Application.ProcessMessages;
    Sleep(300);
    lbError.Caption:='';
    edDepositoAgencia.Text :='';
    edDepositoConta.Text:='';
    end
    else
    begin
       frStatusDeposito.Show;
       frDeposito.Close;
    end;
end;

procedure TfrDeposito.edDepositoContaKeyPress(Sender: TObject; var Key: char);
begin
    if not (Key in['0'..'9',Chr(8)]) then
  begin
    Key:= #0;
     lbError.Caption:='Insira somente numeros para a Conta';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';

  end;
end;

procedure TfrDeposito.edDepositoValorChange(Sender: TObject);
begin

end;

end.

