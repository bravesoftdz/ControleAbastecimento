unit fmAbastecimentosList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, ExtCtrls;

type
  T_fmAbastecimentosList = class(TForm)
    sgLista: TStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dtpDe: TDateTimePicker;
    dtpAte: TDateTimePicker;
    btnListar: TButton;
    Panel2: TPanel;
    lbTotais: TLabel;
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _fmAbastecimentosList: T_fmAbastecimentosList;

implementation

{$R *.dfm}

uses
    dm, abastecimentoDao, abastecimento;

procedure T_fmAbastecimentosList.btnListarClick(Sender: TObject);
var
    dao: T_AbastecimentoDao;
    lista: TList;
    i: Integer;
    abastecimento: T_Abastecimento;
    imposto, recebido: Double;
    de, ate: TDateTime;
begin
    imposto := 0;
    recebido := 0;

    de := StrToDateTime(FormatDateTime('dd/MM/yyyy', dtpDe.Date) + ' 00:00:00');
    ate := StrToDateTime(FormatDateTime('dd/MM/yyyy', dtpAte.Date) + ' 23:59:59');

    dao := T_AbastecimentoDao.Create(dm._dm.IBDataBase1);
    lista := dao.listarPorPeriodo(de, ate);
    sgLista.RowCount := lista.Count + 1;
    for i := 1 to lista.Count do
    begin
        abastecimento := T_Abastecimento(lista.Items[i-1]);
        imposto := imposto + abastecimento.ValorImposto;
        recebido := recebido + abastecimento.ValorTotal; 
        sgLista.Cells[0,i] := FormatDateTime('dd/MM/yyyy hh:nn:ss', abastecimento.DataHora);
        sgLista.Cells[1,i] := FloatToStr(abastecimento.Litros);
        sgLista.Cells[2,i] := FloatToStr(abastecimento.ValorImposto);
        sgLista.Cells[3,i] := FloatToStr(abastecimento.ValorTotal);
        sgLista.Cells[4,i] := IntToStr(abastecimento.Id);
    end;
    lbTotais.Caption :=
        'Imposto Total: '
        + Format('%m', [imposto])
        + ' / Recebido: '
        + Format('%m', [recebido]);
end;

procedure T_fmAbastecimentosList.FormCreate(Sender: TObject);
begin
    sgLista.ColCount := 5;
    sgLista.RowCount := 1;
    sgLista.Cells[0,0] := 'Data/Hora';
    sgLista.Cells[1,0] := 'Litros';
    sgLista.Cells[2,0] := 'Imposto';
    sgLista.Cells[3,0] := 'Valor';
    sgLista.Cells[4,0] := 'Id';
    sgLista.ColWidths[0] := 150;
    sgLista.Options := sgLista.Options + [goRowSelect];

    dtpDe.Date := Now();
    dtpAte.Date := Now();

end;

end.
