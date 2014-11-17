unit telaTransferencia;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  maskedit, ExtCtrls;

type

  { TfrTransferencia }

  TfrTransferencia = class(TForm)
    btTransferenciaAvancar: TButton;
    Button2: TButton;
    Image2: TImage;
    //Image3: TImage;
    lbError: TLabel;
    lbTransferenciaValor: TLabel;
    lbTransferenciaAgencia: TLabel;
    lbTransferenciaConta: TLabel;
    lbTranferencia: TLabel;
    edTransferenciaValor: TMaskEdit;
    edTransferenciaAgencia: TMaskEdit;
    edTransferenciaConta: TMaskEdit;
    procedure btTransferenciaAvancarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edTransferenciaAgenciaKeyPress(Sender: TObject; var Key: char);
    procedure edTransferenciaContaKeyPress(Sender: TObject; var Key: char);
    procedure edTransferenciaValorKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    //procedure Image3Click(Sender: TObject);
    //procedure TfrSaqueUsuario.edSaqueValorKeyPress(Sender: TObject; var Key: Char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frTransferencia: TfrTransferencia;
//  valorTransferencia : String;
implementation
uses LimparForms,telaStatusOperacao, FuncoesDeTransferencia, telaStatusTransferencia, dadosUsuario, telaUsuarioUser;

{$R *.lfm}

{ TfrTransferencia }

procedure TfrTransferencia.btTransferenciaAvancarClick(Sender: TObject);
begin
   case validaTranferencia(edTransferenciaValor.Text, edTransferenciaAgencia.Text, edTransferenciaConta.Text) of
   0:begin
     lbError.Caption:='Todos os campos são obrigatorios';
     Application.ProcessMessages;
     Sleep(3000);
     lbError.Caption:='';
     end;
   1:begin
     tela:=2;
     exibirTela(tela);
     dadosContaDestino(edTransferenciaConta.Text);
     frStatusTransferencia.Show;
     frTransferencia.Close;
   end;
   2:begin
     lbError.Caption:='Verifique o Saldo da sua conta e conta destino';
     Application.ProcessMessages;
     Sleep(3000);
     lbError.Caption:='';

   end;

   end;


end;

procedure TfrTransferencia.Button2Click(Sender: TObject);
begin
  limparFormTransferencia();
  frTransferencia.Close;
  FrUsuario.Show;

end;

procedure TfrTransferencia.edTransferenciaAgenciaKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8)]) then
  begin
    Key:= #0;
     lbError.Caption:='Insira somente numeros para a Agencia';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';

  end
end;

procedure TfrTransferencia.edTransferenciaContaKeyPress(Sender: TObject;  var Key: char);
begin
  if not (Key in['0'..'9',Chr(8)]) then
  begin
    Key:= #0;
     lbError.Caption:='Insira somente numeros para a Conta';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';

  end
end;

procedure TfrTransferencia.edTransferenciaValorKeyPress(Sender: TObject; var Key: char);
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

procedure TfrTransferencia.FormKeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #88) OR (Key = #120) then
   Button2Click(self);

   if key =#13 then
   btTransferenciaAvancarClick(self);
end;

procedure TfrTransferencia.FormShow(Sender: TObject);
begin
  edTransferenciaValor.SetFocus;
end;





end.

