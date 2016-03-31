unit dm;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery;

type
  T_dm = class(TDataModule)
    IBDataBase1: TIBDatabase;
    qrAbastecimento: TIBQuery;
    dsAbastecimento: TDataSource;
    qrBomba: TIBQuery;
    qrConfiguracao: TIBQuery;
    qrEntrada: TIBQuery;
    qrTanque: TIBQuery;
    dsBomba: TDataSource;
    dsConfiguracao: TDataSource;
    dsEntrada: TDataSource;
    dsTanque: TDataSource;
    IBTransaction1: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _dm: T_dm;

implementation

{$R *.dfm}

uses
    Forms, Dialogs;

procedure T_dm.DataModuleCreate(Sender: TObject);
begin
    if FileExists(ExtractFilePath(Application.ExeName) + 'POSTO.GDB') then
    begin
        IBDataBase1.DatabaseName := ExtractFilePath(Application.ExeName) + 'POSTO.GDB';
        IBDataBase1.Params.Clear();
        with IBDataBase1.Params do
        begin
            Add('user_name=sysdba');
            Add('password=masterkey');
            Add('lc_ctype=UTF-8');
        end;
        try
        IBDataBase1.Open();
        except
            if not IBDataBase1.Connected then
            begin
                MessageDlg('Problemas para conseguir estabelecer conexão com o banco.', mtError, [mbOk], 0);
                Application.Terminate();
            end;
        end;
    end;
end;

end.
