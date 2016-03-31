unit entradaController;

interface

uses
    IBQuery, IBDataBase, Classes, SysUtils, DateUtils, Entrada, EntradaDao,
    tanqueDao, Tanque;

const
    STATUS_ENTRADA: array [1..4] of string =
    (
        'Sucesso!',
        'Não aceita valor negativo',
        'Não aceita 0 ou nulo',
        'Excede a capacidade do tanque.'
    );
type

    T_EntradaController = class(TObject)
        private
            F_TanqueDao: T_TanqueDao;
            F_EntradaDao: T_EntradaDao;
            F_Tanque: T_Tanque;
            F_Entrada: T_Entrada;

        public
            constructor Create(db: TIBDatabase; pEntrada: T_Entrada; pTanque_Id: Integer);
            destructor Destroy();

            function efetuarEntrada(var Status: String): boolean;

    end;

implementation

constructor T_EntradaController.Create(db: TIBDatabase; pEntrada: T_Entrada; pTanque_Id: Integer);
begin
    F_EntradaDao := T_EntradaDao.Create(db);
    F_TanqueDao := T_TanqueDao.Create(db);
    F_Entrada := pEntrada;
    F_Tanque := F_TanqueDao.get(pTanque_Id);;

end;

destructor T_EntradaController.Destroy();
begin
    F_EntradaDao.Destroy();
    F_TanqueDao.Destroy();
end;


function T_EntradaController.efetuarEntrada(var Status: String): boolean;
var
    espacoExtra: Double;
begin
    result := false;
    espacoExtra := F_Tanque.Capacidade_Litros - F_Tanque.Quantidade_Litros;
    if F_Entrada.Litros = 0 then
    begin
        Status := STATUS_ENTRADA[3];
        result := false;
    end
    else if F_Entrada.Litros < 0 then
    begin
        Status := STATUS_ENTRADA[2];
        result := false;
    end
    else if F_Entrada.Litros > espacoExtra then
    begin
        Status := STATUS_ENTRADA[4];
        result := false;
    end
    else if F_Entrada.Litros <= espacoExtra then
    begin
        Status := STATUS_ENTRADA[1];
        result := true;
        F_EntradaDao.incluir(F_Entrada);
        F_Tanque.Quantidade_Litros := F_Tanque.Quantidade_Litros + F_Entrada.Litros;
        F_TanqueDao.atualizar(F_Tanque);
    end;

end;


end.
