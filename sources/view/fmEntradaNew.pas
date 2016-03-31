unit fmEntradaNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask;

type
  T_fmEntradaNew = class(TForm)
    Label5: TLabel;
    cbTanques: TComboBox;
    Label1: TLabel;
    edLitros: TMaskEdit;
    Label2: TLabel;
    edValorPorLitro: TMaskEdit;
    Label3: TLabel;
    edValorAPagar: TMaskEdit;
    btnSalvar: TButton;
    btnNovo: TButton;
    Label4: TLabel;
    edLitragem: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbTanquesChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _fmEntradaNew: T_fmEntradaNew;

implementation

{$R *.dfm}

uses
    dm, entradaDao, tanqueDao, tipoCombustivelDao,
    entrada, tanque, tipocombustivel, entradaController;


var
    entradaDao: T_EntradaDao;
    tanqueDao: T_TanqueDao;
    tipoCombustivelDao: T_TipoCombustivelDao;
    ventrada: T_Entrada;
    vtanque: T_Tanque;
    vtipocombustivel: T_TipoCombustivel;
    ventradaController: T_EntradaController;


procedure T_fmEntradaNew.btnNovoClick(Sender: TObject);
begin
    edLitros.text := '0';
    edValorPorLitro.text := '0';
    edValorAPagar.text := '0';

    edLitros.Enabled := true;
    edValorPorLitro.Enabled := true;
    edValorAPagar.Enabled := true;

    btnNovo.Enabled := False;
    btnSalvar.Enabled := True;
end;

procedure T_fmEntradaNew.btnSalvarClick(Sender: TObject);
var
    status: String;
begin
    try
        ventrada.Tanque_Id := vtanque.Id;
        ventrada.Litros := StrToInt(edLitros.text);
        ventrada.ValorPorLitro := StrToFloat(edValorPorLitro.Text);
        edValorAPagar.Text := FloatToStr(ventrada.ValorDaEntrada);
        ventrada.DataHora := Now();

        ventradaController := T_EntradaController.Create(
            dm._dm.IBDataBase1,
            ventrada,
            vtanque.Id);
        if not ventradaController.efetuarEntrada(status) then
        begin
            MessageDlg(status, mtWarning, [mbOK], 0);
        end
        else
        begin
            MessageDlg('Entrada efetuada.', mtInformation, [mbOK], 0);
        end;

        edLitros.Enabled := false;
        edValorPorLitro.Enabled := false;
        edValorAPagar.Enabled := False;
        btnNovo.Enabled := true;
        btnSalvar.Enabled := false;

    except
        on e: Exception do
        begin
            MessageDlg('Erro em alguma das entradas.'#13#10 + e.Message, mtError, [mbOk], 0);
        end;

    end;
end;

procedure T_fmEntradaNew.cbTanquesChange(Sender: TObject);
begin
    try
        vtanque := tanqueDao.Get(StrToInt(cbTanques.Text));
        vtipocombustivel := tipoCombustivelDao.get(vtanque.TipoCombustivel_Id);
        edLitragem.Text := FloatToStr(vtanque.Quantidade_Litros);
    except
    end;
end;

procedure T_fmEntradaNew.FormCreate(Sender: TObject);
var
    i: Integer;
    list: TList;
begin
    tanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    entradaDao := T_EntradaDao.Create(dm._dm.IBDataBase1);
    tipoCombustivelDao := T_TipoCombustivelDao.Create(dm._dm.IBDataBase1);


    vtanque := T_Tanque.Create();
    ventrada := T_Entrada.Create();
    vtipocombustivel := T_TipoCombustivel.Create();

    cbTanques.Items.Clear;
    list := tanqueDao.listarTudo();
    for i := 0 to list.Count -1 do
    begin
        cbTanques.Items.Add(IntToStr(T_Tanque(list.Items[i]).Id));
    end;
    cbTanques.ItemIndex := 0;
    if list.Count > 0 then
    begin
        vtanque := tanqueDao.Get(StrToInt(cbTanques.Text));
        vtipocombustivel := tipoCombustivelDao.get(vtanque.TipoCombustivel_Id);
        edLitragem.Text := FloatToStr(vtanque.Quantidade_Litros);        
    end;
end;

end.
