unit telaAdmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, telaInseriNotas;

type

  { TfrAdmin }

  TfrAdmin = class(TForm)
    btStatus: TButton;
    btInseriNotas: TButton;
    btSairAdmin: TButton;
    edSaquesCaixa: TEdit;
    edSaldoCaixa: TEdit;
    edTransferenciaCaixa: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    lbSaquesCaixa: TLabel;
    lbTransferenciaCaixa: TLabel;
    lcSaldoCaixa: TLabel;
    procedure btInseriNotasClick(Sender: TObject);
    procedure btSairAdminClick(Sender: TObject);
    procedure btStatusClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure nSaques();
    procedure edSaldoCaixaChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frAdmin: TfrAdmin;
  resultSaldo :Double;

implementation
{$R *.lfm}
uses conexaoDB, funcoes, telaInicial, LimparForms, telaLogin, FuncoesDeSaque, FuncoesDeTransferencia;

procedure TfrAdmin.edSaldoCaixaChange(Sender: TObject);
begin

end;
procedure TfrAdmin.btStatusClick(Sender: TObject);
begin

  case caixaStatus of
  2: begin
     DB.SQLQuery1.SQL.Text:='UPDATE caixa SET status=1 WHERE idcaixa =1';
     DB.SQLTransaction1.Active:=false;
     DB.SQLTransaction1.StartTransaction;
     DB.SQLQuery1.ExecSQL;
     DB.SQLTransaction1.Commit;
     //if somaSaldo <300 then
     //    ShowMessage('Saldo baixo ou inexistente');
     //ShowMessage('Caixa Ativo');
     btStatus.Font.Size:=30;
     btStatus.Caption:='Desativar Caixa';
     form1.atualizaStatus();
  end;
 1: begin
    DB.SQLQuery1.SQL.Text:='UPDATE caixa SET status=0 WHERE idcaixa =1';
    DB.SQLTransaction1.Active:=false;
    DB.SQLTransaction1.StartTransaction;
    DB.SQLQuery1.ExecSQL;
    DB.SQLTransaction1.Commit;
    //ShowMessage('Caixa Desativado');
    btStatus.Caption:='Ativar Caixa';
    form1.atualizaStatus();
  end;

  end;

end;

procedure TfrAdmin.FormKeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #088) OR (Key = #120) then
   btSairAdminClick(self);

   if (Key = #065) OR (Key = #097) then
   btStatusClick(self);

   if (Key = #078) OR (Key = #110) then
   btInseriNotasClick(self);
end;

procedure TfrAdmin.FormShow(Sender: TObject);
begin
 frAdmin.edSaquesCaixa.Text:=IntToStr(contaSaque);
 edTransferenciaCaixa.Text:=IntToStr(contaTransferencia);
 edSaldoCaixa.Text:= 'R$ '+FloatToStr(somaSaldo())+',00';

     if caixaStatus = 2 then
         btStatus.Caption:='Ativar Caixa'
     else
         begin
         btStatus.Font.Size:=30;
         btStatus.Caption:='Desativar Caixa';
         end;

end;

    procedure TfrAdmin.btInseriNotasClick(Sender: TObject);
begin

  frInserirNotas.Show;
end;

procedure TfrAdmin.btSairAdminClick(Sender: TObject);
begin
      limparTelaLogin();
      limparDadosUsuario();
      frAdmin.SetVisible(False);
      frAdmin.Close;
      Form2.Close;
      Form1.Show;
end;

procedure TfrAdmin.nSaques();
begin

end;

end.

