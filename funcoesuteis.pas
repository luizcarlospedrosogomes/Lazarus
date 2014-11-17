unit funcoesUteis;
interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,conexaoDB,
  ExtCtrls;

implementation
function atualizaSaldo(saldo :Double):Double;
begin
   DB.SQLQuery1.SQL.Text:='SELECT SUM(valor) AS valor FROM nota WHERE idcaixa = 1';
   DB.SQLQuery1.Open;
   saldo :=  StrToFloat(DB.SQLQuery1['valor']);
   DB.SQLQuery1.Close;
end;

end.

