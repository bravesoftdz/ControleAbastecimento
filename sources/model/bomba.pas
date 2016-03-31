unit bomba;

interface

uses
    SysUtils, DateUtils;

type
    T_Bomba = class(TObject)
        private
            F_Id: Integer;
            F_Tanque_Id: Integer;
            F_Numero: Integer;
            // F_Id
            function getId(): Integer;
            procedure setId(pId: Integer);
            // F_Tanque_Id
            function getTanque_Id(): Integer;
            procedure setTanque_Id(pTanque_Id: Integer);
            // F_Numero
            function getNumero(): Integer;
            procedure setNumero(pNumero: Integer);
        public
            constructor Create(
                pId: Integer;
                pTanque_Id: Integer;
                pNumero: Integer); overload;
            constructor Create(); overload;
        published
            property Id: Integer read getId write setId;
            property Tanque_Id: Integer read getTanque_Id write setTanque_Id;
            property Numero: Integer read getNumero write setNumero;
    end;

implementation


constructor T_Bomba.Create(
    pId: Integer;
    pTanque_Id: Integer;
    pNumero: Integer);
begin
    F_Id := pId;
    F_Tanque_Id := pTanque_Id;
    F_Numero := pNumero;
end;


constructor T_Bomba.Create();
begin

end;

function T_Bomba.getId(): Integer;
begin
    result := F_Id;
end;

procedure T_Bomba.setId(pId: Integer);
begin
    F_Id := pId;
end;

// F_Tanque_Id
function T_Bomba.getTanque_Id(): Integer;
begin
    result := F_Tanque_Id;
end;

procedure T_Bomba.setTanque_Id(pTanque_Id: Integer);
begin
    F_Tanque_Id := pTanque_Id;
end;

// F_Numero
function T_Bomba.getNumero(): Integer;
begin
    result := F_Numero;
end;

procedure T_Bomba.setNumero(pNumero: Integer);
begin
    F_Numero := pNumero;
end;



end.
