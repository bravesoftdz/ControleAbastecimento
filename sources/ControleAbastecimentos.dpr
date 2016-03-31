program ControleAbastecimentos;

uses
  Forms,
  fmMain in 'fmMain.pas' {_fmMain},
  bomba in 'model\bomba.pas',
  tanque in 'model\tanque.pas',
  abastecimento in 'model\abastecimento.pas',
  entrada in 'model\entrada.pas',
  configuracao in 'model\configuracao.pas',
  dm in 'connection\dm.pas' {_dm: TDataModule},
  abastecimentoDao in 'dao\abastecimentoDao.pas',
  constantes in 'control\constantes.pas',
  tipocombustivel in 'model\tipocombustivel.pas',
  tipoCombustivelDao in 'dao\tipoCombustivelDao.pas',
  fmAbastecimentosList in 'view\fmAbastecimentosList.pas' {_fmAbastecimentosList},
  fmTipoCombustivelList in 'view\fmTipoCombustivelList.pas' {_fmTipoCombustivelList},
  fmAbastecimentoNew in 'view\fmAbastecimentoNew.pas' {_fmAbastecimentoNew},
  bombaDao in 'dao\bombaDao.pas',
  tanqueDao in 'dao\tanqueDao.pas',
  fmTanquesList in 'view\fmTanquesList.pas' {_fmTanquesList},
  rptAbastecimentosPorPeriodo in 'reports\rptAbastecimentosPorPeriodo.pas' {_rptAbastecimentosPorPeriodo},
  fmFiltroPeriodo in 'reports\fmFiltroPeriodo.pas' {_fmFiltroPeriodo},
  fmBombasList in 'view\fmBombasList.pas' {_fmBombasList},
  entradaController in 'control\entradaController.pas',
  entradaDao in 'dao\entradaDao.pas',
  fmEntradaNew in 'view\fmEntradaNew.pas' {_fmEntradaNew};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Controle de Abastecimentos';
  Application.CreateForm(T_dm, _dm);
  Application.CreateForm(T_fmMain, _fmMain);
  // reports
  Application.CreateForm(T_rptAbastecimentosPorPeriodo, _rptAbastecimentosPorPeriodo);
  Application.CreateForm(T_fmFiltroPeriodo, _fmFiltroPeriodo);
  Application.Run;
end.
