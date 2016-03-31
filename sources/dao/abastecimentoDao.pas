unit abastecimentoDao;

interface

uses
    Abastecimento, DB, DM, IBQuery, IBDataBase, Classes, SysUtils, DateUtils;

type
    T_AbastecimentoDao = class(TObject)
        private
            F_Qr: TIBQuery;
            F_Lista: TList;
        public
            constructor Create(db: TIBDataBase);
            destructor Destroy();
            function NewID(): Integer;
            function incluir(abastecimento: T_Abastecimento): Integer;
            procedure atualizar(abastecimento: T_Abastecimento);
            procedure remover(abastecimento: T_Abastecimento); overload;
            procedure remover(abastecimento_id: Integer); overload;
            function listarTudo(): TList;
            function listarPorPeriodo(inicio, fim: TDateTime): TList;
            function get(id: Integer): T_Abastecimento;
    end;

implementation

uses
    tanqueDao, tanque, bombaDao, bomba;

var
    vtanqueDao: T_TanqueDao;
    vtanque: T_Tanque;
    vbombaDao: T_BombaDao;
    vbomba: T_Bomba;

const
    SQL_ID =
        'SELECT GEN_ID( ABASTECIMENTO_ID_GEN, 1 ) AS ID FROM RDB$DATABASE;  ';

    SQL_INCLUIR =
        'INSERT INTO ABASTECIMENTO(Id, DataHora, Bomba_Id, Litros, ValorPorLitro, ValorParcial, PercentualImposto, ValorImposto, ValorTotal) '#13#10 +
        'VALUES( :id , :datahora , :bomba_id , :litros , :valorporlitro , :valorparcial , :percentualimposto , :valorImposto , :valortotal ) ';

    SQL_ATUALIZAR =
        'UPDATE ABASTECIMENTO '#13#10 +
        'SET '#13#10 +
        '   Litros = :litros , '#13#10 +
        '   ValorPorLitro = :valorporlitro , '#13#10 +
        '   ValorParcial = :valorparcial , '#13#10 +
        '   PercentualDeImposto = :percentualdeimposto , '#13#10 +
        '   ValorImposto = :valorimposto , '#13#10 +
        '   ValorTotal = :valortotal '#13#10 +
        'WHERE Id = :id '#13#10;

    SQL_EXCLUIR =
        'DELETE FROM ABASTECIMENTO WHERE Id = :id ';

    SQL_LISTARTUDO =
        'SELECT * FROM ABASTECIMENTO ';

    SQL_LISTARPORPERIODO =
        'SELECT * FROM ABASTECIMENTO WHERE DATAHORA BETWEEN :inicio AND :fim ORDER BY DataHora DESC ';

    SQL_GET =
        'SELECT * FROM ABASTECIMENTO WHERE ID = :id ';

constructor T_AbastecimentoDao.Create(db: TIBDataBase);
begin
    F_Qr := TIBQuery.Create(db);
    F_Qr.Database := db;
    F_QR.Transaction := db.DefaultTransaction;
    F_Lista := TList.Create();

    vtanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    vbombaDao := T_BombaDao.Create(dm._dm.IBDataBase1);
    vtanque := T_Tanque.Create();
    vbomba := T_Bomba.Create();

end;

destructor T_AbastecimentoDao.Destroy();
begin
    F_Lista.Free();
end;


function T_AbastecimentoDao.NewID(): Integer;
var
    id: Integer;
begin
    F_Qr.Active := False;
    F_Qr.SQL.Clear();
    F_Qr.SQL.Text := SQL_ID;
    F_Qr.Prepare();
    F_Qr.Open();
    result := F_Qr.FieldByName('Id').AsInteger;
    F_Qr.Active := False;
end;

function T_AbastecimentoDao.incluir(abastecimento: T_Abastecimento): Integer;
var
    id: Integer;
    vtanque: T_Tanque;
