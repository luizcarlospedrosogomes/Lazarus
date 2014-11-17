unit telaLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  maskedit,  LCLType, ExtCtrls, windows;

type

  { TForm2 }

  TForm2 = class(TForm)
    btAvancar: TButton;
    btCancelar: TButton;
    edInserirSenha: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    lbErroSenha: TLabel;
    lbErroNCartao: TLabel;
    lbNumeroCartao: TLabel;
    lbInsereSenha: TLabel;
    edInsirirNCartao: TMaskEdit;
    Timer1: TTimer;
    procedure btAvancarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure edInsirirNCartaoChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}
uses conexaoDB, telaAdmin, telaUsuarioUser, dadosUsuario, LimparForms, telaInicial;
{ TForm2 }

procedure TForm2.Button14Click(Sender: TObject);
begin
   //valor1 :=  StrToFloat(edInsirirNCartao.Text + '0');
  edInsirirNCartao.Text := edInsirirNCartao.Text + '0';
end;

procedure TForm2.edInsirirNCartaoChange(Sender: TObject);
begin
 // edInsirirNCartao.Field.EditMask:= '000-000-000-00;1;_';
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin

end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;



procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin

   if Key = #13 then
   btAvancarClick(self);
   if (Key = #88) OR (Key = #120) then
   btCancelarClick(self);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
      limparTelaLogin();
      edInsirirNCartao.SetFocus;
end;


procedure TForm2.btAvancarClick(Sender: TObject);
begin
   case validaUsuario(edInsirirNCartao.Text,edInserirSenha.Text) of
   0 : begin
       Form2.lbErroNCartao.Caption:='Cartao Inativo. Entre em contato com a gerencia';
       Application.ProcessMessages;
       Sleep(5000);
       Form2.lbErroNCartao.Caption:='';
       end;
    1 :begin
        frAdmin.Show;
        Form2.Close;
        Form1.Close;
       end;
    2 : begin
       Form2.lbErroNCartao.Caption:='Numero ou Senha Incorretos.';
       Application.ProcessMessages;
       Sleep(1000);
       Form2.lbErroNCartao.Caption:='';
       end;
    3 : begin
       Form2.lbErroNCartao.Caption:='Insira o numero do seu cartao e sua senha.';
       Application.ProcessMessages;
       Sleep(1000);
       Form2.lbErroNCartao.Caption:='';
       end;
    4 :begin
       FrUsuario.Show;
       Form2.Close;
       Form1.Close;
       end;
    5:begin
       Form2.lbErroNCartao.Caption:='Caixa Inativo. Utilize outro terminal.';
       Application.ProcessMessages;
       Sleep(1000);
       Form2.lbErroNCartao.Caption:='';
       limparTelaLogin();
       limparDadosUsuario();
       Form2.Close;
       Form1.Show;
      end;

  end;

 end;

procedure TForm2.btCancelarClick(Sender: TObject);
begin
     limparTelaLogin();
     Form2.Close;
     Form1.Show;
end;

end.

