unit funcoes;

{$mode objfpc}{$H+}

interface
  uses     Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;
   //function getNotas100:Integer;
  function caixaStatus():Integer;
  function somaSaldo():Integer;
  function getNotas100():Integer;
  function getNotas50():Integer;
  function getNotas20():Integer;
  function getNotas10():Integer;
  function getNotas5():Integer;
  function getNotas2():integer;
  //function validaValor(valor : Integer): Integer;
  function updateNotas100(upNota100 :Integer):integer;
  function updateNotas50(upNota50 :Integer):integer;
  function updateNotas20(upNota20 : Integer):integer;
  function updateNotas10(upNota10 : Integer):integer;
  function updateNotas5(upNota5 : Integer):integer;
  function updateNotas2(upNota2 : Integer):integer;
  function statusSaque():integer;
  function falhaBanco():integer;
implementation
uses conexaoDB, telaInicial;
//var resultSaldo : Double;
function getNotas100:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 100.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    getNotas100:= StrToInt(DB.SQLQuery1['quantidade']);
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;

function getNotas50:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 50.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    getNotas50 := StrToInt(DB.SQLQuery1['quantidade']);
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;
function getNotas20:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 20.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    getNotas20 := StrToInt(DB.SQLQuery1['quantidade']);
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;
function getNotas10:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 10.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    getNotas10 := StrToInt(DB.SQLQuery1['quantidade']);
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;
function getNotas5:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 5.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    Result := DB.SQLQuery1['quantidade'];
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;
function getNotas2:integer;
begin
  try
    DB.SQLQuery1.SQL.Text:='SELECT quantidade FROM nota WHERE valor= 2.00 AND idcaixa = 1';
    DB.SQLQuery1.Open;
    Result := DB.SQLQuery1['quantidade'];
    DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;
end;
function somaSaldo:integer;
begin
    //DB.SQLQuery1.Close;
   somaSaldo:=  (getNotas2 *2) + (getNotas5 * 5) + (getNotas10 * 10) + (getNotas20 * 20) + (getNotas50 * 50) + (getNotas100 * 100);
 end;
{function validaValor(valor: Integer): Integer;
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
end;}

function caixaStatus:Integer;
begin
  try
  DB.SQLQuery1.SQL.Text:='SELECT status FROM caixa WHERE idcaixa =1';
  DB.SQLQuery1.Open;
  if DB.SQLQuery1['status'] = 1 then
     Result := 1
  else
     Result := 2;

  DB.SQLQuery1.Close;

  except
         On E:Exception do
         falhaBanco();
         end;

end;

function updateNotas2(upNota2 : Integer):integer;
begin
     try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota2)+''' WHERE idcaixa =1 AND idnota =6';
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
function updateNotas5(upNota5 : Integer):integer;
begin
   try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota5)+''' WHERE idcaixa =1 AND idnota =5';
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
function updateNotas10(upNota10 : Integer):integer;
begin
   try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota10)+''' WHERE idcaixa =1 AND idnota =4';
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
function updateNotas20(upNota20 : Integer):integer;
begin
   try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota20)+''' WHERE idcaixa =1 AND idnota =3';
     DB.SQLTransaction1.Active:=false;
     DB.SQLTransaction1.StartTransaction;
     DB.SQLQuery1.ExecSQL;
     DB.SQLTransaction1.Commit;
     DB.SQLQuery1.Close;

   finally
     // falhaBanco();
   end;
end;
function updateNotas50(upNota50 :Integer):integer;
begin
   try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota50)+''' WHERE idcaixa =1 AND idnota =2';
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
function updateNotas100(upNota100 :Integer):integer;
begin
   try
     DB.SQLQuery1.SQL.Text:='UPDATE nota SET quantidade='''+IntToStr(upNota100)+''' WHERE idcaixa =1 AND idnota =1';
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

function statusSaque():integer;
begin
  if(getNotas100 < 1) AND (getNotas50 < 1) AND (getNotas20 <1) AND (getNotas10 <1) AND (getNotas5 <1) AND (getNotas2 < 1) then
     statusSaque := 1;
end;

function falhaBanco():integer;
begin
  //ShowMessage('Erro aqui');

     Form1.Show;
     Form1.btDeposito.Hide;
     Form1.SaqueSem.Hide;
     Form1.lbError.Caption:='Ocorreu uma falha, por favor utilize outro terminal.';
     Form1.status.Visible:=True;
     Form1.status.Color:=clRed;
     Form1.status.Caption:='Caixa Inativo';
     Form1.lbNotasDisponiveis.Hide;
     Form1.lbNota100.Hide;
     Form1.lbNota50.Hide;
     Form1.lbNota20.Hide;
     Form1.lbNota10.Hide;
     Form1.lbNota5.Hide;
     Form1.lbNota2.Hide;
     Form1.lbInsiraCartao.Hide;


end;

end.

