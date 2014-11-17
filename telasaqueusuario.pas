unit telaSaqueUsuario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  maskedit, ExtCtrls;

type

  { TfrSaqueUsuario }

  TfrSaqueUsuario = class(TForm)
    btSaqueAvancar: TButton;
    btSaqueCancelar: TButton;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    lbErroNota: TLabel;
    lbSaque: TLabel;
    edSaqueValor: TMaskEdit;
    procedure btSaqueAvancarClick(Sender: TObject);
    procedure btSaqueCancelarClick(Sender: TObject);
    procedure edSaqueValorChange(Sender: TObject);
   // procedure FormCreate(Sender: TObject);
   // procedure frSaqueUsuario(Sender: TObject);
    procedure edSaqueValorKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frSaqueUsuario: TfrSaqueUsuario;
  saldo : String;

implementation
uses funcoes, FuncoesDeSaque, LimparForms, telaStatusOperacao, telaUsuarioUser;
{$R *.lfm}

{ TfrSaqueUsuario }
procedure TfrSaqueUsuario.edSaqueValorKeyPress(Sender: TObject; var Key: Char);

begin

if not (Key in['0'..'9',Chr(8)]) then Key:= #0;

end;

procedure TfrSaqueUsuario.FormKeyPress(Sender: TObject; var Key: char);
begin
  // x ou X
  if (Key = #88) OR (Key = #120) then
   btSaqueCancelarClick(self);
  //enter
  if Key = #13 then
   btSaqueAvancarClick(self);
end;

procedure TfrSaqueUsuario.FormShow(Sender: TObject);
begin
  edSaqueValor.SetFocus;
end;


procedure TfrSaqueUsuario.btSaqueAvancarClick(Sender: TObject);
begin
case validaSaque(edSaqueValor.Text) of
    1:begin
      lbErroNota.Caption:='Sua Conta Não possui valor suficiente';
      Application.ProcessMessages;
      Sleep(1000);
      lbErroNota.Caption:= '';
     end;
    3:begin
      lbErroNota.Caption:='Insira um Valor Valido';
      Application.ProcessMessages;
      Sleep(1000);
      lbErroNota.Caption:= '';
     end;
    4:begin
      lbErroNota.Caption:='Valor Invalido. Insira um Valor Divisel';
      Application.ProcessMessages;
      Sleep(1000);
      lbErroNota.Caption:= '';
     end;
    5:begin
       dividirNotas100(StrToInt(edSaqueValor.Text));
       tela := 1;
       exibirTela(tela);
       frStausOperacao.Show;
       frSaqueUsuario.Close;
      end;
end;

end;

procedure TfrSaqueUsuario.btSaqueCancelarClick(Sender: TObject);
begin
     edSaqueValor.Text :='';
     frSaqueUsuario.Close;
     FrUsuario.Show;
end;

procedure TfrSaqueUsuario.edSaqueValorChange(Sender: TObject);
begin

end;

end.

