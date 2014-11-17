unit telaInseriNotas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls;

type

  { TfrInserirNotas }

  TfrInserirNotas = class(TForm)
    Button1: TButton;
    btCancelarNotas: TButton;
    edAddNota100: TEdit;
    edAddNota50: TEdit;
    edAddNotas20: TEdit;
    edAddNotas10: TEdit;
    edAddNotas5: TEdit;
    edAddNotas2: TEdit;
    edNotas20: TEdit;
    edNotas100: TEdit;
    edNotas50: TEdit;
    edNotas10: TEdit;
    edNotas5: TEdit;
    edNotas2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbError: TLabel;
    lbInserisNotas: TLabel;
    lbNotasExistentes: TLabel;
    lbNotas50: TLabel;
    lbNotas20: TLabel;
    lbNotas10: TLabel;
    lbNotas5: TLabel;
    Label6: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;


    procedure btCancelarNotasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
   // procedure edAddNota100Change(Sender: TObject);
    procedure edAddNota100KeyPress(Sender: TObject; var Key: char);
    procedure edAddNota50KeyPress(Sender: TObject; var Key: char);
    procedure edAddNotas10KeyPress(Sender: TObject; var Key: char);
    procedure edAddNotas20KeyPress(Sender: TObject; var Key: char);
    procedure edAddNotas2KeyPress(Sender: TObject; var Key: char);
    procedure edAddNotas5KeyPress(Sender: TObject; var Key: char);
    //procedure edAddNota100Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);

  private
    { private declarations }
  public

  end;

var
  frInserirNotas: TfrInserirNotas;
  upNota100, upNota50, upNota20,upNota10, upNota5, upNota2 : Integer;

implementation
{$R *.lfm}
{ TfrInserirNotas }
uses conexaoDB, telaAdmin, funcoes, LimparForms;


procedure TfrInserirNotas.FormCreate(Sender: TObject);
begin


//     if(IntToStr(getNotas2()))

end;

procedure TfrInserirNotas.FormKeyPress(Sender: TObject; var Key: char);
begin
   // x ou X
  if (Key = #88) OR (Key = #120) then
   btCancelarNotasClick(self);

  //C OU C
   if (Key = #67) OR (Key = #99) then
   Button1Click(self);
end;

procedure TfrInserirNotas.FormShow(Sender: TObject);
begin
     edNotas100.Text:= IntToStr(getNotas100());
     edNotas50.Text:= IntToStr(getNotas50());
     edNotas20.Text:= IntToStr(getNotas20());
     edNotas10.Text:= IntToStr(getNotas10());
     edNotas5.Text:=  IntToStr(getNotas5());
     edNotas2.Text:=  IntToStr(getNotas2());
end;

procedure TfrInserirNotas.Image2Click(Sender: TObject);
begin

end;

procedure TfrInserirNotas.Button1Click(Sender: TObject);
begin

 if(Length(edAddNota100.Text) < 3) AND (Length(edAddNota50.Text) < 3) AND (Length(edAddNotas20.Text) < 3) AND (Length(edAddNotas10.Text) < 3) AND (Length(edAddNotas5.Text) < 3) AND (Length(edAddNotas2.Text) < 3) then
  begin
      if MessageDlg('Confirme a acao', mtConfirmation, mbOKCancel, 0) = mrOK then
       begin
           upNota100 := getNotas100()+ StrToInt(edAddNota100.Text);
           upNota50 :=  getNotas50() + StrToInt(edAddNota50.Text);
           upNota20 :=  getNotas20() + StrToInt(edAddNotas20.Text);
           upNota10 :=  getNotas10() + StrToInt(edAddNotas10.Text);
           upNota5 :=  getNotas5()  + StrToInt(edAddNotas5.Text);
           upNota2  :=  getNotas2()  + StrToInt(edAddNotas2.Text);
           if upNota100 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas100(upNota100);
              somaSaldo();
              edNotas100.Text:= IntToStr(getNotas100());
           end;
           if upNota50 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas50(upNota50);
              somaSaldo();
              edNotas50.Text:= IntToStr(getNotas50());
           end;
           if upNota20 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas20(upNota20);
              somaSaldo();
              edNotas20.Text:= IntToStr(getNotas20());
           end;
           if upNota10 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas10(upNota10);
              somaSaldo();
              edNotas10.Text:= IntToStr(getNotas10());
           end;
           if upNota5 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas5(upNota5);
              somaSaldo();
              edNotas5.Text:=  IntToStr(getNotas5());
           end;
            if upNota2 < 0 then
             ShowMessage('Numeros de Notas nao pode ser negativo')
           else
           begin
              updateNotas2(upNota2);
              somaSaldo();
              edNotas2.Text:=  IntToStr(getNotas2());
           end;
            limparTelaInsirirNotas();
             frAdmin.edSaldoCaixa.Text:= 'R$ '+FloatToStr(somaSaldo())+',00';
           end;
        end// if acao
           else
             begin
             lbError.Caption:='Nao podem ser inseridas mais de 999 notas';
             Application.ProcessMessages;
             Sleep(300);
             lbError.Caption:='';
             limparTelaInsirirNotas();
             end; // if numero de notas



      limparTelaInsirirNotas();
end;


procedure TfrInserirNotas.edAddNota100KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;
end;

procedure TfrInserirNotas.edAddNota50KeyPress(Sender: TObject; var Key: char);
begin
    if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;

end;

procedure TfrInserirNotas.edAddNotas10KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;

end;

procedure TfrInserirNotas.edAddNotas20KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;

end;

procedure TfrInserirNotas.edAddNotas2KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;

end;

procedure TfrInserirNotas.edAddNotas5KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in['0'..'9',Chr(8), Chr(45)]) then
  begin
    Key:= #0;
     lbError.Caption:='Campo Numerico';
     Application.ProcessMessages;
     Sleep(300);
     lbError.Caption:='';
  end;

end;


procedure TfrInserirNotas.btCancelarNotasClick(Sender: TObject);
begin
     limparTelaInsirirNotas();
     frInserirNotas.Close;
     frAdmin.edSaldoCaixa.Text:= 'R$ '+FloatToStr(somaSaldo())+',00';
     //CloseAction:= frInserirNotas;
end;

end.

