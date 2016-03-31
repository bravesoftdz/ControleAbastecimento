unit fmTanquesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, Mask;

type
  T_fmTanquesList = class(TForm)
    Panel1: TPanel;
    sgLista: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnSalvar: TButton;
    edCapacidade: TEdit;
    edQuantidade: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure sgListaSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListaLoad();
  end;

var
  _fmTanquesList: T_fmTanquesList;

implementation

{$R *.dfm}

uses
    dm, tanqueDao, tanque, tipoCombustivelDao, tipocombustivel;

var
    vtanqueDao: T_TanqueDao;
    vtipoCombustivelDao: T_TipoCombustivelDao;
    vtanque: T_Tanque;
    vtipoCombustivel: T_TipoCombustivel;
    vtanque_id: Integer;


procedure T_fmTanquesList.btnSalvarClick(Sender: TObject);
begin
    vtanque := vtanqueDao.get(vtanque_id);
    vtanque.Capacidade_Litros := StrToFloat(edCapacidade.Text);
    vtanqueDao.atualizar(vtanque);
    ListaLoad();
end;

procedure T_fmTanquesList.ListaLoad();
var
    lista: TList;
    i: Integer;
begin
    lista := vtanqueDao.listarTudo();
    sgLista.RowCount := lista.Count + 1;
    for i := 1 to lista.Count do
    begin
        vtanque := T_Tanque(lista.Items[i-1]);
        if i = 1 then
        begin
            vtanque_id := vtanque.Id;
            edCapacidade.Text := Format('%0.3f', [vtanque.Capacidade_Litros]);
            edQuantidade.Text := Format('%0.3f', [vtanque.Quantidade_Litros]);
        end;   

        vtipoCombustivel := vtipoCombustivelDao.get(vtanque.TipoCombustivel_Id);
        sgLista.Cells[0,i] := IntToStr(vtanque.Id);
        sgLista.Cells[1,i] := Format('%0.2f', [vtanque.Capacidade_Litros]);
        sgLista.Cells[2,i] := Format('%0.2f', [vtanque.Quantidade_Litros]);
        sgLista.Cells[3,i] := vtipoCombustivel.Nome;
    end;
end;

procedure T_fmTanquesList.FormCreate(Sender: TObject);
begin
    sgLista.ColCount := 5;
    sgLista.Cells[0,0] := 'Id';
    sgLista.Cells[1,0] := 'Capacidade/L';
    sgLista.Cells[2,0] := 'Quantidade/L';
    sgLista.Cells[3,0] := 'Tipo';
    sgLista.ColWidths[0] := 150;
    sgLista.Options := sgLista.Options + [goRowSelect];

    vtanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    vtipoCombustivelDao := T_TipoCombustivelDao.Create(dm._dm.IBDataBase1);

    ListaLoad();

end;

procedure T_fmTanquesList.sgListaSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
    id: Integer;
    capacidade, quantidade: String;
begin
    try
        id := StrToInt(sgLista.Cells[0, ARow]);
        vtanque := vtanqueDao.get(id);
        vtanque_id := vtanque.Id;
        edCapacidade.Text := Format('%0.3f', [vtanque.Capacidade_Litros]);
        edQuantidade.Text := Format('%0.3f', [vtanque.Quantidade_Litros]);
    except

    end;
end;

end.
