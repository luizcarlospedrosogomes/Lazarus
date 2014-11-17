unit FuncoesDeSaque;

{$mode objfpc}{$H+}

interface
  uses     Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, variants;
 function dividirNotas100(valor : Integer):Integer;
 function dividirNotas50(valor : Integer):Integer;
 function dividirNotas20(valor : Integer):Integer;
 function dividirNotas10(valor : Integer):Integer;
 function dividirNotas5(valor : Integer):Integer;
 function dividirNotas2(valor : Integer):Integer;
 function realizarSaque(nNota100, nNota50, nNota20, nNota10, nNota5, nNota2 : Integer):Integer;
 function validaSaque(valor :String):Integer;
 function descontaSaque(valor: Integer):Integer;
 function salvarSaque():Integer;
 function contaSaque: Integer;
 function validaValor(valor: Integer): Integer;

implementation
uses conexaoDB, funcoes, dadosUsuario;

 var
 saldoConta , nNota2, nNota5, nNota10, nNota20, nNota50, nNota100, resto : Integer;
 idCartao :String;
function dividirNotas100(valor: Integer): Integer;
begin
    nNota100:= valor Div 100;
     if (nNota100 > getNotas100()) OR (getNotas100() < 1) then
     begin
        nNota100 :=0;
        dividirNotas50(valor) //  ShowMessage(IntToStr(getNotas100()))
     end
     else
      begin
          resto:= valor mod 100;
          if resto = 0 then
            realizarSaque(nNota100,0,0,0,0,0)
          else
            dividirNotas50(resto);
       end;

end;

function dividirNotas50(valor: Integer): Integer;
begin
    nNota50 := valor Div 50;
    if (nNota50 > getNotas50()) OR (getNotas50() < 1) then
    begin
     nNota50 := 0;
     dividirNotas20(valor)
    end
    else
    begin
         resto:= valor mod 50;
          if resto = 0 then
             realizarSaque(nNota100,nNota50,0,0,0,0)
          else
              dividirNotas20(resto);
    end;
end;

function dividirNotas20(valor: Integer): Integer;
begin
    nNota20 := valor Div 20;
    if (nNota20 > getNotas20()) OR (getNotas20() < 1) then
      begin
           nNota20 := 0;
           dividirNotas10(valor)
      end
      else
    begin
         resto:= valor mod 20;
          if resto = 0 then
            realizarSaque(nNota100,nNota50,nNota20,0,0,0)
          else
            dividirNotas10(resto);
     end;
end;

function dividirNotas10(valor: Integer): Integer;
begin
    nNota10 := valor Div 10;
    if (nNota10 > getNotas10()) OR (getNotas10() < 1) then
      begin
       nNota10 := 0;
       dividirNotas5(valor)
      end
      else
    begin
         resto:= valor mod 10;
          if resto = 0 then
            realizarSaque(nNota100,nNota50,nNota20,nNota10,0,0)
          else
            dividirNotas5(resto);
    end;
end;

function dividirNotas5(valor: Integer): Integer;
begin
    nNota5 := valor Div 5;
    if (nNota5 > getNotas5()) OR (getNotas5() < 1) then
      begin
       nNota5 := 0;
       dividirNotas5(valor)
      end
      else
    begin
         resto:= valor mod 5;
          if resto = 0 then
            realizarSaque(nNota100,nNota50,nNota20,nNota10,nNota5,0)
          else
           dividirNotas2(resto);
    end;
end;
function dividirNotas2(valor: Integer): Integer;
begin
    nNota2 := valor Div 2;
    if (nNota2 > getNotas2()) OR (getNotas2() < 1) then
       ShowMessage('error')
    else
    begin
         resto:= valor mod 2;
          if resto = 0 then
            realizarSaque(nNota100,nNota50,nNota20,nNota10,nNota5,nNota2)
          else
             dividirNotas2 := nNota2;

    end;
end;

