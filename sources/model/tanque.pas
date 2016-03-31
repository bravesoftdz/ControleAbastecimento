unit tanque;

interface

uses
    SysUtils, DateUtils;

type

    T_Tanque = class(TObject)

        private
            F_Id: Integer;
            F_Capacidade_Litros: Double;
            F_Quantidade_Litros: Double;
            F_TipoCombustivel_Id: Integer;
            // F_Id
            procedure setId(pId: Integer);
            function getId(): Integer;
            // F_Capacidade_Litros
            procedure setCapacidade_Litros(pCapacidade_Litros: Double);
            function getCapacidade_Litros(): Double;
            // F_Quantidade_Litros
            procedure setQuantidade_Litros(pQuantidade_Litros: Double);
            function getQuantidade_Litros(): Double;
            // F_TipoCombustivel_Id
            procedure setTipoCombustivel_Id(pTipoCombustivel_Id: Integer);
            function getTipoCombustivel_Id(): Integer;
        public
            constructor Create(
                pId: Integer;
                pCapacidade_Litros: Double;
                pQuantidade_Litros: Double;
                pTipoCombustivel_Id: Integer); overload;
            constructor Create(); overload;
        published
            property Id: Integer read getId write setId;
            property Capacidade_Litros: Double read getCapacidade_Litros write setCapacidade_Litros;
            property Quantidade_Litros: Double read getQuantidade_Litros write setQuantidade_Litros;
            property TipoCombustivel_Id: Integer read getTipoCombustivel_Id write setTipoCombustivel_Id;
    end;


implementation

constructor T_Tanque.Create(
    pId: Integer;
    pCapacidade_Litros: Double;
    pQuantidade_Litros: Double;
    pTipoCombustivel_Id: Integer);
begin
    F_Id := pId;
    F_Capacidade_Litros := pCapacidade_Litros;
    F_Quantidade_Litros := pQuantidade_Litros;
    F_TipoCombustivel_Id := pTipoCombustivel_Id;
end;


constructor T_Tanque.Create();
begin

end;

// F_Id
procedure T_Tanque.setId(pId: Integer);
begin
    F_Id := pId;
end;


function T_Tanque.getId(): Integer;
begin
    result := F_Id;
end;

// F_Capacidade_Litros
procedure T_Tanque.setCapacidade_Litros(pCapacidade_Litros: Double);
begin
    F_Capacidade_Litros := pCapacidade_Litros;
end;

function T_Tanque.getCapacidade_Litros(): Double;
begin
    result := F_Capacidade_Litros;
end;

// F_Quantidade_Litros
procedure T_Tanque.setQuantidade_Litros(pQuantidade_Litros: Double);
begin
    F_Quantidade_Litros := pQuantidade_Litros;
end;

function T_Tanque.getQuantidade_Litros(): Double;
begin
    result := F_Quantidade_Litros;
end;

// F_TipoCombustivel_Id
procedure T_Tanque.setTipoCombustivel_Id(pTipoCombustivel_Id: Integer);
begin
    F_TipoCombustivel_Id := pTipoCombustivel_Id;
end;

function T_Tanque.getTipoCombustivel_Id(): Integer;
begin
    result := F_TipoCombustivel_Id;
end;

end.
