program atm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, telaInicial, conexaoDB, carregamento, telaLogin, telaAdmin,
  telaInseriNotas, funcoesUteis, telaTransferencia, telaSaqueUsuario,
  telaUsuarioUser, funcoes, telaSaqueNotas, ContaNotasParaSaque, dadosUsuario,
  FuncoesDeSaque, LimparForms, telaStatusOperacao, FuncoesDeTransferencia,
  telaStatusTransferencia, telaDeposito, telaStatusDeposito, FuncoesDeDeposito,
  telaDepositoFinal;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(Tcarregar, carregar);
  Application.CreateForm(TDB, DB);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrAdmin, frAdmin);
  Application.CreateForm(TfrInserirNotas, frInserirNotas);
  //Application.CreateForm(TfrCliente, frCliente);
  //Application.CreateForm(TfrSaque, frSaque);
  Application.CreateForm(TfrTransferencia, frTransferencia);
  Application.CreateForm(TfrSaqueUsuario, frSaqueUsuario);
  Application.CreateForm(TFrUsuario, FrUsuario);
  Application.CreateForm(TfrSaqueNotas, frSaqueNotas);
  Application.CreateForm(TfrStausOperacao, frStausOperacao);
  Application.CreateForm(TfrStatusTransferencia, frStatusTransferencia);
  Application.CreateForm(TfrDeposito, frDeposito);
  Application.CreateForm(TfrStatusDeposito, frStatusDeposito);
  Application.CreateForm(TfrDepositoFinal, frDepositoFinal);
  Application.Run;
end.

