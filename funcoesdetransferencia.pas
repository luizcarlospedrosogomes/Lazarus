unit FuncoesDeTransferencia;

{$mode objfpc}{$H+}

interface
  uses     Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, variants;

  var nomeContaDestino, dataNascContaDestino, cpfContaDestino, numeroContaDestino, saldoContaDestino :String;

  function validaTranferencia(valor,agencia,conta :String):integer;
  //function validaValor(valor : String):Integer;
  function validaConta(conta : String): Integer;
  function dadosContaDestino(conta:String):String;
  function descontaValorTransferencia(valor, contaUsuario:String):Integer;
  function somaValorTransferencia(valor, nContaDestino: String): Integer;
  function salvaTransferencia(contaUsuario, contaDestino, valor: String):Integer;
  function contaTransferencia: Integer;

implementation
uses conexaoDB, telaLogin, dadosUsuario, telaInicial, telaInseriNotas, FuncoesDeSaque, funcoes;

function validaTranferencia(valor, agencia, conta: String): integer;
begin
  if (valor ='') OR (agencia ='') OR (conta='') then
     Result:=0

  else
  begin
     if(validaSaque(valor) = 5) AND (validaConta(conta) = 1) then
        Result:=1
     else
        Result :=2;
  end;


end;
function validaConta(conta: String): Integer;
var checarConta: String;
begin
  try
  DB.SQLQuery1.SQL.Text:='SELECT idconta FROM conta WHERE idconta ='''+conta+'''';
  DB.SQLQuery1.Open;
  checarConta :=VarToStr(DB.SQLQuery1['idconta']);
  DB.SQLQuery1.Close;
  if checarConta = conta then
     validaConta:=1;

   except
   On E:Exception do
   falhaBanco();
   end;
end;
function dadosContaDestino(conta :String): String;
begin
  try
     DB.SQLQuery1.SQL.Text:='select nome, datanasc, cpf, idconta, saldo FROM cartao JOIN cliente ON cartao.idcliente =cliente.idcliente JOIN conta ON conta.idconta = cartao.idcartao  where idconta ='+conta+'';
     DB.SQLQuery1.Open;
     numeroContaDestino :=DB.SQLQuery1['idconta'];
     nomeContaDestino:= DB.SQLQuery1['nome'];
     dataNascContaDestino:= DB.SQLQuery1['datanasc'];
     cpfContaDestino:= DB.SQLQuery1['cpf'];
     saldoContaDestino:= DB.SQLQuery1['saldo'];
     DB.SQLQuery1.Close;

   except
   On E:Exception do
   falhaBanco();
   end;

end;
function descontaValorTransferencia(valor, contaUsuario: String): Integer;
var saldoUp :Integer;
begin
  saldoUp:= StrToInt(saldoUsuario) - StrToInt(valor);
    try
    DB.SQLQuery1.SQL.Text:='UPDATE conta SET saldo = '''+IntToStr(saldoUp)+''' WHERE idconta ='''+contaUsuario+'''';
    DB.SQLTransaction1.Active:=false;
    DB.SQLTransaction1.StartTransaction;
    DB.SQLQuery1.ExecSQL;
    DB.SQLTransaction1.Commit;
    DB.SQLQuery1.Close;

    except
   On E:Exception do
   falhaBanco();
   end;
end;
function somaValorTransferencia(valor, nContaDestino: String): Integer;
var saldoUp :Integer;
begin
  saldoUp:= StrToInt(saldoContaDestino) + StrToInt(valor);
  try
    DB.SQLQuery1.SQL.Text:='UPDATE conta SET saldo = '''+IntToStr(saldoUp)+''' WHERE idconta ='''+nContaDestino+'''';
    DB.SQLTransaction1.Active:=false;
    DB.SQLTransaction1.StartTransaction;
    DB.SQLQuery1.ExecSQL;
    DB.SQLTransaction1.Commit;
    DB.SQLQuery1.Close;

  except
   On E:Exception do
   falhaBanco();
   end;
end;

function salvaTransferencia(contaUsuario, contaDestino, valor: String):Integer;
begin
  try
   DB.SQLQuery1.SQL.Text:='INSERT INTO transferencia(idcontausuario, idcontadestino, valor, dataTrans, idCaixa) VALUES ('''+contaUsuario+''', '''+contaDestino+''', '''+valor+''', current_date, 1)';
   DB.SQLTransaction1.Active:=false;
   DB.SQLTransaction1.StartTransaction;
   DB.SQLQuery1.ExecSQL;
   DB.SQLTransaction1.Commit;

   except
   On E:Exception do
   falhaBanco();
   end;
end;

function contaTransferencia: Integer;
begin
  try
  DB.SQLQuery1.SQL.Text:='SELECT COUNT(*) AS trans FROM transferencia WHERE idcaixa = 1';
  DB.SQLQuery1.Open;
  contaTransferencia :=StrToInt(DB.SQLQuery1['trans']);
  DB.SQLQuery1.Close;

  except
   On E:Exception do
   falhaBanco();
   end;
end;

end.

