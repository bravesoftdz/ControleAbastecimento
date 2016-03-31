unit tipoCombustivelDao;

interface

uses
    TipoCombustivel, DB, DM, IBQuery, IBDataBase, Classes;

type
    T_TipoCombustivelDao = class(TObject)
        private
            F_Qr: TIBQuery;
            F_Lista: TList;
        public
            // Os tipos de combustível são fixos, portanto só atualizam preço e imposto
            constructor Create(db: TIBDataBase);
            destructor Destroy();
            procedure atualizar(tipoCombustivel: T_TipoCombustivel);
            function listarTudo(): TList;
            function get(id: Integer): T_TipoCombustivel;
    end;

implementation

const
    SQL_ATUALIZAR =
        'UPDATE TIPOCOMBUSTIVEL '#13#10 +
        'SET '#13#10 +
        '   ValorPorLitro = :valorporlitro , '#13#10 +
        '   PercentualDeImposto = :percentualdeimposto '#13#10 +
        'WHERE Id = :id '#13#10;

    SQL_LISTARTUDO =
        'SELECT * FROM TIPOCOMBUSTIVEL ORDER BY Nome ';

    SQL_GET =
        'SELECT * FROM TIPOCOMBUSTIVEL WHERE ID = :id ';


constructor T_TipoCombustivelDao.Create(db: TIBDataBase);
begin
    F_Qr := TIBQuery.Create(db);
    F_Qr.Database := db;
    F_QR.Transaction := db.DefaultTransaction;
    F_Lista := TList.Create();
end;

destructor T_TipoCombustivelDao.Destroy();
begin
    F_Lista.Free();
end;


procedure T_TipoCombustivelDao.atualizar(tipoCombustivel: T_TipoCombustivel);
begin
    F_Qr.SQL.Text := SQL_ATUALIZAR;
    F_Qr.ParamByName('id').Value := tipoCombustivel.Id;
    F_Qr.ParamByName('valorporlitro').Value := tipoCombustivel.ValorPorLitro;
    F_Qr.ParamByName('percentualdeimposto').Value := tipoCombustivel.PercentualDeImposto;
    F_Qr.ExecSQL();
end;

function T_TipoCombustivelDao.listarTudo(): TList;
var
    a: T_TipoCombustivel;
begin
    F_Qr.SQL.Text := SQL_LISTARTUDO;
    F_Qr.Open();
    result := TList.Create();
    if result = nil then
        result := F_Lista.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_TipoCombustivel.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Nome').AsString,
                F_Qr.FieldByName('ValorPorLitro').AsInteger,
                F_Qr.FieldByName('PercentualDeImposto').AsFloat)
        );
        F_Qr.Next();
    end;
    if F_Qr.Active then
        F_Qr.Close();
end;


function T_TipoCombustivelDao.get(id: Integer): T_TipoCombustivel;
begin
    result := nil;
    F_Qr.SQL.Text := SQL_GET;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.Open();
    if not F_Qr.Eof then
    begin
        result :=
            T_TipoCombustivel.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Nome').AsString,
                F_Qr.FieldByName('ValorPorLitro').AsInteger,
                F_Qr.FieldByName('PercentualDeImposto').AsFloat);
    end;
    if F_Qr.Active then
        F_Qr.Close();
end;


end.
