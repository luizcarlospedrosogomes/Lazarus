unit ContaNotasParaSaque;

{$mode objfpc}{$H+}

interface
  uses     Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

implementation
uses conexaoDB;
{
       limite de notas de 100 possivel : 100 ou R$ 10.000,00
       limite de notas de 50 possivel  : 60 ou  R$ 3.000,00
       limite de notas de 20 possivel  : 50  ou R$ 1.000,00
       limite de notas de 10 possivel  : 25  ou R$ 250, 00
       limite de notas de 5 possivel   : 2  ou R$ 100,00
       limite de notas de 2 possivel   : 25  ou 50,00

       valores acima de R$ 1.000,00 somente notas de R$ 100,00 e R$ 50,00.
       valores entre  R$ 100,00 e R$ 1.000,00 notas de R$ 50,00, R$ 20,00 e R$ 10,00.
       valores entre  R$ 2,00 e R$ 100,00 notas de 50,00, 20,00, R$ 10,00 e R$ 2,00.
}
end.
