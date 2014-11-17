unit telaStatusOperacao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TfrStausOperacao }

  TfrStausOperacao = class(TForm)
    btNovaOperacao: TButton;
    btFinalizarOperacao: TButton;
    dadosExtrato: TMemo;
    Image3: TImage;
    Image4: TImage;
    lbStatusOperacao: TLabel;
    lbSaqueSucesso: TLabel;
    dadosSaldo: TMemo;
    procedure btFinalizarOperacaoClick(Sender: TObject);
    procedure btNovaOperacaoClick(Sender: TObject);
    procedure exibirSaque();
    procedure exibirTranferencia();
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
   // procedure xTela();
    procedure exibirDeposito();
    procedure exibirSaldo();
    procedure exibirExtrato();

    //procedure FormCreate(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frStausOperacao: TfrStausOperacao;
  cont :Integer;

implementation
uses telaSaqueUsuario, telaUsuarioUser, LimparForms, telaInicial, dadosUsuario, conexaoDB, funcoes;
{$R *.lfm}

{ TfrStausOperacao }

procedure TfrStausOperacao.btNovaOperacaoClick(Sender: TObject);
begin
   dadosSaldo.Lines.Clear;
   frSaqueUsuario.edSaqueValor.Text:='';
   frSaqueUsuario.Close;
   frStausOperacao.Close;
   FrUsuario.Show;

end;

procedure TfrStausOperacao.btFinalizarOperacaoClick(Sender: TObject);
begin
   limparFormDeposito();
   limparFormTransferencia();
  limparTelaLogin();
  limparDadosUsuario();
  dadosSaldo.Lines.Clear;
  frSaqueUsuario.edSaqueValor.Text:='';
  frSaqueUsuario.Close;
  frStausOperacao.Close;
  frSaqueUsuario.Close;
  Form1.Show;

end;
procedure TfrStausOperacao.exibirSaque();
begin
  dadosExtrato.Hide;
  dadosSaldo.Hide;
  lbStatusOperacao.Caption:='Saque';
  lbSaqueSucesso.Enabled:=True;
end;

procedure TfrStausOperacao.exibirTranferencia();
begin
  dadosSaldo.Hide;
  dadosExtrato.Hide;
  lbStatusOperacao.Caption:='Transferencia';
  lbSaqueSucesso.Enabled:=True;
  lbSaqueSucesso.Caption:='    Transferência realizada com sucesso.';
end;

