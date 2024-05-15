unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math, fpexprpars;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonKop: TButton;
    ButtonDelenie: TButton;
    ButtonKvadrat: TButton;
    ButtonYmnozhenie: TButton;
    ButtonMinus: TButton;
    Button9: TButton;
    ButtonC: TButton;
    ButtonDelenieNaX: TButton;
    ButtonRavno: TButton;
    ButtonZapytay: TButton;
    Button3: TButton;
    Button5: TButton;
    Button1: TButton;
    Button2: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button4: TButton;
    ButtonCE: TButton;
    ButtonStrelka: TButton;
    Button0: TButton;
    ButtonPlys: TButton;
    Edit1: TEdit;
    procedure Button0Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure ButtonDelenieClick(Sender: TObject);
    procedure ButtonDelenieNaXClick(Sender: TObject);
    procedure ButtonKopClick(Sender: TObject);
    procedure ButtonKvadratClick(Sender: TObject);
    procedure ButtonMinusClick(Sender: TObject);
    procedure ButtonPlysClick(Sender: TObject);
    procedure ButtonRavnoClick(Sender: TObject);
    procedure ButtonStrelkaClick(Sender: TObject);
    procedure ButtonYmnozhenieClick(Sender: TObject);
    procedure ButtonZapytayClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    function HasCommaInLastNumber: Boolean;
    function Evaluate(Expression: String): Double;
  private
    LastInputIsOperation: Boolean;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function TForm1.HasCommaInLastNumber: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Length(Edit1.Text) downto 1 do
  begin
    if Edit1.Text[i] in ['+', '-', '*', '/'] then Break;
    if Edit1.Text[i] = ',' then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    ButtonRavnoClick(Sender); // Метод, который выполняется при нажатии на кнопку равно
    Key := #0; // Предотвращает дальнейшую обработку символа
  end
  else if Key = #8 then // Backspace
  begin
    if Edit1.SelLength > 0 then
    begin
      // Удаление выделенного текста
      Edit1.Text := Copy(Edit1.Text, 1, Edit1.SelStart) + Copy(Edit1.Text, Edit1.SelStart + Edit1.SelLength + 1, Length(Edit1.Text));
      LastInputIsOperation := False;
    end
    else if Length(Edit1.Text) > 0 then
    begin
      // Удаление последнего символа, если текст не выделен
      Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
      LastInputIsOperation := False;
    end;
    Key := #0; // Предотвращает дальнейшую обработку символа
  end
  else if Key in ['0'..'9', #8, '+', '*', '/', ',', ')', '('] then
  begin
    if (Key in ['+', '*', '/', ',']) and ((Edit1.Text = '') or not (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ')'])) then
       Key := #0
    else if Key = '-' then
      if (Edit1.Text = '') or (Edit1.Text[Length(Edit1.Text)] in ['+', '-', '*', '/', ' ']) then
        LastInputIsOperation := True
      else
        Key := #0
    else if (Key = ',') and (LastInputIsOperation or HasCommaInLastNumber or (Edit1.Text = '')) then
      Key := #0
    else
      LastInputIsOperation := Key in ['+', '-', '*', '/'];
  end
  else
    Key := #0; // Блокировка ввода любых других символов
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 Edit1.Text:=Edit1.Text+'7';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'4';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'1';
end;

procedure TForm1.Button0Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'0';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'2';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'3';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'5';
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'6';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'8';
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+'9';
end;

procedure TForm1.ButtonPlysClick(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ')']) then
  begin
    Edit1.Text := Edit1.Text + '+';
    LastInputIsOperation := True;
  end;
end;

procedure TForm1.ButtonMinusClick(Sender: TObject);
var
textLength: Integer;
lastChar: Char;
begin
textLength := Length(Edit1.Text);
if textLength > 0 then
begin
lastChar := Edit1.Text[textLength];
// Проверяем, является ли последний символ операцией или начало строки
if (lastChar in ['+', '-', '*', '/']) then
begin
if lastChar <> '-' then // Если последний символ не минус, добавляем минус
Edit1.Text := Edit1.Text + '-';
end
else
if LastInputIsOperation then // Если последний ввод был операцией, добавляем минус
Edit1.Text := Edit1.Text + '-';
end
else
Edit1.Text := Edit1.Text + '-'; // Если ввод первый, добавляем минус

