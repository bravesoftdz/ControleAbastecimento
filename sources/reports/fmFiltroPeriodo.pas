unit fmFiltroPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  T_fmFiltroPeriodo = class(TForm)
    dtpDe: TDateTimePicker;
    dtpAte: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnConfirma: TBitBtn;
    btnCancela: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure dtpDeChange(Sender: TObject);
    procedure dtpAteChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _fmFiltroPeriodo: T_fmFiltroPeriodo;
    de, ate: TDateTime;

function getDe(): TDateTime;
function getAte(): TDateTime;

implementation

{$R *.dfm}


function getDe(): TDateTime;
var
    sDe: String;
begin
    de := de;
    sDe := FormatDateTime('dd/MM/yyyy', de) + ' 00:00:00.000';
    result := StrToDateTime(sDe);
end;

function getAte(): TDateTime;
var
    sAte: String;
begin
    de := ate;
    sAte := FormatDateTime('dd/MM/yyyy', de) + ' 23:59:59.997';
    result := StrToDateTime(sAte);
end;

procedure T_fmFiltroPeriodo.dtpAteChange(Sender: TObject);
begin
    ate := dtpAte.DateTime;
end;

procedure T_fmFiltroPeriodo.dtpDeChange(Sender: TObject);
begin
    de := dtpDe.DateTime;
end;

procedure T_fmFiltroPeriodo.FormCreate(Sender: TObject);
var
    data: TDateTime;
begin
    data := Now();
    dtpDe.Date := data;
    dtpAte.Date := data;
    de := data;
    ate := data;
end;                     
end.