begin
    id := NewID();
    F_QR.Active := False;
    F_QR.SQL.Clear();
    F_Qr.SQL.Text := SQL_INCLUIR;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.ParamByName('datahora').Value := abastecimento.DataHora;
    F_Qr.ParamByName('bomba_id').Value := abastecimento.Bomba_ID;
    F_Qr.ParamByName('litros').Value := abastecimento.Litros;
    F_Qr.ParamByName('valorporlitro').Value := abastecimento.ValorPorLitro;
    F_Qr.ParamByName('valorparcial').Value := abastecimento.ValorParcial;
    F_Qr.ParamByName('percentualimposto').Value := abastecimento.PercentualImposto;
    F_Qr.ParamByName('valorImposto').Value := abastecimento.ValorImposto;
    F_Qr.ParamByName('valortotal').Value := abastecimento.ValorTotal;
    F_QR.Prepare();
    F_Qr.ExecSQL();
    abastecimento.Id := id;
    vbomba := vbombaDao.get(abastecimento.Bomba_ID);
    vtanque := vtanqueDao.get(vbomba.Tanque_Id);
    vtanque.Quantidade_Litros := vtanque.Quantidade_Litros - abastecimento.Litros;
    vtanqueDao.atualizar(vtanque);
end;

procedure T_AbastecimentoDao.atualizar(abastecimento: T_Abastecimento);
begin
    F_Qr.SQL.Text := SQL_ATUALIZAR;
    F_Qr.ParamByName('id').Value := abastecimento.id;
    F_Qr.ParamByName('litros').Value := abastecimento.Litros;
    F_Qr.ParamByName('valorporlitro').Value := abastecimento.ValorPorLitro;
    F_Qr.ParamByName('valorparcial').Value := abastecimento.ValorParcial;
    F_Qr.ParamByName('percentualimposto').Value := abastecimento.PercentualImposto;
    F_Qr.ParamByName('valorImposto').Value := abastecimento.ValorImposto;
    F_Qr.ParamByName('valortotal').Value := abastecimento.ValorTotal;
    F_Qr.ExecSQL();
end;

procedure T_AbastecimentoDao.remover(abastecimento: T_Abastecimento);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := abastecimento.Id;
    F_Qr.Prepare();
    F_Qr.ExecSQL();
end;

procedure T_AbastecimentoDao.remover(abastecimento_id: Integer);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := abastecimento_id;
    F_Qr.Prepare();
    F_Qr.ExecSQL();
end;

function T_AbastecimentoDao.listarTudo(): TList;
var
    a: T_Abastecimento;
begin
    F_Qr.SQL.Text := SQL_LISTARTUDO;
    F_Qr.Prepare();
    F_Qr.Open();
    result := TList.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_Abastecimento.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('DataHora').AsDateTime,
                F_Qr.FieldByName('Bomba_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('ValorParcial').AsFloat,
                F_Qr.FieldByName('PercentualImposto').AsFloat,
                F_Qr.FieldByName('ValorImposto').AsFloat,
                F_Qr.FieldByName('ValorTotal').AsFloat)
        );            
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;

function T_AbastecimentoDao.listarPorPeriodo(inicio, fim: TDateTime): TList;
begin
    F_Qr.SQL.Text := SQL_LISTARPORPERIODO;
    F_Qr.ParamByName('inicio').Value := inicio;
    F_Qr.ParamByName('fim').Value := fim;
    F_Qr.Prepare();
    F_Qr.Open();
    result := TList.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_Abastecimento.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('DataHora').AsDateTime,
                F_Qr.FieldByName('Bomba_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('ValorParcial').AsFloat,
                F_Qr.FieldByName('PercentualImposto').AsFloat,
                F_Qr.FieldByName('ValorImposto').AsFloat,
                F_Qr.FieldByName('ValorTotal').AsFloat)
        );            
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;


function T_AbastecimentoDao.get(id: Integer): T_Abastecimento;
var
    a: T_Abastecimento;
begin
    F_Qr.SQL.Text := SQL_GET;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.Prepare();
    F_Qr.Open();
    result := nil;
    if not F_Qr.Eof then
    begin
        result :=
            T_Abastecimento.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('DataHora').AsDateTime,
                F_Qr.FieldByName('Bomba_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('ValorParcial').AsFloat,
                F_Qr.FieldByName('PercentualImposto').AsFloat,
                F_Qr.FieldByName('ValorImposto').AsFloat,
                F_Qr.FieldByName('ValorTotal').AsFloat);
    end;
    if F_Qr.Active then      
        F_Qr.Close();    
end;

end.