LastInputIsOperation := True; // Обновляем флаг после добавления операции
end;

procedure TForm1.ButtonDelenieClick(Sender: TObject);
begin
   if (Edit1.Text <> '') and (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ')']) then
  begin
    Edit1.Text := Edit1.Text + '/';
    LastInputIsOperation := True;
  end;
end;

procedure TForm1.ButtonYmnozhenieClick(Sender: TObject);
begin
   if (Edit1.Text <> '') and (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ')']) then
  begin
    Edit1.Text := Edit1.Text + '*';
    LastInputIsOperation := True;
  end;
end;

procedure TForm1.ButtonZapytayClick(Sender: TObject);
begin
   if (Edit1.Text <> '') and (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ')']) then
  begin
    Edit1.Text := Edit1.Text + ',';
    LastInputIsOperation := False;
  end;
end;

procedure TForm1.ButtonStrelkaClick(Sender: TObject);
begin
  if Length(Edit1.Text) > 0 then
  begin
    Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
    LastInputIsOperation := False;
  end;
end;

procedure TForm1.ButtonKopClick(Sender: TObject);
var
  InputValue: Double;
begin
  try
    InputValue := StrToFloat(Edit1.Text);
    if InputValue <= 0 then
      raise Exception.Create('Корень нельзя извлечь');
    InputValue := sqrt(InputValue);
    Edit1.Text := FloatToStr(InputValue);
    LastInputIsOperation := False;
  except
    on E: Exception do
    begin
      Edit1.Text := 'Ошибка: ' + E.Message;
    end;
  end;
end;

procedure TForm1.ButtonKvadratClick(Sender: TObject);
var InputValue: Double;
begin
  try
    InputValue := StrToFloat(Edit1.Text);
    InputValue := sqr(InputValue);
    Edit1.Text := FloatToStr(InputValue);
    LastInputIsOperation := False;
  except
    on E: Exception do
    begin
      Edit1.Text := 'Ошибка: ' + E.Message;
    end;
  end;
end;

procedure TForm1.ButtonDelenieNaXClick(Sender: TObject);
var
  InputValue: Double;
begin
  InputValue := StrToFloatDef(Edit1.Text, 0); // Если введено не число, устанавливаем значение по умолчанию 0
  if InputValue = 0 then
    Edit1.Text := 'Ошибка: Делить на 0 нельзя'
  else
  begin
    InputValue := 1 / InputValue;
    Edit1.Text := FloatToStr(InputValue);
    LastInputIsOperation := False;
  end;
end;

procedure TForm1.ButtonCEClick(Sender: TObject);
begin
  if LastInputIsOperation then
    Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1)
  else
    while (Length(Edit1.Text) > 0) and not (Edit1.Text[Length(Edit1.Text)] in ['+', '-', '*', '/', ' ']) do
      Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
  LastInputIsOperation := False;
end;

procedure TForm1.ButtonCClick(Sender: TObject);
begin
  Edit1.Text := '';
  LastInputIsOperation := False;
end;

function TForm1.Evaluate(Expression: String): Double;
var
  Scripter: TFPExpressionParser;
begin
  Expression := StringReplace(Expression, ',', '.', [rfReplaceAll]); // Заменяем запятые на точки
  Scripter := TFPExpressionParser.Create(nil);
  try
    Scripter.Expression := Expression;
    try
      Result := ArgToFloat(Scripter.Evaluate);
    except
      on E: EMathError do
        raise Exception.Create('Делить на 0 нельзя');
    end;
  finally
    Scripter.Free;
  end;
end;

procedure TForm1.ButtonRavnoClick(Sender: TObject);
var
  Expression: String;
  ResultValue: Double;
begin
  Expression := Edit1.Text;
  try
    ResultValue := Evaluate(Expression);
    Edit1.Text := FloatToStr(ResultValue);
    LastInputIsOperation := False;  // Сбросить флаг после результата
  except
    on E: Exception do
    begin
      Edit1.Text := 'Ошибка: ' + E.Message;
      LastInputIsOperation := False;  // Сбросить флаг в случае ошибки
    end;
  end;
end;
end.
