program ControleAbastecimentos_DUnit;

uses
  Forms,
  GUITestRunner in 'dunit-9.3.0\src\GUITestRunner.pas' {GUITestRunner},
  TestFramework in 'dunit-9.3.0\src\TestFramework.pas',
  fmMain in '..\fmMain.pas' {_fmMain},
  dm in '..\connection\dm.pas' {_dm: TDataModule},
  abastecimento in '..\model\abastecimento.pas',
  bomba in '..\model\bomba.pas',
  configuracao in '..\model\configuracao.pas',
  entrada in '..\model\entrada.pas',
  tanque in '..\model\tanque.pas',
  tipocombustivel in '..\model\tipocombustivel.pas',
  abastecimentoDao in '..\dao\abastecimentoDao.pas',
  tipoCombustivelDao in '..\dao\tipoCombustivelDao.pas',
  constantes in '..\control\constantes.pas',
  tipoCombustivelDao_DUnit in 'Units\tipoCombustivelDao_DUnit.pas';

{$R *.res}

begin
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(T_dm, _dm);
    Application.CreateForm(T_fmMain, _fmMain);
    GUITestRunner.runRegisteredTests;
end.
