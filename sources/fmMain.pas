unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  T_fmMain = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Configuraes1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Cadastros1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Ajuda1: TMenuItem;
    anques1: TMenuItem;
    Bombas1: TMenuItem;
    Entradas1: TMenuItem;
    Abastecimentos1: TMenuItem;
    Abastecimentos2: TMenuItem;
    Entradas2: TMenuItem;
    PorPerodo1: TMenuItem;
    PorPerodo2: TMenuItem;
    SobreoSistema1: TMenuItem;
    Listar1: TMenuItem;
    Novo1: TMenuItem;
    procedure Listar1Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure anques1Click(Sender: TObject);
    procedure PorPerodo1Click(Sender: TObject);
    procedure Bombas1Click(Sender: TObject);
    procedure Configuraes1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure PorPerodo2Click(Sender: TObject);
    procedure SobreoSistema1Click(Sender: TObject);
    procedure Entradas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _fmMain: T_fmMain;

implementation

{$R *.dfm}

uses
    fmAbastecimentosList, fmAbastecimentoNew, fmTanquesList, fmBombasList,
    rptAbastecimentosPorPeriodo, fmFiltroPeriodo, fmEntradaNew;

procedure T_fmMain.anques1Click(Sender: TObject);
begin
    with T_fmTanquesList.Create(Self) do
    try
        ShowModal();
    finally
        Free();
    end;
end;

procedure T_fmMain.Bombas1Click(Sender: TObject);
begin
    with T_fmBombasList.Create(Self) do
    try
        ShowModal();
    finally
        Free();
    end;
end;

procedure T_fmMain.Configuraes1Click(Sender: TObject);
begin
    MessageDlg('Em desenvolvimento!', mtWarning, [mbOk], 0);
end;

procedure T_fmMain.Entradas1Click(Sender: TObject);
begin
    with T_fmEntradaNew.Create(Self) do
    try
        ShowModal();
    finally
        Free();
    end;
end;

procedure T_fmMain.Listar1Click(Sender: TObject);
begin
    with T_fmAbastecimentosList.Create(Self) do
    try
        ShowModal();
    finally
        Free();
    end;
end;

procedure T_fmMain.Novo1Click(Sender: TObject);
begin
    with T_fmAbastecimentoNew.Create(Self) do
    try
        ShowModal();
    finally
        Free();
    end;
end;

procedure T_fmMain.PorPerodo1Click(Sender: TObject);
var
    exibir: boolean;
begin
    exibir := false;
    with T_fmFiltroPeriodo.Create(Self) do
    try
        ShowModal();
        if ModalResult = mrOk then
        begin
            exibir := True;
        end;
    finally
        Free();
    end;

    if exibir then
    begin
        with _rptAbastecimentosPorPeriodo do
        try
            qrAbastecimento.Active := false;
            qrAbastecimento.ParamByName('de').Value := fmFiltroPeriodo.getDe();
            qrAbastecimento.ParamByName('ate').Value := fmFiltroPeriodo.getAte();
            qrAbastecimento.Prepare();
            qrAbastecimento.Open();

            lbDe.Caption := DateToStr(fmFiltroPeriodo.getDe());
            lbAte.Caption := DateTimeToStr(fmFiltroPeriodo.getAte());

            RLReport1.Preview(nil);
        finally
        end;
    end;
end;

procedure T_fmMain.PorPerodo2Click(Sender: TObject);
begin
    MessageDlg('Em desenvolvimento!', mtWarning, [mbOk], 0);
end;

procedure T_fmMain.Sair1Click(Sender: TObject);
begin
    Application.Terminate();
end;

procedure T_fmMain.SobreoSistema1Click(Sender: TObject);
begin
    MessageDlg(
        'CONTROLE DE ABASTECIMENTOS'#13#10
        + ''#13#10
        + 'Versão: 1.1'#13#10
        + 'Todos os direitos reservados à Fortes Informática.'
        , mtInformation, [mbOk], 0);
end;

initialization


    // Definir formato de data, hora e moeda para o Brasil
    SysUtils.CurrencyString := 'R$';
    SysUtils.CurrencyFormat := 2;
    SysUtils.NegCurrFormat := 9;
    SysUtils.ThousandSeparator := '.';
    SysUtils.DecimalSeparator := ',';
    SysUtils.CurrencyDecimals := 2;
    SysUtils.DateSeparator := '/';
    SysUtils.ShortDateFormat := 'dd/mm/yyyy';
    SysUtils.LongDateFormat := 'dddd, d'' de ''MMMM'' de ''yyyy';
    SysUtils.TimeSeparator := ':';
    SysUtils.TimeAMString := 'AM';
    SysUtils.TimePMString := 'PM';
    SysUtils.ShortTimeFormat := 'hh:mm';
    SysUtils.LongTimeFormat := 'hh:mm:ss';
    SysUtils.ListSeparator := ';';

end.
