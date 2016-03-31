unit tanqueDao;

interface

uses
    Tanque, DB, DM, IBQuery, IBDataBase, Classes;

type
    T_TanqueDao = class(TObject)
        private
            F_Qr: TIBQuery;
            F_Lista: TList;
        public
            constructor Create(db: TIBDataBase);
            destructor Destroy();
            function NewID(): Integer;
            function incluir(tanque: T_Tanque): Integer;
            procedure atualizar(tanque: T_Tanque);
            procedure remover(tanque: T_Tanque); overload;
            procedure remover(tanque_id: Integer); overload;
            function listarTudo(): TList;
            function get(id: Integer): T_Tanque;
    end;

implementation

const
    SQL_ID =
        'SELECT GEN_ID( TANQUE_ID_GEN, 1 ) AS ID FROM RDB$DATABASE;  ';

    SQL_INCLUIR =
        'INSERT INTO TANQUE(Id, Capacidade_Litros, Quantidade_Litros, TipoCombustivel_Id) '#13#10 +
        'VALUES( :id , :capacidade_litros , :quantidade_litros , :tipocombustivel_id ) ';

    SQL_ATUALIZAR =
        'UPDATE TANQUE '#13#10 +
        'SET '#13#10 +
        '   capacidade_litros = :capacidade_litros , '#13#10 +
        '   quantidade_litros = :quantidade_litros , '#13#10 +
        '   tipocombustivel_id = :tipocombustivel_id '#13#10 +
        'WHERE Id = :id '#13#10;

    SQL_EXCLUIR =
        'DELETE FROM TANQUE WHERE Id = :id ';

    SQL_LISTARTUDO =
        'SELECT * FROM TANQUE ';

    SQL_GET =
        'SELECT * FROM TANQUE WHERE ID = :id ';


constructor T_TanqueDao.Create(db: TIBDataBase);
begin
    F_Qr := TIBQuery.Create(db);
    F_Qr.Database := db;
    F_QR.Transaction := db.DefaultTransaction;
    F_Lista := TList.Create();
end;

destructor T_TanqueDao.Destroy();
begin
    F_Lista.Free();
end;


function T_TanqueDao.NewID(): Integer;
var
    id: Integer;
begin
    F_Qr.Active := False;
    F_Qr.SQL.Clear();
    F_Qr.SQL.Text := SQL_ID;
    F_Qr.Open();
    result := F_Qr.FieldByName('Id').AsInteger;
    F_Qr.Active := False;
end;

function T_TanqueDao.incluir(tanque: T_Tanque): Integer;
var
    id: Integer;
begin
    id := NewID();
    F_QR.Active := False;
    F_QR.SQL.Clear();
    F_Qr.SQL.Text := SQL_INCLUIR;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.ParamByName('capacidade_litros').Value := tanque.Capacidade_Litros;
    F_Qr.ParamByName('quantidade_litros').Value := tanque.Quantidade_Litros;
    F_Qr.ParamByName('tipocombustivel_id').Value := tanque.TipoCombustivel_Id;
    F_QR.Prepare();
    F_Qr.ExecSQL();
    tanque.Id := id;
end;

procedure T_TanqueDao.atualizar(tanque: T_Tanque);
begin
    F_Qr.SQL.Text := SQL_ATUALIZAR;
    F_Qr.ParamByName('id').Value := tanque.id;
    F_Qr.ParamByName('capacidade_litros').Value := tanque.Capacidade_Litros;
    F_Qr.ParamByName('quantidade_litros').Value := tanque.Quantidade_Litros;
    F_Qr.ParamByName('tipocombustivel_id').Value := tanque.TipoCombustivel_Id;
    F_Qr.ExecSQL();
end;

procedure T_TanqueDao.remover(tanque: T_Tanque);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := tanque.Id;
    F_Qr.Delete();
end;

procedure T_TanqueDao.remover(tanque_id: Integer);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := tanque_id;
    F_Qr.Delete();
end;

function T_TanqueDao.listarTudo(): TList;
var
    a: T_Tanque;
begin
    F_Qr.SQL.Text := SQL_LISTARTUDO;
    F_Qr.Open();
    F_Lista.Clear();
    result := TList.Create();
    if result = nil then
        result := F_Lista.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_Tanque.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Capacidade_Litros').AsFloat,
                F_Qr.FieldByName('Quantidade_Litros').AsFloat,
                F_Qr.FieldByName('TipoCombustivel_Id').AsInteger)
        );            
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;




function T_TanqueDao.get(id: Integer): T_Tanque;
var
    a: T_Tanque;
begin
    F_Qr.SQL.Text := SQL_GET;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.Open();
    result := nil;
    if not F_Qr.Eof then
    begin
        result :=
            T_Tanque.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Capacidade_Litros').AsFloat,
                F_Qr.FieldByName('Quantidade_Litros').AsFloat,
                F_Qr.FieldByName('TipoCombustivel_Id').AsInteger);
    end;
    if F_Qr.Active then      
        F_Qr.Close();    
end;

end.
