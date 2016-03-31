unit bombaDao;

interface

uses
    Bomba, DB, DM, IBQuery, IBDataBase, Classes;

type
    T_BombaDao = class(TObject)
        private
            F_Qr: TIBQuery;
            F_Lista: TList;
        public
            constructor Create(db: TIBDataBase);
            destructor Destroy();
            function NewID(): Integer;
            function incluir(bomba: T_Bomba): Integer;
            procedure atualizar(bomba: T_Bomba);
            procedure remover(bomba: T_Bomba); overload;
            procedure remover(bomba_id: Integer); overload;
            function listarTudo(): TList;
            function get(id: Integer): T_Bomba;
            function getByNumero(numero: Integer): T_Bomba;
    end;

implementation

const
    SQL_ID =
        'SELECT GEN_ID( BOMBA_ID_GEN, 1 ) AS ID FROM RDB$DATABASE;  ';

    SQL_INCLUIR =
        'INSERT INTO BOMBA(Id, Tanque_ID, Numero ) '#13#10 +
        'VALUES( :id , :tanque_id , :numero ) ';

    SQL_ATUALIZAR =
        'UPDATE BOMBA '#13#10 +
        'SET '#13#10 +
        '   Tanque_ID = :tanque_id , '#13#10 +
        '   Numero = :numero '#13#10 +
        'WHERE Id = :id '#13#10;

    SQL_EXCLUIR =
        'DELETE FROM BOMBA WHERE Id = :id ';

    SQL_LISTARTUDO =
        'SELECT * FROM BOMBA ORDER BY Numero ASC ';

    SQL_GET =
        'SELECT * FROM BOMBA WHERE ID = :id ';

    SQL_GETBYNUMERO =
        'SELECT * FROM BOMBA WHERE Numero = :numero ';

constructor T_BombaDao.Create(db: TIBDataBase);
begin
    F_Qr := TIBQuery.Create(db);
    F_Qr.Database := db;
    F_QR.Transaction := db.DefaultTransaction;
    F_Lista := TList.Create();
end;

destructor T_BombaDao.Destroy();
begin
    F_Lista.Free();
end;


function T_BombaDao.NewID(): Integer;
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

function T_BombaDao.incluir(bomba: T_Bomba): Integer;
var
    id: Integer;
begin
    id := NewID();
    F_QR.Active := False;
    F_QR.SQL.Clear();
    F_Qr.SQL.Text := SQL_INCLUIR;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.ParamByName('tanque_id').Value := bomba.Tanque_Id;
    F_Qr.ParamByName('numero').Value := bomba.Numero;
    F_QR.Prepare();
    F_Qr.ExecSQL();
    bomba.Id := id;
end;

procedure T_BombaDao.atualizar(bomba: T_Bomba);
begin
    F_Qr.SQL.Text := SQL_ATUALIZAR;
    F_Qr.ParamByName('id').Value := bomba.id;
    F_Qr.ParamByName('tanque_id').Value := bomba.Tanque_Id;
    F_Qr.ParamByName('numero').Value := bomba.Numero;
    F_Qr.ExecSQL();
end;

procedure T_BombaDao.remover(bomba: T_Bomba);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := bomba.Id;
    F_Qr.Delete();
end;

procedure T_BombaDao.remover(bomba_id: Integer);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := bomba_id;
    F_Qr.Delete();
end;

function T_BombaDao.listarTudo(): TList;
var
    a: T_Bomba;
begin
    F_Qr.SQL.Text := SQL_LISTARTUDO;
    F_Qr.Open();
    result := TList.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_Bomba.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Numero').AsInteger)
        );            
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;




function T_BombaDao.get(id: Integer): T_Bomba;
var
    a: T_Bomba;
begin
    F_Qr.SQL.Text := SQL_GET;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.Open();
    result := nil;
    if not F_Qr.Eof then
    begin
        result :=
           T_Bomba.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Numero').AsInteger)
    end;
    if F_Qr.Active then
        F_Qr.Close();    
end;


function T_BombaDao.getByNumero(numero: Integer): T_Bomba;
var
    a: T_Bomba;
begin
    F_Qr.SQL.Text := SQL_GETBYNUMERO;
    F_Qr.ParamByName('numero').Value := numero;
    F_Qr.Open();
    result := nil;
    if not F_Qr.Eof then
    begin
        result :=
           T_Bomba.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Numero').AsInteger)
    end;
    if F_Qr.Active then
        F_Qr.Close();    
end;

end.

