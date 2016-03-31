unit fmBombasList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  T_fmBombasList = class(TForm)
    Panel1: TPanel;
    sgLista: TStringGrid;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListaLoad();
  end;

var
  _fmBombasList: T_fmBombasList;

implementation

{$R *.dfm}

uses
    dm, tanqueDao, tanque, bombaDao, bomba, tipocombustivelDao, tipoCombustivel;

var
    vtanqueDao: T_TanqueDao;
    vbombaDao: T_BombaDao;
    vtipoCombustivelDao: T_TipoCombustivelDao;
    vtanque: T_Tanque;
    vbomba: T_Bomba;
    vtipoCombustivel: T_TipoCombustivel;
    vbomba_id: Integer;


procedure T_fmBombasList.ListaLoad();
var
    lista: TList;
    i: Integer;
begin
    lista := vbombaDao.listarTudo();
    sgLista.RowCount := lista.Count + 1;
    for i := 1 to lista.Count do
    begin
        vbomba := T_Bomba(lista.Items[i-1]);
        vtanque := vtanqueDao.get(vbomba.Tanque_Id);
        vtipoCombustivel := vtipoCombustivelDao.get(vtanque.TipoCombustivel_Id);
        if i = 1 then
        begin
            // id da primeira linha
            vbomba_id := vbomba.Id;
        end;

        sgLista.Cells[0,i] := IntToStr(vbomba.Id);
        sgLista.Cells[1,i] := IntToStr(vbomba.Tanque_Id);
        sgLista.Cells[2,i] := IntToStr(vbomba.Numero);
        sgLista.Cells[3,i] := vtipoCombustivel.Nome;
    end;
end;

procedure T_fmBombasList.FormCreate(Sender: TObject);
begin
    sgLista.ColCount := 4;
    sgLista.Cells[0,0] := 'Id';
    sgLista.Cells[1,0] := 'Tanque';
    sgLista.Cells[2,0] := 'Bomba';
    sgLista.Cells[3,0] := 'Combustivel';
    sgLista.Options := sgLista.Options + [goRowSelect];

    vtanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    vbombaDao := T_BombaDao.Create(dm._dm.IBDataBase1);
    vtipoCombustivelDao := T_TipoCombustivelDao.Create(dm._dm.IBDataBase1);

    ListaLoad();
end;

end.
