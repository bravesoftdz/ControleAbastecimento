unit tipoCombustivelDao_DUnit;

interface

uses
    Forms, IBDataBase, IBCustomDataSet, dm, TestFrameWork, TipoCombustivelDao,
    AbastecimentoDao, Abastecimento, Classes, SysUtils;

type
    T_TipoCombustivelDao_Tester = class(TTestCase)
        protected
            db: TIBDataBase;
            tr: TIBTransaction;
            procedure SetUp(); override;
            procedure TearDown(); override;
        published
            procedure TipoCombustivel_listAll();
            procedure Abastecimento_Incluir();
    end;

implementation

procedure T_TipoCombustivelDao_Tester.SetUp();
begin
    inherited;
    // Configurando uma conexão com o banco de dados
    db := TIBDatabase.Create(nil);
    tr := TIBTransaction.Create(nil);
    db.DefaultTransaction := tr;
    db.DatabaseName := ExtractFilePath(Application.ExeName) + '..\POSTO.GDB';
    db.Params.Add('user_name=sysdba');
    db.Params.Add('password=masterkey');
    db.Params.Add('lc_ctype=UTF-8');
    db.LoginPrompt := False;
    db.AllowStreamedConnected := False;
    db.Connected := True;
end;

procedure T_TipoCombustivelDao_Tester.TearDown();
begin
    inherited;
    db.Close();
    db.Free();
end;



procedure T_TipoCombustivelDao_Tester.TipoCombustivel_listAll();
var
    dao: T_TipoCombustivelDao;
    lista: TList;
begin
    dao := T_TipoCombustivelDao.Create(db);
    lista := dao.listarTudo;
    check(lista.Count > 0, 'Tipos de combustível: ' + IntToStr(lista.Count));
end;

procedure T_TipoCombustivelDao_Tester.Abastecimento_Incluir();
var
    dao: T_AbastecimentoDao;
    abastecimento: T_Abastecimento;
    lista: TList;
begin
    dao := T_AbastecimentoDao.Create(db);
    abastecimento := T_Abastecimento.Create(now, 1, 23, 3.989, 13);
    dao.incluir(abastecimento);
    lista := dao.listarTudo();
    check(lista.Count > 0, 'Não há dados inclusos ' + IntToStr(lista.Count));
end;


initialization

    TestFramework.RegisterTest(T_TipoCombustivelDao_Tester.Suite);

end.
