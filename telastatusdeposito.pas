unit telaStatusDeposito;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TfrStatusDeposito }

  TfrStatusDeposito = class(TForm)
    btDepositoCancelar: TButton;
    btDepositoConfirmar: TButton;
    btDepositoVoltar: TButton;
    dadosDeposito: TMemo;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    lbDeposito: TLabel;
    procedure btDepositoCancelarClick(Sender: TObject);
    procedure btDepositoConfirmarClick(Sender: TObject);
    procedure btDepositoVoltarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frStatusDeposito: TfrStatusDeposito;

implementation
 uses telaDeposito, dadosUsuario, FuncoesDeTransferencia, FuncoesDeDeposito, LimparForms, telaStatusOperacao, telaInicial, telaDepositoFinal;
{$R *.lfm}

{ TfrStatusDeposito }

procedure TfrStatusDeposito.FormShow(Sender: TObject);
begin
     dadosDeposito.Caption:='Confirme os dados de Deposito';
     dadosDeposito.Lines.Add('');

     dadosDeposito.Lines.Add('Dados Conta Destino');
     dadosDeposito.Lines.Add('Nome: '+nomeContaDestino+'                                                      CPF: '+cpfContaDestino);
     dadosDeposito.Lines.Add('Data Nascimento: '+dataNascContaDestino);
     dadosDeposito.Lines.Add('');

     dadosDeposito.Lines.Add('Conta Numero: '+numeroContaDestino+'                                            Valor: R$ '+frDeposito.edDepositoValor.Text+',00');

     dadosDeposito.Lines.Add('');
     dadosDeposito.Lines.Add('');
     dadosDeposito.Lines.Add('Em 24 Horas seu Deposito sera checado.');
end;

procedure TfrStatusDeposito.btDepositoConfirmarClick(Sender: TObject);
begin
  salvarDeposito(frDeposito.edDepositoValor.Text, frDeposito.edDepositoConta.Text);
   frStatusDeposito.Close;
  limparFormTransferencia();
  //tela:=3;
  //exibirTela(3);
  frDepositoFinal.Show;
  limparFormDeposito();
  limparDadosUsuario();
  dadosDeposito.Lines.Clear;
end;

procedure TfrStatusDeposito.btDepositoVoltarClick(Sender: TObject);
begin
  frStatusDeposito.Close;
  frDeposito.Show;
end;

procedure TfrStatusDeposito.FormKeyPress(Sender: TObject; var Key: char);
begin
  // x ou X
  if (Key = #88) OR (Key = #120) then
   btDepositoCancelarClick(self);

  // v ou V
   if (Key = #118) OR (Key = #86) then
   btDepositoVoltarClick(self);

   //C OU C
   if (Key = #67) OR (Key = #99) then
   btDepositoConfirmarClick(self);
end;

procedure TfrStatusDeposito.btDepositoCancelarClick(Sender: TObject);
begin
     dadosDeposito.Lines.Clear;
     limparDadosUsuario();
     frStatusDeposito.Close;
     limparFormDeposito();
     Form1.Show;
end;

end.