procedure TfrStausOperacao.FormKeyPress(Sender: TObject; var Key: char);
begin
  // n ou N
   if (Key = #110) OR (Key = #78) then
   btNovaOperacaoClick(self);

   //enter
   if Key = #13 then
   btFinalizarOperacaoClick(self);
end;

procedure TfrStausOperacao.exibirDeposito();
begin

end;
procedure TfrStausOperacao.exibirSaldo();
begin
  contaUsuario(nCartaoUsuario);
  lbStatusOperacao.Caption:='Saldo';
  dadosSaldo.Show;
  dadosSaldo.Font.Size:=15;
  dadosSaldo.Caption:='CONTA';


  dadosSaldo.Lines.Add('DADOS CLIENTE');
  dadosSaldo.Lines.Add('NOME: '+nomeUsuario+'                                                      CPF: '+cpfUsuario);
  dadosSaldo.Lines.Add('DATA NASCIMENTO: '+dataNascUsuario);
  dadosSaldo.Lines.Add('');

   dadosSaldo.Lines.Add('CONTA NUMERO: '+ nConta+ '                                                  SALDO: R$ '+saldoUsuario+',00');
   dadosSaldo.Lines.Add('DATA CRIAÇÃO: '+dataCriacaoContaUsuario+ '');
   dadosSaldo.Lines.Add('N CARTAO: '+nCartaoUsuario+ '');
   //dadosSaldo.Lines.Add('------------------------------------------------------------------------------------------------------------');
end;

procedure TfrStausOperacao.exibirExtrato();
begin
  contaUsuario(nCartaoUsuario);
  lbStatusOperacao.Caption:='Extrato';
  dadosExtrato.Show;
  dadosExtrato.Font.Size:=15;
  dadosExtrato.Caption:='CONTA';
  dadosExtrato.Lines.Add('DADOS CLIENTE');
  dadosExtrato.Lines.Add('NOME: '+nomeUsuario+'                                                      CPF: '+cpfUsuario);
  dadosExtrato.Lines.Add('DATA NASCIMENTO: '+dataNascUsuario);
  dadosExtrato.Lines.Add('');

   dadosExtrato.Lines.Add('CONTA NUMERO: '+ nConta+ '                                                  SALDO: R$ '+saldoUsuario+',00');
   dadosExtrato.Lines.Add('DATA CRIAÇÃO: '+dataCriacaoContaUsuario+ '');
   dadosExtrato.Lines.Add('N CARTAO: '+nCartaoUsuario+ '');

   //saques
   try
   DB.SQLQuery1.SQL.Text :='select * from saques('''+idcartaoUsuario+''')';
   DB.SQLQuery1.Open;
   cont:= 1;
   dadosExtrato.Lines.Add('');
   dadosExtrato.Lines.Add('Ultimos Saques  ');
   dadosExtrato.Lines.Add('                                    Data                                        |                                    Valor R$ ');
   while not DB.SQLQuery1.EOF do
   begin

   dadosExtrato.Lines.Add(''+IntToStr(cont)+'                                '+ DB.SQLQuery1.Fields[0].Text+'                           |                  R$:  '+DB.SQLQuery1.Fields[2].Text+',00');
   cont := cont +1;
   DB.SQLQuery1.Next;
   end;
   DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;

   dadosExtrato.Lines.Add('');

   //fim saques

  //transferenciaas
  try
   DB.SQLQuery1.SQL.Text:='select *  from transferencia_enviadas('''+nConta+''')';
   DB.SQLQuery1.Open;
   cont :=1;

   dadosExtrato.Lines.Add('Ultimas Transferencias Recebidas  ');
   dadosExtrato.Lines.Add('         Data                         |        Titular                     |                            Valor R$ ');
   while not DB.SQLQuery1.EOF do
   begin

   dadosExtrato.Lines.Add(''+IntToStr(cont)+'     '+ DB.SQLQuery1.Fields[0].Text+'             |         '+DB.SQLQuery1.Fields[1].Text+'                          |                  R$:  '+DB.SQLQuery1.Fields[2].Text+',00');
   cont := cont +1;
   DB.SQLQuery1.Next;
   end;
   DB.SQLQuery1.Close;

   except
         On E:Exception do
         falhaBanco();
         end;
   //fim transferencias recebidas

   try
   DB.SQLQuery1.SQL.Text:='select *  from transferencia_recebidas('''+nConta+''')';
   DB.SQLQuery1.Open;
   cont :=1;
   dadosExtrato.Lines.Add('');
   dadosExtrato.Lines.Add('Ultimas Transferencias Enviadas  ');
  //laço
   dadosExtrato.Lines.Add('   Data     |        Titular            |                            Valor R$ ');
   while not DB.SQLQuery1.EOF do
   begin

   dadosExtrato.Lines.Add(''+IntToStr(cont)+'     '+ DB.SQLQuery1.Fields[0].Text+'             |         '+DB.SQLQuery1.Fields[1].Text+'                          |                  R$:  '+DB.SQLQuery1.Fields[2].Text+',00');
   cont := cont +1;
   DB.SQLQuery1.Next;
   end;
   DB.SQLQuery1.Close;
   //fim transferencias
   except
         On E:Exception do
         falhaBanco();
         end;

   dadosExtrato.Lines.Add('');
   dadosExtrato.Lines.Add('Depositos Aprovados');
try
   DB.SQLQuery1.SQL.Text:='select * from deposito('''+nConta+''',2)';
   DB.SQLQuery1.Open;
   cont :=1;
   //
   dadosExtrato.Lines.Add('   Data                     |        Titular            |                            Valor R$ ');
   while not DB.SQLQuery1.EOF do
   begin

   dadosExtrato.Lines.Add(''+IntToStr(cont)+'     '+ DB.SQLQuery1.Fields[0].Text+'                          |         '+DB.SQLQuery1.Fields[1].Text+'                          |                  R$:  '+DB.SQLQuery1.Fields[2].Text+',00');
   cont := cont +1;
   DB.SQLQuery1.Next;
   end;
   DB.SQLQuery1.Close;

except
         On E:Exception do
         falhaBanco();
         end;
end;

procedure TfrStausOperacao.FormShow(Sender: TObject);
begin
 case exibirTela(tela) of
  1:exibirSaque();
  2:exibirTranferencia();
  //3:exibirDeposito();
  4:exibirSaldo();
  5:exibirExtrato();
  end;
end;



end.

