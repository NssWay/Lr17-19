unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure TfMain.Button2Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure Udvoenie(st: string);
var
  r: real;
begin
    r:= StrToFloat(st);
    r:=r*2;
    ShowMessage(FloatToStr(r));
end;

procedure TfMain.Edit1Change(Sender: TObject);
begin

end;

procedure TfMain.Button1Click(Sender: TObject);
begin
    Udvoenie(Edit1.Text);
end;

procedure TfMain.Label1Click(Sender: TObject);
begin

end;
procedure TfMain.Button2Click(Sender: TObject);
begin
  ShowMessage(FuncUdvoenie(Edit1.Text));
end;
end.

