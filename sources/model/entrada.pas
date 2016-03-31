unit entrada;

interface

uses
    SysUtils, DateUtils;

type
    T_Entrada = class(TObject)

        private
            F_Id: Integer;
            F_Tanque_Id: Integer;
            F_Litros: Double;
            F_ValorPorLitro: Double;
            F_ValorDaEntrada: Double;
            F_DataHora: TDateTime;
            // F_Id
            function getId(): Integer;
            procedure setId(pId: Integer);
            // F_Tanque_Id
            function getTanque_Id(): Integer;
            procedure setTanque_Id(pTanque_Id: Integer);
            // F_Litros
            function getLitros(): Double;
            procedure setLitros(pLitros: Double);
            // F_ValorPorLitro
            function getValorPorLitro(): Double;
            procedure setValorPorLitro(pValorPorLitro: Double);
            // F_ValorDaEntrada
            function getValorDaEntrada(): Double;
            // F_DataHora
            function getDataHora(): TDateTime;
            procedure setDataHora(pDataHora: TDateTime);
            procedure Totalizar();
        public
            constructor Create(
                pId: Integer;
                pTanque_Id: Integer;
                pLitros: Double;
                pValorPorLitro: Double;
                pDataHora: TDateTime
            ); overload;

            constructor Create();  overload;
        published

            property Id: Integer read getId write setId;
            property Tanque_Id: Integer read getTanque_Id write setTanque_Id;
            property Litros: Double read getLitros write setLitros;
            property ValorPorLitro: Double read getValorPorLitro write setValorPorLitro;
            property ValorDaEntrada: Double read getValorDaEntrada; // somente leitura
            property DataHora: TDateTime read getDataHora write setDataHora;
    end;

implementation

constructor T_Entrada.Create(
    pId: Integer;
    pTanque_Id: Integer;
    pLitros: Double;
    pValorPorLitro: Double;
    pDataHora: TDateTime
);
begin
    if (pDataHora = 0) then
        pDataHora := Now();
    F_Id := pId;
    F_Tanque_Id := pTanque_Id;
    F_Litros := pLitros;
    F_ValorPorLitro := pValorPorLitro;
    F_DataHora := pDataHora;
    Totalizar();
end;


constructor T_Entrada.Create();
begin
//
end;


procedure T_Entrada.Totalizar();
begin
    try
        F_ValorDaEntrada := F_Litros * F_ValorPorLitro;
    except
    end;
end;

// F_Id
function T_Entrada.getId(): Integer;
begin
    result := F_Id;
end;

procedure T_Entrada.setId(pId: Integer);
begin
    F_Id := pId;
end;

// F_Tanque_Id
function T_Entrada.getTanque_Id(): Integer;
begin
    result := F_Tanque_Id;
end;

procedure T_Entrada.setTanque_Id(pTanque_Id: Integer);
begin
    F_Tanque_Id := pTanque_Id;
end;

// F_Litros
function T_Entrada.getLitros(): Double;
begin
    result := F_Litros;
end;

procedure T_Entrada.setLitros(pLitros: Double);
begin
    F_Litros := pLitros;
    Totalizar();
end;

// F_ValorPorLitro
function T_Entrada.getValorPorLitro(): Double;
begin
    result := F_ValorPorLitro;
end;

procedure T_Entrada.setValorPorLitro(pValorPorLitro: Double);
begin
    F_ValorPorLitro := pValorPorLitro;
    Totalizar();
end;

// F_ValorDaEntrada
function T_Entrada.getValorDaEntrada(): Double;
begin
    result := F_ValorDaEntrada;
end;

// F_DataHora
function T_Entrada.getDataHora(): TDateTime;
begin
    result := F_DataHora;
end;

procedure T_Entrada.setDataHora(pDataHora: TDateTime);
begin
    F_DataHora := pDataHora;
end;


end.
