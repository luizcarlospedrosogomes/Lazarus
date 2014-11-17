unit telaUsuarioUser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFrUsuario }

  TFrUsuario = class(TForm)
    btUsuarioTransferencia: TButton;
    btUsuarioSaque: TButton;
    btExtratoUsuario: TButton;
    btSaldo: TButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure btExtratoUsuarioClick(Sender: TObject);
    procedure btSaldoClick(Sender: TObject);
    procedure btUsuarioDepositoClick(Sender: TObject);
    procedure btUsuarioSaqueClick(Sender: TObject);
    procedure btUsuarioTransferenciaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
   // procedure Image2Click(Sender: TObject);
    procedure stSaque();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrUsuario: TFrUsuario;

implementation

{$R *.lfm}
uses telaSaqueUsuario, funcoes, telaTransferencia, telaDeposito, telaStatusOperacao, LimparForms;
{ TFrUsuario }

procedure TFrUsuario.FormCreate(Sender: TObject);
begin

end;

procedure TFrUsuario.FormKeyPress(Sender: TObject; var Key: char);
begin
   if (Key = #65) OR (Key = #97) then
   btUsuarioTransferenciaClick(self);

   if (Key = #100) OR (Key = #68) then
   btUsuarioSaqueClick(self);

   if (Key = #83) OR (Key = #115) then
   btSaldoClick(self);

   if (Key = #102) OR (Key = #70) then
   btExtratoUsuarioClick(self);
end;

procedure TFrUsuario.FormShow(Sender: TObject);
begin
    stSaque();
end;


procedure TFrUsuario.btUsuarioSaqueClick(Sender: TObject);
begin
     frSaqueUsuario.Show;
     FrUsuario.Close;
end;

procedure TFrUsuario.btUsuarioTransferenciaClick(Sender: TObject);
begin
       frTransferencia.Show;
       FrUsuario.Close;
end;

procedure TFrUsuario.btUsuarioDepositoClick(Sender: TObject);
begin
     frDeposito.Show;
     FrUsuario.Close;
end;

procedure TFrUsuario.btSaldoClick(Sender: TObject);
begin
  tela:=4;
  exibirTela(4);
  frStausOperacao.Show;
  FrUsuario.Close;
end;

procedure TFrUsuario.btExtratoUsuarioClick(Sender: TObject);
begin
   tela:=5;
  exibirTela(5);
  frStausOperacao.Show;
  FrUsuario.Close;
end;



procedure TFrUsuario.stSaque();
begin
     if statusSaque = 1 then
      btUsuarioSaque.Hide;
end;

end.