function realizarSaque(nNota100, nNota50, nNota20, nNota10, nNota5, nNota2: Integer): Integer;
begin
    //ShowMessage('100 = '+IntToStr(nNota100)+' 50 = '+IntToStr(nNota50)+' 20 = '+IntToStr(nNota20)+'10 = '+IntToStr(nNota10)+' 5 = '+IntToStr(nNota5)+' 2 = '+IntToStr(nNota2));
     updateNotas100(getNotas100() - nNota100);
     updateNotas50(getNotas50() - nNota50);
     updateNotas20(getNotas20() - nNota20);
     updateNotas10(getNotas10() - nNota10);
     updateNotas5(getNotas5() - nNota5);
     updateNotas2(getNotas2() - nNota2);
     descontaSaque(saldoConta -((nNota100 * 100) + (nNota50 * 50) + (nNota20 * 20) + (nNota10 * 10) + (nNota5 * 5) + (nNota2 * 2)));
     salvarSaque();
      nNota100 :=0;
      nNota50 :=0;
      nNota20 :=0;
      nNota10 :=0;
      nNota5 :=0;
      nNota2 :=0;
end;

function validaSaque(valor: String): Integer;
begin
    if valor = '' then
      Result := 3//valor vazio
    else
    if (StrToInt(valor) > 1) AND (validaValor(StrToInt(valor)) = 1) then
    begin
         try
         DB.SQLQuery1.SQL.Text:='SELECT saldo, conta.idcartao FROM conta JOIN cartao ON conta.idconta = cartao.idcartao WHERE cartao.numero = '''+nCartaoUsuario+'''';
         DB.SQLQuery1.Open;
         saldoConta :=StrToInt(DB.SQLQuery1['saldo']);
         idCartao:= DB.SQLQuery1['idcartao'];
         DB.SQLQuery1.Close;
         except
         On E:Exception do
         falhaBanco();
         end;
         if saldoConta < StrToInt(valor) then
            Result :=1//saldo Insuficiente Conta
         else
             Result := 5; //tudo ok
         end
    else
        Result := 4// Valor acima de 1 000 000 ou indivisivel
end;

function descontaSaque(valor:Integer):Integer;
begin
    try
    DB.SQLQuery1.SQL.Text:='UPDATE conta SET saldo = '''+IntToStr(valor)+''' WHERE idcartao ='''+idCartao+'''';
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

function salvarSaque: Integer;
var valorSalvar : Integer;
begin
   valorSalvar := (nNota100 * 100) + (nNota50 * 50) + (nNota20 * 20) + (nNota10 * 10) + (nNota5 * 5) + (nNota2 * 2);
   try
   DB.SQLQuery1.SQL.Text:='INSERT INTO saque (numerocartao, valor, datasaque, idcaixa, idcartao) VALUES ('''+nCartaoUsuario+''', '+IntToStr(valorSalvar)+', current_date, 1, '''+idcartaoUsuario+''')';
   DB.SQLTransaction1.Active:=false;
   DB.SQLTransaction1.StartTransaction;
   DB.SQLQuery1.ExecSQL;
   DB.SQLTransaction1.Commit;
   except
   On E:Exception do
   falhaBanco();
   end;

end;

function contaSaque: Integer;
begin
  try
  DB.SQLQuery1.SQL.Text:='SELECT COUNT(*) AS saques FROM saque WHERE idcaixa = 1';
  DB.SQLQuery1.Open;
  contaSaque :=StrToInt(DB.SQLQuery1['saques']);
  DB.SQLQuery1.Close;
  except
   On E:Exception do
   falhaBanco();
   end;

end;

function validaValor(valor: Integer): Integer;
var
    resto100, resto50, resto20, resto10, resto5, resto2 :double;
begin
    resto100 := valor mod 100;
    resto50 := valor mod 50;
    resto20 := valor mod 20;
    resto10 := valor mod 10;
    resto5 := valor mod 5;
    resto2 :=valor mod 2;
    if(resto100 = 0) OR (resto50 = 0) OR (resto20 = 0) OR (resto10 = 0) OR (resto5 = 0) OR (resto2 = 0)then
                validaValor := 1
    else
                validaValor := 0;
end;

end.
