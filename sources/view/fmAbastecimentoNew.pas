unit fmAbastecimentoNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask;

type
  T_fmAbastecimentoNew = class(TForm)
    edLitros: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edValorPorLitro: TEdit;
    edAliquota: TEdit;
    edValorAPagar: TEdit;
    btnSalvar: TButton;
    cbBombas: TComboBox;
    Label5: TLabel;
    btnNovo: TButton;
    Label6: TLabel;
    edCombustivel: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbBombasChange(Sender: TObject);
    procedure edLitrosChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _fmAbastecimentoNew: T_fmAbastecimentoNew;

implementation

{$R *.dfm}

uses
    dm, abastecimentoDao, tipoCombustivelDao, bombaDao, tanqueDao,
    abastecimento, bomba, tipocombustivel, tanque;


var
    abastecimentoDao: T_AbastecimentoDao;
    tanqueDao: T_TanqueDao;
    bombaDao: T_BombaDao;
    tipoCombustivelDao: T_TipoCombustivelDao;
    abastecimento: T_Abastecimento;

    bomba: T_Bomba;
    tanque: T_Tanque;
    tipoCombustivel: T_TipoCombustivel;

procedure T_fmAbastecimentoNew.btnNovoClick(Sender: TObject);
begin
    abastecimento.Litros := 0;
    edLitros.text := '0.000';
    edLitros.Enabled := True;
    btnNovo.Enabled := False;
    btnSalvar.Enabled := True;
end;

procedure T_fmAbastecimentoNew.btnSalvarClick(Sender: TObject);
begin
    if abastecimento.Litros > 0 then
    begin
        abastecimentoDao.incluir(abastecimento);
        ShowMessage('Abastecimento realizado!');
        edLitros.Enabled := False;
        btnNovo.Enabled := true;
        btnSalvar.Enabled := false;
    end
    else
        MessageDlg('Informe a quantidade de litros do abastecimento.', mtWarning, [mbOk], 0);
end;

procedure T_fmAbastecimentoNew.cbBombasChange(Sender: TObject);
var
    numero: Integer;
    litros: String;
begin
    numero := StrToInt(cbBombas.Text);
    bomba := bombaDao.getByNumero(numero);
    tanque := tanqueDao.get(bomba.Tanque_Id);
    tipocombustivel := tipoCombustivelDao.get(tanque.TipoCombustivel_Id);
    edValorPorLitro.Text := Format('%m', [tipoCombustivel.ValorPorLitro]);
    edAliquota.Text := Format('%0.2f', [tipocombustivel.PercentualDeImposto]) + '%';
    edCombustivel.Text := tipoCombustivel.Nome;
    abastecimento := T_Abastecimento.Create();
    abastecimento.setDataHora(Now());
    abastecimento.setValorPorLitro(tipocombustivel.ValorPorLitro);
    abastecimento.setPercentualImposto(tipocombustivel.PercentualDeImposto);
    abastecimento.Bomba_ID := bomba.Id;

    litros := edLitros.Text;
    litros := StringReplace(litros, '_', '0', [rfReplaceAll]);
    litros := StringReplace(litros, '.', ',', [rfReplaceAll]);

    abastecimento.setLitros(StrToFloat(litros));
    edValorAPagar.Text := Format('%m', [abastecimento.ValorTotal]);
end;

procedure T_fmAbastecimentoNew.edLitrosChange(Sender: TObject);
var
    litros: String;
begin
    litros := edLitros.Text;
    litros := StringReplace(litros, '_', '0', [rfReplaceAll]);
    litros := StringReplace(litros, '.', ',', [rfReplaceAll]);
    abastecimento.setLitros(StrToFloat(litros));
    edValorAPagar.Text := Format('%m', [abastecimento.ValorTotal]);
end;

procedure T_fmAbastecimentoNew.FormCreate(Sender: TObject);
var
    i: Integer;
    list: TList;
begin
    abastecimento := T_Abastecimento.Create();
    abastecimentoDao := T_AbastecimentoDao.Create(dm._dm.IBDataBase1);
    tanqueDao := T_TanqueDao.Create(dm._dm.IBDataBase1);
    bombaDao := T_BombaDao.Create(dm._dm.IBDataBase1);
    tipoCombustivelDao := T_TipoCombustivelDao.Create(dm._dm.IBDataBase1);

    cbBombas.Items.Clear;
    list := bombaDao.listarTudo();
    for i := 0 to list.Count -1 do
    begin
        cbBombas.Items.Add(IntToStr(T_Bomba(list.Items[i]).Numero));
    end;
end;

end.
