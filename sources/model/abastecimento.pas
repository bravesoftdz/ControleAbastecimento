unit abastecimento;

interface

uses
    SysUtils, DateUtils;


type

    // Classe modelo de abastecimentos
    T_Abastecimento = class(TObject)

            F_Id: Integer;
            F_DataHora: TDateTime;
            F_Bomba_ID: Integer;
            F_Litros: Double;
            F_ValorPorLitro: Double;
            F_ValorParcial: Double;
            F_PercentualImposto: Double;
            F_ValorImposto: Double;
            F_ValorTotal: Double;

            // F_DataHora
            procedure setDataHora(pDataHora: TDateTime);
            function getDataHora(): TDateTime;
            // F_Litros
            procedure setLitros(pLitros: Double);
            function getLitros(): Double;
            // F_ValorPorLitro
            procedure setValorPorLitro(pValor: Double);
            function getValorPorLitro(): Double;
            // F_ValorParcial
            procedure serValorParcial(pValor: Double);
            function getValorParcial(): Double;
            // F_PercentualImpostos
            procedure setPercentualImposto(pPercentual: Double);
            function getPercentualImposto(): Double;
            // F_ValorImposto
            function getValorImposto(): Double;
            // F_ValorTotal
            function getValorTotal(): Double;
            // Totalizar
            procedure Totalizar();
        public
            constructor Create(
                pId: Integer;
                pDataHora: TDateTime;
                pBomba_ID: Integer;
                pLitros: Double;
                pValorPorLitro: Double;
                pValorParcial: Double;
                pPercentualImposto: Double;
                pValorImposto: Double;
                pValorTotal: Double
            ); overload;

            constructor Create(
                pDataHora: TDateTime;
                pBomba_ID: Integer;
                pLitros: Double;
                pValorPorLitro: Double;
                pPercentualImposto: Double); overload;

            constructor Create(); overload;

        published
            property Id: Integer read F_Id write F_Id;
            property DataHora: TDateTime read getDataHora write setDataHora;
            property Bomba_ID: Integer read F_Bomba_ID write F_Bomba_ID;
            property Litros: Double read getLitros write setLitros;
            property ValorPorLitro: Double read getValorPorLitro write setValorPorLitro;
            property ValorParcial: Double read getValorParcial; // somente leitura
            property PercentualImposto: Double read getPercentualImposto write setPercentualImposto;
            property ValorImposto: Double read getValorImposto; // somente leitura
            property ValorTotal: Double read getValorTotal; // somente leitura
    end;

implementation


constructor T_Abastecimento.Create(
        pDataHora: TDateTime;
        pBomba_ID: Integer;
        pLitros: Double;
        pValorPorLitro: Double;
        pPercentualImposto: Double);
begin
    if (pDataHora = 0) then
        pDataHora := Now();
    Self.F_Litros := pLitros;
    Self.F_Bomba_ID := pBomba_ID;
    Self.F_DataHora := pDataHora;
    Self.F_ValorPorLitro := pValorPorLitro;
    Self.F_PercentualImposto := pPercentualImposto;
    Self.Totalizar();
end;

// utilizar no load da classe Dao
constructor T_Abastecimento.Create(
            pId: Integer;
            pDataHora: TDateTime;
            pBomba_ID: Integer;
            pLitros: Double;
            pValorPorLitro: Double;
            pValorParcial: Double;
            pPercentualImposto: Double;
            pValorImposto: Double;
            pValorTotal: Double
        );
begin
    F_Id := pId;
    F_DataHora := pDataHora;
    F_Bomba_Id := pBomba_Id;
    F_Litros := pLitros;
    F_ValorPorLitro := pValorPorLitro;
    F_ValorParcial := pValorParcial;
    F_PercentualImposto := pPercentualImposto;
    F_ValorImposto := pValorImposto;
    F_ValorTotal := pValorTotal;
end;


constructor T_Abastecimento.Create(); 
begin

end;


procedure T_Abastecimento.Totalizar();
begin
    try
        F_ValorParcial := F_Litros * F_ValorPorLitro;
        F_ValorImposto := (F_PercentualImposto / 100) * F_ValorParcial;
        F_ValorTotal := F_ValorParcial + F_ValorImposto;
    except
    end;
end;

procedure T_Abastecimento.setDataHora(pDataHora: TDateTime);
begin
    F_DataHora := pDataHora;
end;

function T_Abastecimento.getDataHora(): TDateTime;
begin
    result := F_DataHora;
end;

// F_Litros
procedure T_Abastecimento.setLitros(pLitros: Double);
begin
    F_Litros := pLitros;
    Totalizar();
end;

function T_Abastecimento.getLitros(): Double;
begin
    result := F_Litros;
end;

// F_ValorPorLitro
procedure T_Abastecimento.setValorPorLitro(pValor: Double);
begin
    F_ValorPorLitro := pValor;
    Totalizar();
end;

function T_Abastecimento.getValorPorLitro(): Double;
begin
    result := F_ValorPorLitro;
end;

// F_ValorParcial
procedure T_Abastecimento.serValorParcial(pValor: Double);
begin
    F_ValorParcial := pValor;
end;

function T_Abastecimento.getValorParcial(): Double;
begin
    result := F_ValorParcial;
end;

// F_PercentualImposto
procedure T_Abastecimento.setPercentualImposto(pPercentual: Double);
begin
    F_PercentualImposto := pPercentual;
    Totalizar();
end;

function T_Abastecimento.getPercentualImposto(): Double;
begin
    result := F_PercentualImposto;
end;

// F_ValorImposto
function T_Abastecimento.getValorImposto(): Double;
begin
    result := F_ValorImposto;
end;

// F_ValorTotal
function T_Abastecimento.getValorTotal(): Double;
begin
    result := F_ValorTotal;
end;


end.
