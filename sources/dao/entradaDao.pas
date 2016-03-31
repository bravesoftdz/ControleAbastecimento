unit entradaDao;

interface

uses
    Abastecimento, DB, DM, IBQuery, IBDataBase, Classes, SysUtils, DateUtils, entrada;

type
    T_EntradaDao = class(TObject)
        private
            F_Qr: TIBQuery;
            F_Lista: TList;
        public
            constructor Create(db: TIBDataBase);
            destructor Destroy();
            function NewID(): Integer;
            function incluir(entrada: T_Entrada): Integer;
            procedure atualizar(entrada: T_Entrada);
            procedure remover(entrada: T_Entrada); overload;
            procedure remover(entrada_id: Integer); overload;
            function listarTudo(): TList;
            function listarPorPeriodo(inicio, fim: TDateTime): TList;
            function get(id: Integer): T_Entrada;
    end;

implementation

uses
    tanqueDao, tanque;

var
    vtanqueDao: T_TanqueDao;
    vtanque: T_Tanque;
    ventrada: T_Entrada;
    ventrada_id: Integer;

const
    SQL_ID =
        'SELECT GEN_ID( ENTRADA_ID_GEN, 1 ) AS ID FROM RDB$DATABASE;  ';

    SQL_INCLUIR =
        'INSERT INTO Entrada(Id, Tanque_Id, Litros, ValorPorLitro, ValorDaEntrada, DataHora) '#13#10 +
        'VALUES( :id , :tanque_id , :litros , :valorporlitro , :valordaentrada , :datahora ) ';

    SQL_ATUALIZAR =
        'UPDATE Entrada '#13#10 +
        'SET '#13#10 +
        '   Tanque_Id = :tanque_id , '#13#10 +
        '   Litros = :litros , '#13#10 +
        '   ValorPorLitro = :valorporlitro , '#13#10 +
        '   ValorDaEntrada = :valordaentrada , '#13#10 +
        '   DataHora = :datahora  '#13#10 +
        'WHERE Id = :id '#13#10;

    SQL_EXCLUIR =
        'DELETE FROM Entrada WHERE Id = :id ';

    SQL_LISTARTUDO =
        'SELECT * FROM Entrada ORDER BY DataHora DESC ';

    SQL_LISTARPORPERIODO =
        'SELECT * FROM Entrada WHERE DataHora BETWEEN :inicio AND :fim ORDER BY DataHora DESC ';

    SQL_GET =
        'SELECT * FROM Entrada WHERE ID = :id ';

constructor T_EntradaDao.Create(db: TIBDataBase);
begin
    F_Qr := TIBQuery.Create(db);
    F_Qr.Database := db;
    F_QR.Transaction := db.DefaultTransaction;
    F_Lista := TList.Create();

    vtanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    vtanque := T_Tanque.Create();
end;

destructor T_EntradaDao.Destroy();
begin
    F_Lista.Free();
end;


function T_EntradaDao.NewID(): Integer;
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

function T_EntradaDao.incluir(entrada: T_Entrada): Integer;
var
    id: Integer;
    vtanque: T_Tanque;
begin
    id := NewID();
    F_QR.Active := False;
    F_QR.SQL.Clear();
    F_Qr.SQL.Text := SQL_INCLUIR;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.ParamByName('tanque_id').Value := Entrada.Tanque_Id;
    F_Qr.ParamByName('litros').Value := Entrada.Litros;
    F_Qr.ParamByName('valorporlitro').Value := Entrada.ValorPorLitro;
    F_Qr.ParamByName('valordaentrada').Value := Entrada.ValorDaEntrada;
    F_Qr.ParamByName('datahora').Value := Entrada.DataHora;
    F_QR.Prepare();
    F_Qr.ExecSQL();
    Entrada.Id := id;
    ventrada_id := id;
    result := id;
end;

procedure T_EntradaDao.atualizar(Entrada: T_Entrada);
begin
    F_Qr.SQL.Text := SQL_ATUALIZAR;
    F_Qr.ParamByName('id').Value := entrada.id;
    F_Qr.ParamByName('tanque_id').Value := Entrada.Tanque_Id;
    F_Qr.ParamByName('litros').Value := Entrada.Litros;
    F_Qr.ParamByName('valorporlitro').Value := Entrada.ValorPorLitro;
    F_Qr.ParamByName('valordaentrada').Value := Entrada.ValorDaEntrada;
    F_Qr.ParamByName('datahora').Value := Entrada.DataHora;
    F_QR.Prepare();
    F_Qr.ExecSQL();
end;

procedure T_EntradaDao.remover(Entrada: T_Entrada);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := Entrada.Id;
    F_QR.Prepare();
    F_Qr.ExecSQL();
end;

procedure T_EntradaDao.remover(entrada_id: Integer);
begin
    F_Qr.SQL.Text := SQL_EXCLUIR;
    F_Qr.ParamByName('id').Value := entrada_id;
    F_QR.Prepare();
    F_Qr.ExecSQL();
end;

function T_EntradaDao.listarTudo(): TList;
var
    a: T_Entrada;
begin
    F_Qr.SQL.Text := SQL_LISTARTUDO;
    F_Qr.Prepare();
    F_Qr.Open();
    result := TList.Create();
    F_Qr.First();
    while not F_Qr.Eof do
    begin
        result.Add(
            T_Entrada.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('DataHora').AsDateTime)
        );
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;

function T_EntradaDao.listarPorPeriodo(inicio, fim: TDateTime): TList;
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
            T_Entrada.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('DataHora').AsDateTime)
        );
        F_Qr.Next();
    end;         
    if F_Qr.Active then      
        F_Qr.Close();    
end;


function T_EntradaDao.get(id: Integer): T_Entrada;
var
    a: T_Entrada;
begin
    F_Qr.SQL.Text := SQL_GET;
    F_Qr.ParamByName('id').Value := id;
    F_Qr.Prepare();
    F_Qr.Open();
    result := nil;
    if not F_Qr.Eof then
    begin
        result :=
            T_Entrada.Create(
                F_Qr.FieldByName('Id').AsInteger,
                F_Qr.FieldByName('Tanque_Id').AsInteger,
                F_Qr.FieldByName('Litros').AsFloat,
                F_Qr.FieldByName('ValorPorLitro').AsFloat,
                F_Qr.FieldByName('DataHora').AsDateTime);
    end;
    if F_Qr.Active then      
        F_Qr.Close();    
end;

end.
