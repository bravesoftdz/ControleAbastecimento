unit rptAbastecimentosPorPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, Dm, IBCustomDataSet, IBQuery, IBDatabase, Grids,
  DBGrids;

type
  T_rptAbastecimentosPorPeriodo = class(TForm)
    RLReport1: TRLReport;
    DataSource1: TDataSource;
    qrAbastecimento: TIBQuery;
    IBTransaction1: TIBTransaction;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    C: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    lbDe: TRLLabel;
    RLLabel9: TRLLabel;
    lbAte: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLLabel8: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _rptAbastecimentosPorPeriodo: T_rptAbastecimentosPorPeriodo;

implementation

{$R *.dfm}

var
    vDb: TIBDatabase;


end.
