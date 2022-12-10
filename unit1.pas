unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, JPEGLib;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_save: TBitBtn;
    Image1: TImage;
    Memo1: TMemo;
    procedure btn_saveClick(Sender: TObject);
    procedure draw_text(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure init(Sender: TObject);
    procedure text_update(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.init(Sender: TObject);
begin
  with Image1.Canvas do begin
    Font.Name := 'Comic Sans MS';
    Font.Size := 14;
  end;
end;

procedure TForm1.text_update(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  Image1.Invalidate;
end;

procedure TForm1.draw_text(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i, x, y : Integer;
begin
  x := 64;
  y := 64;
  for i := 0 to Memo1.Lines.Count - 1 do begin
    Image1.Canvas.TextOut(x, y + 20 * i, Memo1.Lines[i]);
  end;
end;

procedure TForm1.btn_saveClick(Sender: TObject);
var
  i, x, y : Integer;
  imJPEG : TJPEGImage;
begin
  imJPEG := TJPEGImage.Create;
  x := 64;
  y := 64;
  // Настройки шрифта (для сохранения)
  with imJPEG.Canvas do begin
    Font.Name := 'Comic Sans MS';
    Font.Size := 14;
  end;
  try
    imJPEG.Assign(Image1.Picture.Graphic);
    for i := 0 to Memo1.Lines.Count - 1 do begin
      imJPEG.Canvas.TextOut(x, y + 20 * i, Memo1.Lines[i]);
    end;
    imJPEG.SaveToFile('meme.jpg');
  finally
    imJPEG.Free;
  end;
end;


end.

