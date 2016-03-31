unit tipocombustivel;

interface

type
    T_TipoCombustivel = class(TObject)
        private
            F_Id: Integer;
            F_Nome: String;
            F_ValorPorLitro: Double;
            F_PercentualDeImposto: Double;
            // F_Id
            procedure setId(pId: Integer);
            function getId(): Integer;
            // F_Nome
            procedure setNome(pNome: String);
            function getNome(): String;
            // F_ValorPorLitro
            procedure setValorPorLitro(pValorPorLitro: Double);
            function getValorPorLitro(): Double;
            // F_PercentualDeImposto
            procedure setPercentualDeImposto(pPercentualDeImposto: Double);
            function getPercentualDeImposto(): Double;
        public
            constructor Create(
                pId: Integer;
                pNome: String;
                pValorPorLitro: Double;
                pPercentualDeImposto: Double
            ); overload;

            constructor Create(); overload;
        published
            property Id: Integer read getId write setId;
            property Nome: String read getNome write setNome;
            property ValorPorLitro: Double read getValorPorLitro write setValorPorLitro;
            property PercentualDeImposto: Double read getPercentualDeImposto write setPercentualDeImposto;
    end;

implementation

constructor T_TipoCombustivel.Create(
        pId: Integer;
        pNome: String;
        pValorPorLitro: Double;
        pPercentualDeImposto: Double
    );
begin
    F_Id := pId;
    F_Nome := pNome;
    F_ValorPorLitro := pValorPorLitro;
    F_PercentualDeImposto := pPercentualDeImposto;
end;


constructor T_TipoCombustivel.Create();
begin
//
end;

// F_Id
procedure T_TipoCombustivel.setId(pId: Integer);
begin
    F_Id := pId;
end;

function T_TipoCombustivel.getId(): Integer;
begin
    result := F_Id;
end;

// F_Nome
procedure T_TipoCombustivel.setNome(pNome: String);
begin
    F_Nome := pNome;
end;

function T_TipoCombustivel.getNome(): String;
begin
    result := F_Nome;
end;

// F_ValorPorLitro
procedure T_TipoCombustivel.setValorPorLitro(pValorPorLitro: Double);
begin
    F_ValorPorLitro := pValorPorLitro;
end;

function T_TipoCombustivel.getValorPorLitro(): Double;
begin
    result := F_ValorPorLitro;
end;

// F_PercentualDeImposto
procedure T_TipoCombustivel.setPercentualDeImposto(pPercentualDeImposto: Double);
begin
    F_PercentualDeImposto := pPercentualDeImposto;
end;

function T_TipoCombustivel.getPercentualDeImposto(): Double;
begin
    result := F_PercentualDeImposto;
end;



end.

