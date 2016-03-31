unit funcoes2;

interface

uses
	Forms, Dialogs, DBCtrls, Windows,  SysUtils,  Graphics,
	DB, StdCtrls, Classes, Messages, WinTypes, ExtCtrls, Buttons,
	Mask, ComCtrls, Controls, Math, IniFiles, TypInfo,
	ADODB, Shellapi, Variants, MaskUtils, UrlMon, Consts, ComObj,
    StrUtils, fmDataDlg, fmPeriodoDlg, fmLoginDlg, DateUtils,
    TLHelp32, PsAPI, ScktComp, WinSock, WinInet, CPortCtl, CPort;


type

    TDinArrayStr = Array of String;
    TDinArrayBytes = Array of Byte;

    THtmlCodeRec = record
        Ch: Word;
        Html: string;
    end;

	TUser = record
			ID: Integer;
			Name: string;
			Password: string;
			Groups: array [0..7] of Integer;
			ToConnectionName: string;
			ToConnectionPassword: string;
		end;

	TBasicRecInfo = record
			Codigo: Integer;
			Descricao: string;
			Tag: Currency;
		end;

	TABasicRecInfo = array of TBasicRecInfo;

	TAppInfo = record
			ComputerName: string;
			CompanyName: string;
			CompanyID: string;
			Licence_Name: string;
			Licence_Company: string;
			LegalCopyright: string;
			ProductName: string;
			ProductVersion: string;
			Author: string;
			Company: string;
			RegistryPath: string;
			DataBaseDriver: Word;
			NetFileDir: string;
			ADOConnection: TADOConnection;
			ADOConnectionTemp: TADOConnection;
			ConnectionTempDataSource: string;
			TempDir: string;
			User: TUser;
			Nome, Endereco, Bairro, Cidade, UF, CNPJ,
			IE, CEP, EMail, Telefones: string;
			Connected: Boolean;
            Tentativas: Integer;
		end;

const
	PROC_INCLUIR = 1;
	PROC_EDITAR  = 2;
	PROC_EXCLUIR = 3;
	PROC_VISUAL  = 4;
    PANTERA_KEY = '12371233144';
    KEY_CONFIG_SECURE = '15782135878957223475615695412';

type
	TSetBytes = set of 0..$FF;

type
	TFilterChars = set of Char;

function GetDeskTopPath(frmHandle: HWND): string;
function fnGetPathTemp(): String;
function fnQrNew(conn: TAdoConnection; sql: String; const AutoOpen: boolean = false): TAdoQuery;
function sqlExec(conn: TAdoConnection; sql: String): boolean;
function RandomName: string;
function DownloadFile(Source, Dest: string): String;
function DownloadFile2(const fileURL, FileName: String): boolean;
function DownloadText(const aUrl: string; var resposta: boolean): String;
function TColorToStringRGB(Color : TColor) : string;
function StringRGBToTColor(sColor : string) : TColor;
function MMToPixelVert(mm: Integer): Integer;
function PixelVertToMM(PixelY: Integer): Integer;
function MMToPixelHoriz(mm: Integer): Integer;
function PixelHorizToMM(PixelX: Integer): Integer;
function FindFiles(const Path, Mask: string; IncludeSubDir: boolean): TStrings;
procedure CreateChildForm(Application: TApplication; FormClass: TFormClass; var Reference);
function ReadSystemConfig2(Grupo, Secao, Padrao: String): String;
function fnNameRandom(Ext: String):string;
function fnReadConfig(grupo, nome: string): string;
function ReadSystemArq(grupo, nome, default: string): string;
procedure WriteSystemArq(grupo, nome, value: String);
function ExistsSystemArq(grupo, nome: String): boolean;
function fnReadConfig2(grupo, nome, valorpadrao: string): string;
procedure GravarRegistro(chave,valor:string);
function LerRegistro(chave:string):string;
procedure ExcluirRegistro(chave:string);
procedure MsgErr(Msg: String);
function WindowsDir: String;
function WindowsDrive: String;
function WindowsFontsDir: String;
function WinTempDir: String;
function DataFilesDir: String;
function WinSystemDir: String;
function ReportsPath: String;
function fnGetStrConnect: String;
function fnGetPathReports: String;
procedure prExecuteSQL(con: TAdoConnection; cmd: String);
function fnQrLookUpValue(con: TAdoConnection; select, field: String): Variant;
procedure CreateShortcut (FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
function fDataYYYYMMDD(data: TDate): String;
function fHoraHHMM(hora: TTime): String;
function Confirma(const Msg: string): Boolean;
function Questao(const Msg: string): Word;
procedure Mensagem(const Msg: string);
procedure Alerta(const Msg: string);
procedure Erro(const Msg: string);
procedure MyRaiseException(const Msg: string);
function StrTrans(const S: string; Search, Replace: Char): string;
function FilteredChars(const S: string; FFilterChars: TFilterChars): string;
function MyEndereco(const Logradouro, Numero, Complemento: Variant): string;
function MyCEP(const CEP: Variant): string;
function MyRound(const X: Extended; Decimals: Integer = -1): Extended;
function MyTrunc(const X: Extended; Decimals: Integer = -1): Extended;
function IIfStr(const K: Boolean; X, Y: string): string;
function IIfInt(const K: Boolean; X, Y: Integer): Integer;
function IIfExt(const K: Boolean; X, Y: Extended): Extended;
function IIf(const K: Boolean; X, Y: Variant): Variant;
function StrBegins(str, beginStr: String; const caseSensitive: boolean = false): boolean;
function StrMatch(strA, strB: String; const caseSensitive: boolean = false): boolean;
function Switch(cases: Array of Boolean; values: Array of Variant; default: Variant): Variant;
function Day(const FDate: TDateTime): Word;
function Month(const FDate: TDateTime): Word;
function Year(const FDate: TDateTime): Word;
function BetWeen(const Z, X, Y: Variant): Boolean;
function BetWeenInt(const Z, X, Y: Integer): Boolean;
function BetweenDouble(a, b, c: double): Boolean;
function MyLeft(const S: string; Count: Integer): string;
function MyRight(const S: string; Count: Integer): string;
function MySubs(S: string; Index: Integer; Count: Integer = -1): string;
procedure MyDelete(var S: string; Index, Count: Integer);
function Pad(const S: string; Count: Integer; Preenc: Char; taTipo: TAlignment): string;
function PadL(const S: string; Count: Integer; Preenc: Char = ' '): string;
function PadC(const S: string; Count: Integer; Preenc: Char = ' '): string;
function PadR(const S: string; Count: Integer; Preenc: Char = ' '): string;
function Space(Count: Integer = 1): string;
function Repl(const S: string; Count: Integer): string;
function MyFormatFloat(const Value: Extended; IsCurrency: Boolean = False): string;
function MyFormatFloat2(const Value: Extended; Decimals: Byte = 2): string;
function MyFormatInt(const Value: Extended): string;
function MyFormatDateTime(const Value: TDateTime): string;
function MyShortDayName(const FDayOfWeek: Word): string;
function PlainText(const S: string; KillControlChars: Boolean = True): string;
function ArqSis(const S: string): string;
function RetWindowsDir: string;
function BeginOfYear(FDate: TDateTime = 0.00): TDateTime;
function EndOfYear(FDate: TDateTime = 0.00): TDateTime;
function BeginOfMonth(FDate: TDateTime = 0.00): TDateTime;
function EndOfMonth(FDate: TDateTime = 0.00): TDateTime;
function BeginOfWeek(FDate: TDateTime = 0.00): TDateTime;
function EndOfWeek(FDate: TDateTime = 0.00): TDateTime;
function BeginOfDay(FDate: TDateTime = 0.00): TDateTime;
function EndOfDay(FDate: TDateTime = 0.00): TDateTime;
function CutMilliSeconds(DateTime: TDateTime): TDateTime;
function AmaciaPeriodo(DataInicial, DataFinal: TDateTime): string;
function ArqTemp(Ext: string = '___'): string;
function TemporaryDir: string;
function IntToStrZero(const Value: Extended; Digits: Integer): string;
function VarAsString(const V: Variant): string;
function VarAsChar(const V: Variant): Char;
function VarAsInteger(const V: Variant): Integer;
function VarAsFloat(const V: Variant): Double;
function VarAsCurrency(const V: Variant): Currency;
function VarAsDateTime(const V: Variant): TDateTime;
function VarAsBoolean(const V: Variant): Boolean;
function VarIfNull(const Compare, ResultIfNull: Variant): Variant;
function NullIfVar(const Compare, Compare2: Variant): Variant;
function VArAdd(const A, V: Variant): Variant;
function NullInVar(const V: Variant): Boolean;
function CompareVar(V1, V2: Variant): Boolean;
function NullIfEmptyValue(V: Variant; varType: Integer): Variant;
function InSet(V: Variant; ArVar: array of Variant): Boolean;
function VArScan(A, V: Variant): Integer;
function ReadSystemConfig(const Section, Ident: string; Default: Variant): Variant;
procedure WriteSystemConfig(const Section, Ident: string; Value: Variant);
function ReadIniFile(const IniFileName, Section, Ident: string; Default: Variant): Variant;
procedure WriteIniFile(const IniFileName, Section, Ident: string; Default: Variant);
procedure ReadIniFileSection(const IniFileName, Section: string; Strings: TStrings);
procedure ReadSTCSectionItems(const Section: string; FStrings: TStrings);
procedure ReadSTCSectionValues(const Section: string; FStrings: TStrings);
procedure ReadSTCSection(const Section: string; FStrings: TStrings);
function ReadConfig(const Section, Ident: string; Default: Variant): Variant;
procedure WriteConfig(const Section, Ident: string; Value: Variant);
function StringPart(const S: string; DelimChar: Char; Pos: Integer): string;
function StringPartCount(const S: string; DelimChar: Char): Integer;
function StringPartPos(const S: string; DelimChar: Char; Subs: string): Integer;
function Extenso(Valor: Currency; const MoedaSing: String = 'Real'; const MoedaPlural: String = 'Reais'; const CentSing: String = 'Centavo'; const CentPlural: String = 'Centavos'): string;
function ExtensoDeGrana(const Valor: Currency): string;
function ExtToTransNum(const N: Extended; Count: Integer): string;
function StrToTransStr(const S: string; Count: Integer): string;
function DateToTransDate(const D: TDateTime): string;
function DateToTransDate2(const D: TDateTime): string;
function DateToTransDateMask(const D: TDateTime; Mask: string): string;
function TransNumToCurr(S: string): Currency;
function TransNumToInt(S: string): Integer;
function TransStrToStr(const S: string): string;
function TransDateToDateTime(S: string): TDateTime;
function TransDate2ToDateTime(S: string): TDateTime;
function TransDateDDMMAAAAToDateTime(S: string): TDateTime;
function DV11(Num: Variant): Byte;
function MyCutTime(ADate: TDateTime): TDateTime;
function ForceTime(ADate: TDateTime; BeginOfDay: Boolean): TDateTime;
function ComDateTimeToStr(const DateTime: TDateTime): string;
function ComStrToDateTime(const DateTime: string): TDateTime;
function MyLikeText(const S1, S2: string): Boolean;
function MyCompareText(const S1, S2: string): Boolean;
function IncludeInVarArray(V, InclVar: Variant): Variant;
function IsNullDef(V, DefaultValue: Variant): Variant;
procedure EditText(const S: string; IsFile: Boolean = False);
function ConcordaEmNumero(N: Extended; S, Singular: string; Plural: string = ''): string;
function ConcordaEmGenero(Gen: Byte; Masculino, Feminino: string): string;
procedure MyConcat(var S: string; const Subs: string);
function InvertString(S: string): string;
procedure MySetPropValue(const Objects: array of TObject; const PropName: string; const PropValue: Variant);
function ParamValue(Params: TStringList; Param: string; VarType: Integer; Default: string = ''): Variant;
procedure MyAssert(Condition: Boolean; ErrorMessage: string = 'Erro de execução não reconhecido.' + #10 + 'Contate o suporte.');
procedure SaveText(TheText, FileName: string);
procedure Nunca(Msg: string = '');
function SubSet(Values, Items: array of const; Value: Variant): Variant;
function IncludeByteSet(ByteSubSet, ByteSet: Byte): Byte;
function DiferencaIrrisoria(Diff: Double): Boolean;
function Nomenclatura(S: string): string;
function IsEmptyStr(S: string): Boolean;
function VarZeroValue(VarType: Integer): Variant;
function VarConvert(V: Variant; VarType: Integer): Variant;
function ParamValueStrDelim(const Params, Param: string; varType: Integer): Variant;
function VarToDelimStr(const V: Variant; DelimStr: Char): string;
function DelimStrToVar(const S: string; DelimChar: Char; VarType: Integer): Variant;
function MyVarArrayCreate(const Bounds: Integer; Default: Variant): Variant;
function MyVarArrayHighBound(const A: Variant): Integer;
function PrimeiraLetraCaps(const S: string): string;
function StrToChar(const S: string): Char;
procedure Sugestao(Form: TForm; Tabela: TDataSet; Sugestao: Boolean);
//Trava
function  KeyGen(S,K:String): string;
function  Cripto(S, K: string): string;
function  Decripto(S, K: string): string;
function  CriptoDate(DateTime: Real): string;
function  DeCriptoDate(Key: String) : TDateTime;
function  ReadAccess(const Section, Ident: string; Default: Variant): Variant;
procedure WriteAccess(const Section, Ident: string; Value: Variant);
procedure PostDate;
function  CheckDate : Boolean;
function DirectoryFilesList(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true): TStrings;
function RegisterActiveXServer(const ServerLocation: string; Register: Boolean): Boolean;
function GetConsoleOutput(const CommandLine:string): string;
function connConnect(form: TComponent; closeApp: boolean): String;
procedure ExecFile(F: String);
function RunAsAdmin(hWnd: HWND; filename: string; Parameters: string): Boolean;
function EncodeStr255(const S: string; K: string = ''): string;
function ReverseStr(const S: string): string;
function CriptoStr255(const S: string; const Key: string = ''): string;
function DeCriptoStr255(const S: string; const Key: string = ''): string;
function StrCmp(s1: String; s2: String; cs: Boolean): integer;
function Replace(Text,Busca,Troca : string) : string;
function StrReplace(Text, Busca, Troca: string) : string;
function PalavrasComecamMaiusculas(Text: String): String;
function GetMousePos(janela:TForm):TPoint;
function InputPassword(const ACaption, APrompt: string; var Value: string): Boolean;
function LoginUser(conn: TAdoConnection; user: String; pass: String; admin: boolean): Boolean;
function getLoginDlg(conn: TAdoConnection; const tentativas: integer = 1): boolean;
function MakeAutoComplete(hwndEdit: HWND): LongInt; stdcall;
procedure Delay(MSec: Cardinal);
function FileSetDateTime(NomeArq: string; DataHora: TDateTime): boolean;
function BitsToLeft(i: Byte; n: Integer): Byte;
function BitsToRight(i: Byte; n: Integer): Byte;
function BitsInvertSymetric(i: Byte): Byte;
function StrBool(v: String): boolean;
function PlacaMaeSN(): String;
function MacAddress: string;
function MouseShowCursor(const Show: boolean): boolean;
function StrToAlfaNum(s: String): String;
function numParteInteira(n: Real): Integer;
function numParteFracionaria(n: Real; const digitos: Integer = 2): Integer;
function StrIsInteger(s: String): boolean;
function FileInUse(const FileName: String): Boolean;
function CharIndex(s: String; chr: char): Integer;
function FileExtension(FileName: String): String;
procedure StrSaveToFile(str: String; fileName: String);
function getDataDlg(var d: TDateTime; const MostrarHora: boolean = false): boolean;
function getPeriodoDlg(var d1, d2: TDateTime; const MostrarHora: boolean = false): boolean;
function DateToSQL(d: TDateTime; const delimit: boolean = true; const cast: boolean = false): String;
function DateFromSQL(conn: TAdoConnection): TDateTime;
function ExpirarAplicativo(Application: TApplication; Form: TForm; validoAte: TDateTime; const diasAntesAvisando: integer = 15): boolean;
function CapturarWebCam(destino:string) : boolean;
procedure SplitStr(str, delim: String; var a: TDinArrayStr); overload;
procedure SplitStr(str, delim: String; a: TStrings); overload;
function SplitStr(str, delim: String): TStringList; overload;
function SortLines(lines: String): String;
function ItemStr(str, delim: String; index: Integer): String;
function ItemStrCount(str, delim: String): Integer;
function ItemStrName(str, delim: String; index: Integer): String;
function ItemStrValue(str, delim: String; index: Integer): String; overload;
function ItemStrValue(str, delim: String; name: String): String; overload;
procedure TaskKillByName(ProcName: String); // mata processo pelo nome
function TaskKillByExeName(ExeFileName: string): Integer;
procedure TaskKillByPID(pid: HWND); // mata processo pelo pid
procedure TaskShowByName(ProcName: String); // exibe janela de processo pelo nome
procedure TaskShowByPID(pid: HWND); // exibe janela de processo pelo pid
procedure TaskHideByName(ProcName: String); // oculta janela de processo pelo  nome
procedure TaskHideByPID(pid: HWND); // oculta janela de processo pelo pid
function WriteToFile(text: String; fileName: String; const overWrite: boolean = false; const append: boolean = false): boolean;
function ReadFromFileBin(fileName: String): TDinArrayBytes;
procedure WriteToFileBin(aByte: TDinArrayBytes; fileName: String; const overwrite: boolean = true);
function ReadFromFile(fileName: String): String;
function IdadeCompleta(Data: TDateTime): String; overload;
function IdadeCompleta(DataIni, DataFim : TDateTime): String; overload;
function Periodo(DataIni, DataFim:TDateTime): String; overload;
function Periodo(segundos: LongInt): String; overload;
function DateTimeAdd(date: TDateTime; const days: LongInt = 0; const hours: LongInt = 0; const minutes: LongInt = 0; const seconds: LongInt = 0): TDateTime;
function ValidarCPF(num: string): boolean;
function ValidarCGC(num: string): boolean;
function ValidarData(data: String): boolean;
function ValidarHora(hora: String): boolean;
function ValidarDataHora(datahora: String): boolean;
function ValidarInteiro(numInteiro: String): boolean;
function ValidarReal(numReal: String): boolean;
function ValidarEmail(sEmail: string): boolean;
function ValidarURL(const Url: string): Boolean;
function ValidarCEP(UF, CEPDigitado: String): Boolean;
function ValidarIntervaloInteiro(valorComparar, valorMinimo, valorMaximo: LongInt): boolean;
function ValidarIntervaloReal(valorComparar, valorMinimo, valorMaximo: Double): boolean;
function ValidarIntervaloDataHora(valorComparar, valorMinimo, valorMaximo: TDateTime): boolean;
Function FormatarNome(Nome: String): String;
function FormatarCPF(cpf: String): String;
function FormatarCNPJ(cnpj: String): String;
procedure NotePad(s: String);
function HexToInt(s : string) : Int64;
function IntToHex(n: Int64; digits: Integer): String;
function IntToBin(IValue : Int64; NumBits : word = 64) : string;
function BinToInt(BinStr : string) : Int64;
function Base10(Base2:Integer) : Integer; assembler;
procedure AByteInit(var aByte: TDinArrayBytes; const size: Integer = 0);
function AByteAdd(var aByte: TDinArrayBytes; b: Byte): integer; overload;
function AByteAdd(var aByte: TDinArrayBytes; str: String): integer; overload;
function AByteToStr(aByte: TDinArrayBytes): String;
procedure StrToAByte(str: String; var aByte: TDinArrayBytes);
function CheckSum(aByte: TDinArrayBytes; const de: integer = -1; const ate: Integer = -1): Byte; overload;
function CheckSum(str: String; const de: Integer = 0; const ate: Integer = 0): Byte; overload;
procedure IntToBytes2(n: Integer; var aBytes: TDinArrayBytes);
function Bytes2ToInt(var aBytes: TDinArrayBytes): Integer;
function GetIpList(): TStringList;
function GetFileSize(path: string) : Int64;
procedure ClearCriptoConfig(const fileName: String = 'configSecure.ini');
function ReadCriptoConfig(name: String; default: String; const fileName: String = 'configSecure.ini'): String;
procedure WriteCriptoConfig(name: String; value: String; const fileName: String = 'configSecure.ini');
function ReadFileSecure(fileName: String; const KEY: String = KEY_CONFIG_SECURE): String;
procedure WriteFileSecure(txt, fileName: String; const KEY: String = KEY_CONFIG_SECURE);
procedure ComPort_ExibirConfiguracao();
procedure ComPort_Configurar(porta: Integer; baud_rate: Integer; const flow_control: String = '');
function ComPort_AbrirPorta(const porta: integer = 0): boolean;
procedure ComPort_FecharPorta();
function ComPort_TxtDoBuffer(): String;
function ComPort_Enviar_e_Receber(porta: Integer; txt: String; aguardar: Integer): String; overload;
function ComPort_Enviar_e_Receber(porta: Integer; txtEnviar: String; var bytesRecebidos: TDinArrayBytes; const aguardar: integer = 0): boolean; overload;
function ComPort_Enviar_e_Receber(porta: Integer; txtEnviar: String; var txtRecebido: String; const aguardar: integer = 0): boolean; overload;
function VersaoExe(ArquivoExe : string): String;
function MakeSubDirs(dir: String): boolean;
function FileDateTime(path: String): TDateTime;
function FileSizeInBytes(fileName : wideString) : Int64;
function FilePrefix(path: String): String;
function FileSufix(path: String): String;
function parcelasOrdenar(strParcelas: String): String;
function parcelasQueFaltam(strParcelas: String): String;

function FormatDateTimeSQL(data: TDateTime): String;
function FormatDateSQL(data: TDateTime): String;
function FormatTimeSQL(data: TDateTime): String;
function FormatStringSQL(s: String): String;
function GetDateTimeSQL(campo: String): String;
function GetDateSQL(campo: String): String;
function GetTimeSQL(campo: String): String;
function IsDateTimeSQL(dateTime: String): boolean;
function StrInArray(str: String; strArray: Array of String; const caseSensitive: boolean = false): boolean;
function EncodeBase64(S: string): string;
function DecodeBase64(S: string): string;
function StringIsInteger(str: String): boolean;
function StrIsDate(str: String): boolean;
function StrIsDateTime(str: String): boolean;
function ExecSQLBatch(conn: TAdoConnection; sql: String; const continueOnError: boolean = false): String;
function NumIntZeros(num: Integer; digitos: Integer): String;
function TextoListarSecoes(txt: String; const beginString: String = '@{'; const endString: String = '}'): String;
function TextoLerSecao(txt, secao: String; const beginString: String = '@{'; const endString: String = '}'): String;
function Info(msg: String; const YesNo: boolean =  false): boolean;
function Warning(msg: String; const YesNo: boolean =  false): boolean;
function Confirm(msg: String; const YesNo: boolean =  false): boolean;
function Error(msg: String; const YesNo: boolean =  false): boolean;
procedure TrimAppMemorySize();

var
	Config_CaixaAlta: Boolean;
	Config_EnterNextCtrl: Boolean;
	Config_SemAcentuacao: Boolean;
    ComPort: TComPort;

var
	AppInfo: TAppInfo;

var
	SHORTMONTHLIST: string;

const
    FILE_SYSTEM = 'System.ini';
	FILE_CONFIG = 'Config.ini';
    FILE_CONFIG_SECURE = 'configSecure.ini';
	FILE_TABLES = 'TCS.ini';
	CHR_LF = #10;
	CHR_CR = #13;
	LINE_FEED = #13#10;
	LINE_FEED2 = LINE_FEED + LINE_FEED;
	DECIMALTOINC = '13712';
	Meses: array [1..12] of string[3] = ('JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ');
    MesesExtenso: array [1..12] of string = ('Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
    DiasSemana: array [1..7] of string[3] = ('DOM','SEG','TER','QUA','QUI','SEX','SAB');
    DiasSemanaExtenso: array [1..7] of string = ('Domingo','Segunda-feira','Terça-feira','Quarta-feira','Quinta-feira','Sexta-feira','Sábado');


const
	ModalOK = 2;

const
	MASK_SMALLDATE = 'dd/mm/yyyy';
	MASK_SMALLTIME = 'hh:nn';

const
	DISPLAYFORMAT_DATE = 'dd/mm/yyyy';
	DISPLAYFORMAT_DATETIME = 'dd/mm/yyyy hh:nn';
	DISPLAYFORMAT_CURRENCY = '#,#0.00;(#,#0.00);-';

const
	UFs = 'AC' + CHR_LF +
				'AL' + CHR_LF +
				'AM' + CHR_LF +
				'AP' + CHR_LF +
				'BA' + CHR_LF +
				'CE' + CHR_LF +
				'DF' + CHR_LF +
				'ES' + CHR_LF +
				'FN' + CHR_LF +
				'GO' + CHR_LF +
				'MA' + CHR_LF +
				'MG' + CHR_LF +
				'MS' + CHR_LF +
				'MT' + CHR_LF +
				'PA' + CHR_LF +
				'PB' + CHR_LF +
				'PE' + CHR_LF +
				'PI' + CHR_LF +
				'PR' + CHR_LF +
				'RJ' + CHR_LF +
				'RN' + CHR_LF +
				'RO' + CHR_LF +
				'RR' + CHR_LF +
				'RS' + CHR_LF +
				'SC' + CHR_LF +
				'SE' + CHR_LF +
				'SP' + CHR_LF +
				'TO';

    htmlCodeRec: array [0..240] of THtmlCodeRec = (
        (Ch:   34; Html: '&quot;'),
        (Ch:   38; Html: '&amp;'),
        (Ch:   39; Html: '&apos;'),
        (Ch:   60; Html: '&lt;'),
        (Ch:   62; Html: '&gt;'),
        (Ch:  160; Html: '&nbsp;'),
        (Ch:  161; Html: '&iexcl;'),
        (Ch:  162; Html: '&cent;'),
        (Ch:  163; Html: '&pound;'),
        (Ch:  164; Html: '&curren;'),
        (Ch:  165; Html: '&yen;'),
        (Ch:  166; Html: '&brvbar;'),
        (Ch:  167; Html: '&sect;'),
        (Ch:  168; Html: '&uml;'),
        (Ch:  169; Html: '&copy;'),
        (Ch:  170; Html: '&ordf;'),
        (Ch:  171; Html: '&laquo;'),
        (Ch:  172; Html: '&not;'),
        (Ch:  173; Html: '&shy;'),
        (Ch:  174; Html: '&reg;'),
        (Ch:  175; Html: '&macr;'),
        (Ch:  176; Html: '&deg;'),
        (Ch:  177; Html: '&plusmn;'),
        (Ch:  178; Html: '&sup2;'),
        (Ch:  179; Html: '&sup3;'),
        (Ch:  180; Html: '&acute;'),
        (Ch:  181; Html: '&micro;'),
        (Ch:  182; Html: '&para;'),
        (Ch:  183; Html: '&middot;'),
        (Ch:  184; Html: '&cedil;'),
        (Ch:  185; Html: '&sup1;'),
        (Ch:  186; Html: '&ordm;'),
        (Ch:  187; Html: '&raquo;'),
        (Ch:  188; Html: '&frac14;'),
        (Ch:  189; Html: '&frac12;'),
        (Ch:  190; Html: '&frac34;'),
        (Ch:  191; Html: '&iquest;'),
        (Ch:  192; Html: '&Agrave;'),
        (Ch:  193; Html: '&Aacute;'),
        (Ch:  194; Html: '&Acirc;'),
        (Ch:  195; Html: '&Atilde;'),
        (Ch:  196; Html: '&Auml;'),
        (Ch:  197; Html: '&Aring;'),
        (Ch:  198; Html: '&AElig;'),
        (Ch:  199; Html: '&Ccedil;'),
        (Ch:  200; Html: '&Egrave;'),
        (Ch:  201; Html: '&Eacute;'),
        (Ch:  202; Html: '&Ecirc;'),
        (Ch:  203; Html: '&Euml;'),
        (Ch:  204; Html: '&Igrave;'),
        (Ch:  205; Html: '&Iacute;'),
        (Ch:  206; Html: '&Icirc;'),
        (Ch:  207; Html: '&Iuml;'),
        (Ch:  208; Html: '&ETH;'),
        (Ch:  209; Html: '&Ntilde;'),
        (Ch:  210; Html: '&Ograve;'),
        (Ch:  211; Html: '&Oacute;'),
        (Ch:  212; Html: '&Ocirc;'),
        (Ch:  213; Html: '&Otilde;'),
        (Ch:  214; Html: '&Ouml;'),
        (Ch:  215; Html: '&times;'),
        (Ch:  216; Html: '&Oslash;'),
        (Ch:  217; Html: '&Ugrave;'),
        (Ch:  218; Html: '&Uacute;'),
        (Ch:  219; Html: '&Ucirc;'),
        (Ch:  220; Html: '&Uuml;'),
        (Ch:  221; Html: '&Yacute;'),
        (Ch:  222; Html: '&THORN;'),
        (Ch:  223; Html: '&szlig;'),
        (Ch:  224; Html: '&agrave;'),
        (Ch:  225; Html: '&aacute;'),
        (Ch:  226; Html: '&acirc;'),
        (Ch:  227; Html: '&atilde;'),
        (Ch:  228; Html: '&auml;'),
        (Ch:  229; Html: '&aring;'),
        (Ch:  230; Html: '&aelig;'),
        (Ch:  231; Html: '&ccedil;'),
        (Ch:  232; Html: '&egrave;'),
        (Ch:  233; Html: '&eacute;'),
        (Ch:  234; Html: '&ecirc;'),
        (Ch:  235; Html: '&euml;'),
        (Ch:  236; Html: '&igrave;'),
        (Ch:  237; Html: '&iacute;'),
        (Ch:  238; Html: '&icirc;'),
        (Ch:  239; Html: '&iuml;'),
        (Ch:  240; Html: '&eth;'),
        (Ch:  241; Html: '&ntilde;'),
        (Ch:  242; Html: '&ograve;'),
        (Ch:  243; Html: '&oacute;'),
        (Ch:  244; Html: '&ocirc;'),
        (Ch:  245; Html: '&otilde;'),
        (Ch:  246; Html: '&ouml;'),
        (Ch:  247; Html: '&divide;'),
        (Ch:  248; Html: '&oslash;'),
        (Ch:  249; Html: '&ugrave;'),
        (Ch:  250; Html: '&uacute;'),
        (Ch:  251; Html: '&ucirc;'),
        (Ch:  252; Html: '&uuml;'),
        (Ch:  253; Html: '&yacute;'),
        (Ch:  254; Html: '&thorn;'),
        (Ch:  255; Html: '&yuml;'),
        (Ch:  338; Html: '&OElig;'),
        (Ch:  339; Html: '&oelig;'),
        (Ch:  352; Html: '&Scaron;'),
        (Ch:  353; Html: '&scaron;'),
        (Ch:  376; Html: '&Yuml;'),
        (Ch:  402; Html: '&fnof;'),
        (Ch:  710; Html: '&circ;'),
        (Ch:  732; Html: '&tilde;'),
        (Ch:  913; Html: '&Alpha;'),
        (Ch:  914; Html: '&Beta;'),
        (Ch:  915; Html: '&Gamma;'),
        (Ch:  916; Html: '&Delta;'),
        (Ch:  917; Html: '&Epsilon;'),
        (Ch:  918; Html: '&Zeta;'),
        (Ch:  919; Html: '&Eta;'),
        (Ch:  920; Html: '&Theta;'),
        (Ch:  921; Html: '&Iota;'),
        (Ch:  922; Html: '&Kappa;'),
        (Ch:  923; Html: '&Lambda;'),
        (Ch:  924; Html: '&Mu;'),
        (Ch:  925; Html: '&Nu;'),
        (Ch:  926; Html: '&Xi;'),
        (Ch:  927; Html: '&Omicron;'),
        (Ch:  928; Html: '&Pi;'),
        (Ch:  929; Html: '&Rho;'),
        (Ch:  931; Html: '&Sigma;'),
        (Ch:  932; Html: '&Tau;'),
        (Ch:  933; Html: '&Upsilon;'),
        (Ch:  934; Html: '&Phi;'),
        (Ch:  935; Html: '&Chi;'),
        (Ch:  936; Html: '&Psi;'),
        (Ch:  937; Html: '&Omega;'),
        (Ch:  945; Html: '&alpha;'),
        (Ch:  946; Html: '&beta;'),
        (Ch:  947; Html: '&gamma;'),
        (Ch:  948; Html: '&delta;'),
        (Ch:  949; Html: '&epsilon;'),
        (Ch:  950; Html: '&zeta;'),
        (Ch:  951; Html: '&eta;'),
        (Ch:  952; Html: '&theta;'),
        (Ch:  953; Html: '&iota;'),
        (Ch:  954; Html: '&kappa;'),
        (Ch:  955; Html: '&lambda;'),
        (Ch:  956; Html: '&mu;'),
        (Ch:  957; Html: '&nu;'),
        (Ch:  958; Html: '&xi;'),
        (Ch:  959; Html: '&omicron;'),
        (Ch:  960; Html: '&pi;'),
        (Ch:  961; Html: '&rho;'),
        (Ch:  962; Html: '&sigmaf;'),
        (Ch:  963; Html: '&sigma;'),
        (Ch:  964; Html: '&tau;'),
        (Ch:  965; Html: '&upsilon;'),
        (Ch:  966; Html: '&phi;'),
        (Ch:  967; Html: '&chi;'),
        (Ch:  968; Html: '&psi;'),
        (Ch:  969; Html: '&omega;'),
        (Ch:  977; Html: '&thetasym;'),
        (Ch:  978; Html: '&upsih;'),
        (Ch:  982; Html: '&piv;'),
        (Ch: 8194; Html: '&ensp;'),
        (Ch: 8195; Html: '&emsp;'),
        (Ch: 8201; Html: '&thinsp;'),
        (Ch: 8204; Html: '&zwnj;'),
        (Ch: 8205; Html: '&zwj;'),
        (Ch: 8206; Html: '&lrm;'),
        (Ch: 8207; Html: '&rlm;'),
        (Ch: 8211; Html: '&ndash;'),
        (Ch: 8212; Html: '&mdash;'),
        (Ch: 8216; Html: '&lsquo;'),
        (Ch: 8217; Html: '&rsquo;'),
        (Ch: 8218; Html: '&sbquo;'),
        (Ch: 8220; Html: '&ldquo;'),
        (Ch: 8221; Html: '&rdquo;'),
        (Ch: 8222; Html: '&bdquo;'),
        (Ch: 8224; Html: '&dagger;'),
        (Ch: 8225; Html: '&Dagger;'),
        (Ch: 8226; Html: '&bull;'),
        (Ch: 8230; Html: '&hellip;'),
        (Ch: 8240; Html: '&permil;'),
        (Ch: 8242; Html: '&prime;'),
        (Ch: 8243; Html: '&Prime;'),
        (Ch: 8249; Html: '&lsaquo;'),
        (Ch: 8250; Html: '&rsaquo;'),
        (Ch: 8254; Html: '&oline;'),
        (Ch: 8364; Html: '&euro;'),
        (Ch: 8482; Html: '&trade;'),
        (Ch: 8592; Html: '&larr;'),
        (Ch: 8593; Html: '&uarr;'),
        (Ch: 8594; Html: '&rarr;'),
        (Ch: 8595; Html: '&darr;'),
        (Ch: 8596; Html: '&harr;'),
        (Ch: 8629; Html: '&crarr;'),
        (Ch: 8704; Html: '&forall;'),
        (Ch: 8706; Html: '&part;'),
        (Ch: 8707; Html: '&exist;'),
        (Ch: 8709; Html: '&empty;'),
        (Ch: 8711; Html: '&nabla;'),
        (Ch: 8712; Html: '&isin;'),
        (Ch: 8713; Html: '&notin;'),
        (Ch: 8715; Html: '&ni;'),
        (Ch: 8719; Html: '&prod;'),
        (Ch: 8721; Html: '&sum;'),
        (Ch: 8722; Html: '&minus;'),
        (Ch: 8727; Html: '&lowast;'),
        (Ch: 8730; Html: '&radic;'),
        (Ch: 8733; Html: '&prop;'),
        (Ch: 8734; Html: '&infin;'),
        (Ch: 8736; Html: '&ang;'),
        (Ch: 8743; Html: '&and;'),
        (Ch: 8744; Html: '&or;'),
        (Ch: 8745; Html: '&cap;'),
        (Ch: 8746; Html: '&cup;'),
        (Ch: 8747; Html: '&int;'),
        (Ch: 8756; Html: '&there4;'),
        (Ch: 8764; Html: '&sim;'),
        (Ch: 8773; Html: '&cong;'),
        (Ch: 8776; Html: '&asymp;'),
        (Ch: 8800; Html: '&ne;'),
        (Ch: 8801; Html: '&equiv;'),
        (Ch: 8804; Html: '&le;'),
        (Ch: 8805; Html: '&ge;'),
        (Ch: 8834; Html: '&sub;'),
        (Ch: 8835; Html: '&sup;'),
        (Ch: 8836; Html: '&nsub;'),
        (Ch: 8838; Html: '&sube;'),
        (Ch: 8839; Html: '&supe;'),
        (Ch: 8853; Html: '&oplus;'),
        (Ch: 8855; Html: '&otimes;'),
        (Ch: 8869; Html: '&perp;'),
        (Ch: 8901; Html: '&sdot;'),
        (Ch: 8968; Html: '&lceil;'),
        (Ch: 8969; Html: '&rceil;'),
        (Ch: 8970; Html: '&lfloor;'),
        (Ch: 8971; Html: '&rfloor;'),
        (Ch: 9674; Html: '&loz;'),
        (Ch: 9824; Html: '&spades;'),
        (Ch: 9827; Html: '&clubs;'),
        (Ch: 9829; Html: '&hearts;'),
        (Ch: 9830; Html: '&diams;')
      );



implementation

uses
    FileCtrl, jvmemorydataset, ShlObj, ActiveX, Registry, SQLSearch, AdoScript;

var
	FQueryIndexCEP: Integer;

type
	TDateOrder = (doMDY, doDMY, doYMD);


{	Função para baixar arquivos:
	Se o arquivo for baixado com sucesso a função retorna string vazia,
	senão a função retorna o caminho do que tentou ser baixado sem
	sucesso.	}
function DownloadFile(Source, Dest: string): String;
begin
  try
    if (UrlDownloadToFile(nil, PChar(source),PChar(Dest), 0, nil) = 0) then
    	result := ''
    else
    	result := source;
  except
    Result:= source;
  end;
end;


function DownloadFile2(const fileURL, FileName: String): boolean;
{* Exemplo de como utilizar
    var
        internetFile,
        localFileName: string;
    begin
        internetFile := 'http://0.tqn.com/6/g/delphi/b/index.xml';
        localFileName := 'About Delphi Programming RSS Feed.xml';

        if GetInetFile(internetFile, localFileName) then
            ShowMessage('Download successful.')
        else
            ShowMessage('Error in file download.') ; }
const
    BufferSize = 1024;
var
    hSession, hURL: HInternet;
    Buffer: array[1..BufferSize] of Byte;
    BufferLen: DWORD;
    f: File;
    sAppName: string;
begin
    result := false;
    sAppName := ExtractFileName(Application.ExeName) ;
    hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0) ;
    try
        hURL := InternetOpenURL(hSession, PChar(fileURL), nil, 0, 0, 0) ;
        try
            AssignFile(f, FileName) ;
            Rewrite(f,1) ;
            repeat
                InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen) ;
                BlockWrite(f, Buffer, BufferLen)
            until BufferLen = 0;
            CloseFile(f) ;
            result := True;
        finally
            InternetCloseHandle(hURL)
        end
    finally
        InternetCloseHandle(hSession)
    end
end;

function DownloadText(const aUrl: string; var resposta: boolean): String;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  lpBuffer: array[0..1024 + 1] of Char;
  dwBytesRead: DWORD;
begin
  resposta := False;
  result := '';
  // hSession := InternetOpen( 'MyApp', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
  hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    if Assigned(hSession) then
    begin
      hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
      if Assigned(hService) then
        try
          while True do
          begin
            dwBytesRead := 1024;
            InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
            if dwBytesRead = 0 then break;
            lpBuffer[dwBytesRead] := #0;
            result := result + lpBuffer;
          end;
          resposta := True;
        finally
          InternetCloseHandle(hService);
        end;
    end;
  finally
    InternetCloseHandle(hSession);
  end;
end;


function fnGetPathTemp(): String;
begin
    Result := WinTempDir;
end;

{	Função para transformar pixels da tela em milímetros reais  (Horizontal)	}
function PixelHorizToMM(PixelX: Integer): Integer;
var
    hdcDesk: HDC;
begin
    hdcDesk:=GetDC(0);
    try
        result:=Trunc(PixelX * (GetDeviceCaps(hdcDesk, HORZSIZE) / GetDeviceCaps(hdcDesk, HORZRES)));
    finally
        ReleaseDC(0, hdcDesk);
    end;
end;

{	Função para transformar milímetros reais em pixels da tela (Horizontal)		}
function MMToPixelHoriz(mm: Integer): Integer;
var
    hdcDesk: HDC;
begin
    hdcDesk:=GetDC(0);
    try
        result := Trunc(mm * (GetDeviceCaps(hdcDesk, HORZRES) / GetDeviceCaps(hdcDesk, HORZSIZE)));
    finally
        ReleaseDC(0, hdcDesk);
    end;
end;

{	Função para transformar pixels da tela em milímetros reais  (Vertical)		}
function PixelVertToMM(PixelY: Integer): Integer;
var
    hdcDesk:       HDC;
begin
    hdcDesk:=GetDC(0);
    try
        result:=Trunc(PixelY * (GetDeviceCaps(hdcDesk, VERTSIZE) / GetDeviceCaps(hdcDesk, VERTRES)));
    finally
        ReleaseDC(0, hdcDesk);
    end;
end;

{	Função para transformar milímetros reais em pixels da tela (Vertical)		}
function MMToPixelVert(mm: Integer): Integer;
var
    hdcDesk:       HDC;
begin
    hdcDesk:=GetDC(0);
    try
        result:=Trunc(mm * (GetDeviceCaps(hdcDesk, VERTRES) / GetDeviceCaps(hdcDesk, VERTSIZE)));
    finally
        ReleaseDC(0, hdcDesk);
    end;
end;

{	Função para transformar uma cor em uma string RGB	}
function TColorToStringRGB(Color : TColor) : string;
begin
   Result :=
     IntToHex(GetRValue(Color), 2) +
     IntToHex(GetGValue(Color), 2) +
     IntToHex(GetBValue(Color), 2) ;
end;

{	Função para transformar uma string RGB em uma cor	}
function StringRGBToTColor(sColor : string) : TColor;
begin
   Result :=
     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     ) ;
end;


{	Função para buscar arquivos baseado em uma máscara. Ex.:     Memo1.Text := FindFiles('d:\Músicas\', '*.mp3', true).Text;	}
function FindFiles(const Path, Mask: string; IncludeSubDir: boolean): TStrings;
var
    FindResult: integer;
    SearchRec : TSearchRec;
    s: TStrings;
begin
    s := TStringList.Create();
    result := s;
    FindResult := FindFirst(Path + Mask, faAnyFile - faDirectory, SearchRec);
    while FindResult = 0 do
    begin
        { do whatever you'd like to do with the files found }
        s.Add(Path + SearchRec.Name);
        //result := result + 1;
        FindResult := FindNext(SearchRec);
    end;
    { free memory }
    SysUtils.FindClose(SearchRec);
    if not IncludeSubDir then
        Exit;
    FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec);
    while FindResult = 0 do
    begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
            result.Text := result.Text + FindFiles (Path + SearchRec.Name + '\', Mask, TRUE).Text;
        FindResult := FindNext(SearchRec);
    end;
    { free memory }
    SysUtils.FindClose(SearchRec);
end;


procedure CreateChildForm(Application: TApplication; FormClass: TFormClass; var Reference);
var
  I: Integer;
  Instance: TForm;
begin

  if Application.Terminated or (Application.Tag = WM_QUIT) then Exit;

  for I := 0 to Application.MainForm.MDIChildCount - 1 do
    if Application.MainForm.MDIChildren[I] is FormClass then
    begin
      Application.MainForm.MDIChildren[I].Show;
      Exit;
    end;
  Screen.Cursor := crHourglass;

  try
    try
      Instance := TForm(FormClass.NewInstance);
      TComponent(Reference) := Instance;
      try
        Instance.Create(Application.MainForm);
        Instance.FormStyle := fsMDIChild;
        Instance.Show;
      except
        TComponent(Reference) := nil;
        raise;
      end;
    finally
    end;
    if not Application.Terminated and (Application.Tag = 0) then SendMessage(Instance.Handle, WM_USER + 1 , 0, 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;


function fnQrNew(conn: TAdoConnection; sql: String; const AutoOpen: boolean = false): TAdoQuery;
var
    existsConn: boolean;
    connected: boolean;
begin
    existsConn := true;
    result := TAdoQuery.Create(Application);
    if conn = nil then
    begin
        existsConn := false;
        conn := TAdoConnection.Create(result);
        conn.LoginPrompt := false;
        conn.ConnectionString := fnGetStrConnect();
        try
            conn.Open();
            connected := conn.Connected;
        except
            connected := false;
        end;
    end
    else
    begin
        connected := conn.Connected;
    end;

    result.Connection := conn;
    result.SQL.Text := sql;
    if AutoOpen then
    begin
        if connected then
        begin
            try
                result.Open();
            except
                on e: Exception do
                begin
                    ShowMessage(e.Message);
                end;
            end;
        end;
    end;
end;


function sqlExec(conn: TAdoConnection; sql: String): boolean;
var
    existsConn: boolean;
    connected: boolean;
    qr: TAdoQuery;
begin
    result := false; 
    existsConn := true;
    qr := TAdoQuery.Create(Application);
    if conn = nil then
    begin
        existsConn := false;
        conn := TAdoConnection.Create(qr);
        conn.LoginPrompt := false;
        conn.ConnectionString := fnGetStrConnect();
        try
            conn.Open();
            connected := conn.Connected;
        except
            connected := false;
        end;
    end
    else
    begin
        connected := conn.Connected;
    end;

    if connected then
    begin
        qr.Connection := conn;
        qr.SQL.Text := sql;
        try
            try
                qr.ExecSQL();
                result := true;
            except
                result := false;
            end;
        finally
            qr.Free();
        end;
    end;
end;



function fnNameRandom(Ext: String):string;
var
    a,b:string;
begin
    randomize;
    a:=IntToStr(random(999999));
    b:=IntToStr(random(999999));
    while length(a) < 6 do
    begin
        a := a + IntToStr(random(9));
    end;
    while length(b) < 6 do
    begin
        b := b + IntToStr(random(9));
    end;
    a := a + b;
    if Ext <> '' then
        a := a + '.' + Ext;
    fnNameRandom := a;
end;


function fnReadConfig(grupo, nome: string): string;
begin
    Result := trim(ReadIniFile(ArqSis('System.ini'), grupo, nome, ''));
end;

function ReadSystemArq(grupo, nome, default: string): string;
begin
    result := trim(ReadIniFile(ArqSis('System.ini'), grupo, nome, default));
end;

procedure WriteSystemArq(grupo, nome, value: String);
begin
    WriteIniFile(ArqSis('System.ini'), grupo, nome, value);
end;

function ExistsSystemArq(grupo, nome: String): boolean;
begin
    result := (ReadIniFile(ArqSis('System.ini'), grupo, nome, '') <> '');
end;


function fnReadConfig2(grupo, nome, valorpadrao: string): string;
var
    SysFile: TMemIniFile;
begin
    SysFile := TMemIniFile.Create(GetCurrentDir() + '\system.ini');
    Result := SysFile.ReadString(grupo, nome, valorpadrao);
    SysFile.Free;
end;

procedure GravarRegistro(chave,valor:string);
const
    Raiz : String = 'Software\Solução Sistemas';
var
    Registro : TRegistry;
begin
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey (Raiz, True);
    Registro.WriteString(chave,valor);
    Registro.CloseKey;
    Registro.Free;
end;

function LerRegistro(chave:string):string;
const
    Raiz : String = 'Software\Solução Sistemas';
var
    Registro : TRegistry;
begin
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    with Registro do
    begin
        if OpenKey (Raiz, False) then
        begin
            if ValueExists (chave) then
            begin
                result := ReadString (chave);
            end;
        end;
    end;
    Registro.CloseKey;
    Registro.Free;
end;

procedure ExcluirRegistro(chave:string);
const
    Raiz : String = 'Software\Solução Sistemas';
var
    Registro : TRegistry;
begin
    Registro := TRegistry.Create;
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey (Raiz, True);
    if Registro.ValueExists(chave) then
    begin
        Registro.DeleteValue(chave);
    end;
    Registro.CloseKey;
    Registro.Free;
end;


procedure MsgErr(Msg: String);
begin
    MessageDlg(Msg, mtError, [mbOk], 0);
end;


function DataFilesDir: String;
begin
    result := trim(ReadIniFile(ArqSis('System.ini'), 'AppInfo', 'DataFilesDir', ''));
    if not DirectoryExists(Result) then
        result := ExtractFilePath(Application.ExeName);
    if not DirectoryExists(Result) then
        Result := '';
    if length(Result) > 0 then
        if Result[Length(Result)] <> '\' then
            Result := Result + '\';
end;

function WinTempDir: String;
var
    Buffer : Array[0..144] of Char;
begin
    if AppInfo.TempDir = '' then
    begin
        result := trim(ReadIniFile(ArqSis('System.ini'), 'AppInfo', 'TempDir', ''));
        if not DirectoryExists(Result) then
        begin
            GetTempPath(144,Buffer);
            Result := StrPas(Buffer);
        end;
        if not DirectoryExists(Result) then
            Result := '';
        if length(Result) > 0 then
            if Result[Length(Result)] <> '\' then
                Result := Result + '\';
        AppInfo.TempDir := Result;
    end
    else
        Result := AppInfo.TempDir;
end;

function WinSystemDir: String;
var
    Buffer: Array[0..144] of Char;
begin
    Result := '';
    GetSystemDirectory(Buffer, 144);
    Result := StrPas(Buffer);
    if not DirectoryExists(Result) then
        Result := '';
    if length(Result) > 0 then
        if Result[Length(Result)] <> '\' then
            Result := Result + '\';
end;

function WindowsDir: String;
var
    Buffer: String;
begin
    buffer := '';
    result := '';
    SetLength(Buffer, MAX_PATH);
    if (GetWindowsDirectory(PChar(buffer), MAX_PATH) > 0) then
    begin
        SetLength(buffer, StrLen(PChar(buffer)));
        Result := Trim(StrPas(PChar(buffer)));
    end;
    if not DirectoryExists(Result) then
        Result := '';
    if length(Result) > 0 then
        if Result[Length(Result)] <> '\' then
            Result := Result + '\';
end;

function WindowsDrive: String;
begin
    result := WindowsDir();
    if length(result) > 2 then
        result := Copy(result, 1, 3);
end;

function WindowsFontsDir: String;
var
    Buffer: Array[0..144] of Char;
begin
    Result := WindowsDir + 'Fonts\';
end;



function ReportsPath: String;
begin
    Result := '';
    Result := trim(ReadIniFile(ArqSis('System.ini'), 'Reports', 'ReportsPath', ''));
    if not DirectoryExists(Result) then
        Result := '';
    if length(Result) > 0 then
        if Result[Length(Result)] <> '\' then
            Result := Result + '\';
end;


function fnGetStrConnect: String;
begin
    Result := ReadIniFile(ArqSis('system.ini'), 'ADOConnection', 'ConnectionString', '');
end;

function fnGetPathReports: String;
begin
    Result := ReadIniFile(ArqSis('system.ini'), 'Reports', 'ReportsPath', '');
    if Copy(Result, length(Result), 1) <> '\' then
        Result := Result + '\';
end;

procedure prExecuteSQL(con: TAdoConnection; cmd: String);
var
    qr: TAdoQuery;
begin
    qr := TAdoQuery.Create(nil);
    qr.Connection := con;
    qr.SQL.Text := cmd;
    try
    qr.ExecSQL;
    except
    end;
    qr.Free;
end;

function fnQrLookUpValue(con: TAdoConnection; select, field: String): Variant;
begin
    with TAdoQuery.Create(nil) do
    begin
        Connection := con;
        SQL.Text := select;
        try
        Open;
        if RecordCount > 0 then
            if length(field) > 0 then
                result := FieldByName(field).AsVariant
            else
                result := Fields[0].AsVariant;
        except
        end;
        Close;
        Free;
    end;
end;


procedure CreateShortcut (FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
var
    MyObject : IUnknown;
    MySLink : IShellLink;
    MyPFile : IPersistFile;
    Directory : String;
    WFileName : WideString;
    MyReg : TRegIniFile;
begin
    MyObject := CreateComObject(CLSID_ShellLink);
    MySLink := MyObject as IShellLink;
    MyPFile := MyObject as IPersistFile;
    with MySLink do
    begin
        SetArguments(PChar(Parameters));
        SetPath(PChar(FileName));
        SetWorkingDirectory(PChar(InitialDir));
    end;
    MyReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
    Directory := MyReg.ReadString ('Shell Folders','Desktop','');
    WFileName := Directory + '\' + ShortcutName + '.lnk';
    if not FileExists(String(WFileName)) then
        MyPFile.Save (PWChar (WFileName), False);
    MyReg.Free;
end;


function fDataYYYYMMDD(data: TDate): String;
var
    s: String;
begin
    result := IntToStr(Year(Data));
    s := IntToStr(Month(Data));
    if length(s) < 2 then
        s := '0' + s;
    result := result + s;
    s := IntToStr(Day(Data));
    if length(s) < 2 then
        s := '0' + s;
    result := result + s;
end;


function fHoraHHMM(hora: TTime): String;
begin
    result := Copy(TimeToStr(hora),1,2) + Copy(TimeToStr(hora),4,2);
end;


function Confirma;
var
	pMsg,
	pTitulo: array[0..$FF] of Char;
begin
	StrPCopy(pMsg, Msg);
	StrPCopy(pTitulo, Application.Title);
	Result := (Application.MessageBox(pMsg, pTitulo, MB_ICONQUESTION + MB_YESNO) = IDYES);
end;

function Questao;
var
	pMsg,
	pTitulo: array[0..$FF] of Char;
begin
	StrPCopy(pMsg, Msg);
	StrPCopy(pTitulo, Application.Title);
	Result := Application.MessageBox(pMsg, pTitulo, MB_ICONWARNING + MB_YESNOCANCEL);
end;

procedure FMessageBox(const Msg: string; Tipo: Word);
var
	pMsg,
	pTitulo: array[0..$FF] of Char;
begin
	StrPCopy(pMsg, Msg);
	StrPCopy(pTitulo, Application.Title);
	MessageBeep(Tipo);
	Application.MessageBox(pMsg, pTitulo, Tipo);
end;

procedure Mensagem;
begin
	FMessageBox(Msg, MB_ICONINFORMATION);
end;

procedure Alerta;
begin
	FMessageBox(Msg, MB_ICONWARNING);
end;

procedure Erro;
begin
	FMessageBox(Msg, MB_ICONERROR);
end;

procedure MyRaiseException;
begin
	raise Exception.Create(Msg);
end;

function StrTrans;
var
	I: Integer;
begin
	Result := S;
	if (Search = Replace) and (Replace <> #0) then Exit;
	if Replace = #0 then
	begin
		repeat
			I := Pos(Search, Result);
			if I = 0 then
				Break else
				Delete(Result, I, 1);
		until False;
	end else
	begin
		repeat
			I := Pos(Search, Result);
			if I = 0 then
				Break else
				Result[I] := Replace;
		until False;
	end;
end;

function FilteredChars;
var
	I: Integer;
begin
	Result := S;
	I := 1;
	while I <= Length(Result) do
		if Result[I] in FFilterChars then
			Inc(I)
        else
			Delete(Result, I, 1);
end;

function MyEndereco;
begin
	Result := Trim(VarAsString(Logradouro));
    if not (VarAsInteger(Numero) = 0) then
        Result := Result + ', ' + Trim(VarAsString(Numero));
    if not (VarAsString(Complemento) = '') then
        Result := Result + ' ' + Trim(VarAsString(Complemento));
end;

function MyCEP;
begin
    if VarIsNull(CEP) then
        Result := ''
    else
        Result := FormatMaskText('99\.999\-999;0', CEP);
end;

function MyRound;
var
    I: Byte;
begin
    if Decimals = -1 then
        I := CurrencyDecimals
    else
        I := Decimals;
    Result := Int(LongInt(Round(X * Power(10, I)))) / Power(10, I);
end;

function MyTrunc;
var
    I: Byte;
begin
    if Decimals = -1 then
        I := CurrencyDecimals
    else
        I := Decimals;
    Result := Int(LongInt(Trunc(X * Power(10, I)))) / Power(10, I);
end;

function IsNullDef;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
      	Result := DefaultValue
    else
        Result := V;
end;

function Pad;
var
    I: Integer;
begin
    I := MaxIntValue([0, Count - Length(S)]);
    case taTipo of
        taRightJustify: Result := MyRight(StringOfChar(Preenc, I) + S, Count);
        taCenter      : Result := MyRight(StringOfChar(Preenc, LongInt(Trunc(I - LongInt(Round(I / 2))))) + S + StringOfChar(Preenc, Round(I / 2)), Count);
        taLeftJustify : Result := MyLeft(S + StringOfChar(Preenc, I), Count);
    end;
end;

function PadL;
begin
    Result := Pad(S, Count, Preenc, taRightJustify);
end;

function PadC;
begin
    Result := Pad(S, Count, Preenc, taCenter);
end;

function PadR;
begin
    Result := Pad(S, Count, Preenc, taLeftJustify);
end;

function Space;
begin
    Result := StringOfChar(' ', Count);
end;

function Repl;
var
	I: Integer;
begin
    Result := '';
    for I := 1 to Count do
        Result := Result + S;
end;

function MyFormatFloat;
begin
	if IsCurrency then
  	    Result := Format('%m', [Value])
    else
        Result := Format('%n', [Value]);
end;

function MyFormatFloat2;
var
    S: string;
begin
    if Decimals = 2 then
        Result := MyFormatFloat(Value, False)
    else
    begin
        S := '#,##0' + IIfStr(Decimals = 0, '', '.' + StringOfChar('0', Decimals));
        S := S + ';' + '(' + S + ');-';
        Result := FormatFloat(S, Value);
    end;
end;

function MyFormatInt;
begin
    Result := FormatFloat(',##0', Value);
end;

function MyFormatDateTime;
begin
    Result := '';
    if not (Int(Value) = 0.00) then
        Result := FormatDateTime(MASK_SMALLDATE, Value);
    if not (Frac(Value) = 0.00) then
    begin
        if not (Result = '') then
            Result := Result + ' ';
        Result := Result + FormatDateTime(MASK_SMALLTIME, Value);
    end;
end;

function PlainText;
var
    I: Integer;
begin
    Result := S;
    for I := 1 to Length(Result) do
        case Result[I] of
            ' '..'~': ;
            'À'..'Æ': Result[I] := 'A';
            'Ç'     : Result[I] := 'C';
            'È'..'Ë': Result[I] := 'E';
            'Ì'..'Ï': Result[I] := 'I';
            'Ñ'     : Result[I] := 'N';
            'Ò'..'Ø': Result[I] := 'O';
            'Ù'..'Ü': Result[I] := 'U';
            'Ý'     : Result[I] := 'Y';
            'à'..'æ': Result[I] := 'a';
            'ç'     : Result[I] := 'c';
            'è'..'ë': Result[I] := 'e';
            'ì'..'ï': Result[I] := 'i';
            'ñ'     : Result[I] := 'n';
            'ò'..'ö': Result[I] := 'o';
            'ù'..'ü': Result[I] := 'u';
            'ý'     : Result[I] := 'y';
            '°'     : Result[I] := 'o';
            'ª'     : Result[I] := 'a';
        else
            begin
                if (Result[I] in ['.',',',';',':','?','!','(',')','-','_']) then
                begin
                    Result[I] := Result[I];
                end
                else if (Result[I] > #32) or KillControlChars then
                begin
                    Result[I] := ' ';
                end;
            end;
        end;
end;

function BetWeen;
begin
    Result := (X <= Z) and (Z <= Y);
end;

function BetWeenInt;
begin
    Result := (X <= Z) and (Z <= Y);
end;

function BetweenDouble(a, b, c: double): Boolean;
begin
    a := math.RoundTo(a, 2);
    b := math.RoundTo(b, 2);
    c := math.RoundTo(c, 2);
    Result := (a >= b) and (a <= c);
end;

function MyLeft(const S: string; Count: Integer): string;
begin
    Result := Copy(S, 1, Count);
end;

function MyRight(const S: string; Count: Integer): string;
begin
    Result := Copy(S, Length(S) - Count + 1, Count);
end;

function MySubs(S: string; Index: Integer; Count: Integer = -1): string;
begin
    if Count = -1 then Count := Length(S);
        Result := Copy(S, Index, Count);
end;

procedure MyDelete;
begin
    if Count = -1 then Count := Length(S);
        Delete(S, Index, Count);
end;

function MyShortDayName;
begin
    if BetWeen(FDayOfWeek, 1, 7) then
        Result := ShortDayNames[FDayOfWeek]
    else
        Result := '';
end;

function Day;
var
    Y, M: Word;
begin
    DecodeDate(FDate, Y, M, Result);
end;

function Month;
var
    Y, D: Word;
begin
    DecodeDate(FDate, Y, Result, D);
end;

function Year;
var
    M, D: Word;
begin
    DecodeDate(FDate, Result, M, D);
end;

function IIfStr;
begin
    if K then
        Result := X
    else
        Result := Y;
end;

function IIfInt;
begin
    if K then
        Result := X
    else
        Result := Y;
end;

function IIfExt;
begin
    if K then
        Result := X
    else
        Result := Y;
end;

function IIf;
begin
    if K then
        Result := X
    else
        Result := Y;
end;

function StrBegins(str, beginStr: String; const caseSensitive: boolean = false): boolean;
var
    a, b: String;
begin
    result := false;
    if length(beginStr) > length(str) then
        result := false
    else if length(beginStr) = 0 then
         result := true
    else
    begin
        a := Copy(str, 1, length(beginStr));
        b := beginStr;
        if not caseSensitive then
        begin
            a := LowerCase(a);
            b := LowerCase(b);
        end;
        if AnsiSameStr(a, b) then
            result := true;
    end;
end;

function StrMatch(strA, strB: String; const caseSensitive: boolean = false): boolean;
var
    a, b: String;
begin
    result := false;
    a := strA;
    b := strB;
    if not caseSensitive then
    begin
        a := LowerCase(a);
        b := LowerCase(b);
    end;
    if AnsiSameStr(a, b) then
        result := true;
end;



function Switch(cases: Array of Boolean; values: Array of Variant; default: Variant): Variant;
var
    i: Integer;
    find: boolean;
    aCases: Array of Boolean;
begin

    SetLength(aCases, Length(cases));
    for i := Low(cases) to High(cases) do
        aCases[i] := cases[i];

    find := false;
    if Length(values) < Length(aCases) then
    begin
        SetLength(aCases, Length(values));
    end;
    for i:= Low(aCases) to High(aCases) do
    begin
        if aCases[i] then
        begin
            find := true;
            result := values[i];
            break;
        end;
    end;
    if not find then
    begin
        result := default;
    end;
end;

function ArqSis;
begin
    Result := ExtractFilePath(ParamStr(0)) + S;
end;

function RetWindowsDir;
var
    FPath: array[0..MAX_PATH + 1] of Char;
begin
    GetWindowsDirectory(@FPath, MAX_PATH + 1);
    Result := StrPas(FPath);
end;

{Retorna a data do primeiro dia do mês.}
function BeginOfYear;
var
    Y, M, D: Word;
begin
    if FDate = 0.00 then
        FDate := Date();
    DecodeDate(FDate, Y, M, D);
    Result := EncodeDate(Y, 01, 01);
end;

{Retorna a data do último dia do mês.}
function EndOfYear;
var
    Y, M, D: Word;
begin
    if FDate = 0.00 then
        FDate := Date();
    DecodeDate(FDate, Y, M, D);
    Result := EndOfDay(EncodeDate(Y, 12, 31));
end;

function CutMilliSeconds;
var
    Year, Month, Day, Hour, Minute, Second, MSeconds: Word;
begin
    DecodeDate(DateTime, Year, Month, Day);
    DecodeTime(DateTime, Hour, Minute, Second, MSeconds);
    Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, 0);
end;

{Retorna a data do primeiro dia do mês.}
function BeginOfMonth;
var
    Y, M, D: Word;
begin
    if FDate = 0.00 then
        FDate := Date();
    DecodeDate(FDate, Y, M, D);
    Result := EncodeDate(Y, M, 1);
end;

{Retorna a data do último dia do mês.}
function EndOfMonth;
var
    Y, M, D: Word;
begin
    if FDate = 0.00 then
        FDate := Date();
    DecodeDate(FDate, Y, M, D);
    if M = 12 then
        Result := EncodeDate(Y + 1, 1, 1) - 1
    else
        Result := EncodeDate(Y, M + 1, 1) - 1;
    Result := ForceTime(Result, False);
end;

function BeginOfWeek;
begin
    if FDate = 0.00 then
        FDate := Date();
    Result := ForceTime(FDate - (DayOfWeek(FDate) - 1), True);
end;

function EndOfWeek;
begin
    if FDate = 0.00 then
        FDate := Date();
    Result := ForceTime(FDate + (7 - DayOfWeek(FDate)), False);
end;

function BeginOfDay;
begin
    if FDate = 0.00 then
        FDate := Date();
    Result := ForceTime(FDate, True);
end;

function EndOfDay;
begin
    if FDate = 0.00 then
        FDate := Date();
    Result := ForceTime(FDate, False);
end;

function AmaciaPeriodo;
begin
    if (Trunc(DataInicial) = Trunc(DataFinal)) or (DataFinal = 0) then
        Result := 'de ' + FormatDateTime('dd/mmm/yyyy', DataInicial)
    else if (DataInicial = BeginOfYear(DataInicial)) and (DataFinal = EndOfYear(DataInicial)) then
        Result := 'de ' + FormatDateTime('yyyy', DataInicial)
    else if (DataInicial = BeginOfMonth(DataInicial)) and (DataFinal = EndOfMonth(DataInicial)) then
        Result := 'de ' + FormatDateTime('mmm/yyyy', DataInicial)
    else if (DataInicial = BeginOfMonth(DataInicial)) and (DataFinal = EndOfMonth(DataFinal)) then
        Result := 'de ' + FormatDateTime('mmm/yyyy', DataInicial) + ' a ' + FormatDateTime('mmm/yyyy', DataFinal)
    else if (DataInicial = BeginOfYear(DataInicial)) and (DataFinal = EndOfYear(DataFinal)) then
        Result := 'de ' + FormatDateTime('yyyy', DataInicial) + ' a ' + FormatDateTime('yyyy', DataFinal)
    else if FormatDateTime('mmyyyy', DataInicial) = FormatDateTime('mmyyyy', DataFinal) then
        Result := 'de ' + FormatDateTime('d', DataInicial) + ' a ' + FormatDateTime('dd/mmm/yyyy', DataFinal)
    else if FormatDateTime('yyyy', DataInicial) = FormatDateTime('yyyy', DataFinal) then
        Result := 'de ' + FormatDateTime('dd/mmm', DataInicial) + ' a ' + FormatDateTime('dd/mmm/yyyy', DataFinal)
    else
        Result := 'de ' + FormatDateTime('dd/mmm/yyyy', DataInicial) + ' a ' + FormatDateTime('dd/mmm/yyyy', DataFinal)
end;

function RandomName: string;
const
    Alphabet = 'abe1cid2ofu4gah5eji6kol7uma8nep9iqo0rus1ate2viw3oxu4yaz5';
begin
    Randomize;
    Result := '~ss';
    while Length(Result) <= 7 do
        Result := Result + Alphabet[Random(Length(Alphabet) - 1) + 1];
end;

function ArqTemp;
var
    FHandle: Integer;
begin
    repeat
        Result := WinTempDir + RandomName + '.' + Ext;
        if not FileExists(Result) then
        begin
            FHandle := FileCreate(Result);
            if FHandle > -1 then
            begin
                FileClose(FHandle);
                Exit;
            end;
        end;
    until False;
end;

function TemporaryDir;
begin
    repeat
        Result := AppInfo.TempDir + RandomName;
        if not DirectoryExists(Result) and ForceDirectories(Result) then
        begin
            Result := Result + '\';
            Break;
        end;
    until False;
end;

function IntToStrZero;
begin
    Result := FloatToStr(Value);
    Result := StringOfChar('0', MaxIntValue([0, Digits - Length(Result)])) + Result;
end;

function VarAsString;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := ''
    else
        Result := V;
end;

function VarAsChar;
begin
    Result := PadR(VarAsString(V), 1)[1];
end;

function VarAsInteger;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function VarAsCurrency;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function VarAsFloat;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function VarAsDateTime;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function VarAsBoolean;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := False
    else
        Result := V;
end;

function VarIfNull;
begin
    if VarIsNull(Compare) then
        Result := ResultIfNull
    else
        Result := Compare;
end;

function NullIfVar;
begin
    if not CompareVar(Compare, Compare2) then
        Result := Compare
    else
        Result := NULL;
end;

function VArScan;
begin
    if VarIsNull(A) then
    begin
        Result := -1;
        Exit;
    end;
    if not VarIsArray(A) or (VarArrayDimCount(A) <> 1) then
        raise Exception.Create('One-dimensional variant array expected');
    for Result := VarArrayLowBound(A, 1) to VarArrayHighBound(A, 1) do
        if CompareVar(A[Result], V) then Exit;
    Result := -1;
end;

{Não modificar esta função, sem antes testar tudo.}
function VArAdd;
begin
    if not VarIsArray(A) then
        Result := VarArrayCreate([0, 0], varVariant)
    else
    begin
        Result := A;
        VarArrayRedim(Result, VarArrayHighBound(Result, 1) + 1);
    end;
    Result[VarArrayHighBound(Result, 1)] := V;
end;

function NullIfEmptyValue;
begin
    Result := V;
    if VarIsNull(Result) then
        Exit;
    case varType of
        varSmallint, varInteger:
            if CompareVar(Result, 0) then
                Result := NULL;
        varSingle, varDouble, varCurrency, varDate:
            if CompareVar(Result, 0.00) then
                Result := NULL;
        varString:
            if CompareVar(Result, '') then
                Result := NULL;
    end;
end;

function CompareVar;
var
    I: Integer;
begin
    Result := False;
    if not VarIsArray(V1) then
    begin
        try
            if not (V1 = V2) then
                Exit;
        except
            Exit;
        end;
    end
    else
    begin
        for I := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
            if not CompareVar(V1[I], V2[I]) then
                Exit;
    end;
    Result := True;
end;

function IncludeInVarArray;
begin
    if not VarIsArray(V) then
        MyRaiseException('Esta variável não é do tipo array')
    else
    begin
        Result := V;
        VarArrayRedim(Result, VarArrayHighBound(Result, 1) + 1);
        Result[VarArrayHighBound(Result, 1)] := InclVar;
    end;
end;

function InSet;
var
    I: Integer;
begin
    Result := True;
    for I := Low(ArVar) to High(ArVar) do if CompareVar(V, ArVar[I]) then
        Exit;
    Result := False;
end;

function NullInVar;
var
    I: Integer;
begin
    if not VarIsArray(V) then
        Result := VarIsNull(V)
    else
    begin
        Result := False;
        for I := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
            if VarIsNull(V[I]) then
            begin
                Result := True;
                Exit;
            end;
    end;
end;

function ReadSystemConfig2(Grupo, Secao, Padrao: String): String;
var
    SysFile: TMemIniFile;
begin

    if not FileExists(GetCurrentDir() + '\System.ini') then
    begin
        MessageDlg('Erro:'#13#10'ReadSystemConfig2('+Grupo+','+Secao+','+Padrao+');'#13#10+
            'Arquivo "System.ini" não encontrado no caminho'#13#10+
            '"'+GetCurrentDir()+'"', mtError, [mbOk], 0);
        Exit;
    end;

    SysFile := TMemIniFile.Create(GetCurrentDir() + '\System.ini');
    Result := SysFile.ReadString(Grupo, Secao, 'XXXOOO');
    if Result = 'XXXOOO' then
        Result := Padrao;
    SysFile.Free;
end;

function ReadSystemConfig;
begin

    if not FileExists(GetCurrentDir() + '\System.ini') then
    begin
        MessageDlg('Erro:'#13#10'WriteConfig('+Section+','+Ident+','+Default+');'#13#10+
            'Arquivo "System.ini" não encontrado no caminho'#13#10+
            '"'+GetCurrentDir()+'"', mtError, [mbOk], 0);
        Exit;
    end;

    with TMemIniFile.Create(GetCurrentDir() + '\System.ini') do
    try
        case VarType(Default) of
            varString:
                Result := ReadString(Section, Ident, Default);
            varInteger, varSmallInt:
                Result := ReadInteger(Section, Ident, Default);
            varBoolean:
                Result := ReadBool(Section, Ident, Default);
            varSingle, varDouble, varCurrency:
                Result := ReadFloat(Section, Ident, Default);
        else
            raise Exception.Create('Unknow variant type');
        end;
    finally
        Free;
    end;
end;

procedure WriteSystemConfig;
begin

    if not FileExists(GetCurrentDir() + '\System.ini') then
    begin
        MessageDlg('Erro:'#13#10'WriteConfig('+Section+','+Ident+','+Value+');'#13#10+
            'Arquivo "System.ini" não encontrado no caminho'#13#10+
            '"'+GetCurrentDir()+'"', mtError, [mbOk], 0);
        Exit;
    end;

    with TMemIniFile.Create(GetCurrentDir() + '\System.ini') do
        try
            case VarType(Value) of
                varString:
                    WriteString(Section, Ident, Value);
                varInteger, varSmallInt:
                    WriteInteger(Section, Ident, Value);
                varBoolean:
                    WriteBool(Section, Ident, Value);
                varSingle, varDouble, varCurrency:
                    WriteFloat(Section, Ident, Value);
            else
                raise Exception.Create('Unknow variant type');
            end;
            UpdateFile;
        finally
            Free;
        end;
end;

function ReadIniFile;
begin
    with TMemIniFile.Create(InifileName) do
        try
            case VarType(Default) of
                System.varString:
                    Result := ReadString(Section, Ident, Default);
                varInt64, varInteger, varSmallInt:
                    Result := ReadInteger(Section, Ident, Default);
                varBoolean:
                    Result := ReadBool(Section, Ident, Default);
                varSingle, varDouble, varCurrency:
                    Result := ReadFloat(Section, Ident, Default);
            else
                raise Exception.Create('Unknow variant type');
            end;
        finally
            Free;
        end;
end;

procedure WriteIniFile;
begin
    with TMemIniFile.Create(InifileName) do
        try
            case VarType(Default) of
                varString:
                    WriteString(Section, Ident, Default);
                varInteger, varSmallInt:
                    WriteInteger(Section, Ident, Default);
                varBoolean:
                    WriteBool(Section, Ident, Default);
                varSingle, varDouble, varCurrency:
                    WriteFloat(Section, Ident, Default);
            else
                raise Exception.Create('Unknow variant type');
            end;
        finally
            UpdateFile;
            Free;
        end;
end;


procedure ReadIniFileSection;
begin
    with TMemIniFile.Create(InifileName) do
        try
            ReadSectionValues(Section, Strings);
        finally
        Free;
        end;
end;

procedure ReadSTCSectionItems;
var
    I, J: Integer;
begin
    with TMemIniFile.Create(AppInfo.NetFileDir + '\' + FILE_TABLES) do
        try
            ReadSectionValues(Section, FStrings);
            for I := 0 to FStrings.Count - 1 do
            begin
                J := Pos('=', FStrings[I]);
                if J > 0 then
                    FStrings[I] := MySubs(FStrings[I], J + 1, -1);
            end;
        finally
            Free;
        end;
end;

procedure ReadSTCSectionValues;
begin
    with TMemIniFile.Create(AppInfo.NetFileDir + '\' + FILE_TABLES) do
        try
            ReadSection(Section, FStrings);
        finally
            Free;
        end;
end;

procedure ReadSTCSection;
begin
    with TMemIniFile.Create(AppInfo.NetFileDir + '\' + FILE_TABLES) do
        try
            ReadSectionValues(Section, FStrings);
        finally
            Free;
        end;
end;

function ReadConfig;
var
    f: String;
begin
    f := GetCurrentDir() + '\Configs.ini';
    if not FileExists(f) then
    begin
        with TStringList.Create() do
        begin
            Clear();
            SaveToFile(f);
            Free;
        end;
        if not FileExists(f) then
        begin
            MessageDlg('Erro:'#13#10'WriteConfig('+Section+','+Ident+','+Default+');'#13#10+
                'Arquivo "Configs.ini" não encontrado no caminho'#13#10+
                '"'+GetCurrentDir()+'"', mtError, [mbOk], 0);
            Exit;
        end;
    end;
    with TIniFile.Create(f) do
        try
            case VarType(Default) of
                varString:
                    Result := ReadString(Section, Ident, Default);
                varInteger, varSmallInt:
                    Result := ReadInteger(Section, Ident, Default);
                varBoolean:
                    Result := ReadBool(Section, Ident, Default);
                varSingle, varDouble, varCurrency:
                    Result := ReadFloat(Section, Ident, Default);
            end;
        finally
            Free;
        end;
end;

procedure WriteConfig;
var
    f: String;
begin
    f := GetCurrentDir() + '\Configs.ini';
    if not FileExists(f) then
    begin
        with TStringList.Create() do
        begin
            Clear();
            SaveToFile(f);
            Free;
        end;
        if not FileExists(f) then
        begin
            MessageDlg('Erro:'#13#10'WriteConfig('+Section+','+Ident+','+Value+');'#13#10+
                'Arquivo "Configs.ini" não encontrado no caminho'#13#10+
                '"'+GetCurrentDir()+'"', mtError, [mbOk], 0);
            Exit;
        end;
    end;

    with TIniFile.Create(f) do
        try
            case VarType(Value) of
                varString:
                    WriteString(Section, Ident, Value);
                varInteger, varSmallInt:
                    WriteInteger(Section, Ident, Value);
                varBoolean:
                    WriteBool(Section, Ident, Value);
                varSingle, varDouble, varCurrency:
                    WriteFloat(Section, Ident, Value);
            end;
        finally
            Free;
        end;
end;

function StringPart;
var
    I, J, K: Integer;
begin
    Result := '';
    J := 0; I := 0;
    repeat
        K := System.Pos(DelimChar, Copy(S + DelimChar, J + 1, Length(S) + 1));
        if K = 0 then
            Exit;
        Inc(I);
        if I = Pos then
            Break;
        Inc(J, K);
    until False;
    Result := Copy(S, J + 1, System.Pos(DelimChar, Copy(S + DelimChar, J + 1, Length(S) + 1)) - 1);
end;

function StringPartCount;
var
    J, K: Integer;
begin
    Result := 0;
    J := 0;
    repeat
        K := System.Pos(DelimChar, Copy(S + DelimChar, J + 1, Length(S) + 1));
        if K = 0 then
            Exit;
        Inc(Result);
        Inc(J, K);
    until False;
end;

function StringPartPos;
begin
    for Result := 1 to StringPartCount(S, DelimChar) do
        if StringPart(S, DelimChar, Result) = Subs then
            Exit;
    Result := -1;
end;

function Extenso(Valor: Currency; const MoedaSing: String = 'Real'; const MoedaPlural: String = 'Reais'; const CentSing: String = 'Centavo'; const CentPlural: String = 'Centavos'): string;
type
    TDigito = '0'..'9';
    TTypeDigit = (dig1_9, dig10_19, digDez, digCem );
const
    Nomes1_9: array[ '0'..'9' ] of string =
        ('',
        'Um',
        'Dois',
        'Três',
        'Quatro',
        'Cinco',
        'Seis',
        'Sete',
        'Oito',
        'Nove' );
    Nomes10_19: array[ '0'..'9' ] of string =
        ('Dez',
        'Onze',
        'Doze',
        'Treze',
        'Quatorze',
        'Quinze',
        'Dezesseis',
        'Dezessete',
        'Dezoito',
        'Dezenove');
    NomesDez: array[ '0'..'9' ] of string =
        ('',
        '',
        'Vinte',
        'Trinta',
        'Quarenta',
        'Cinquenta',
        'Sessenta',
        'Setenta',
        'Oitenta',
        'Noventa');
    NomesCem: array[ '0'..'9' ] of string =
        ('',
        'Cento',
        'Duzentos',
        'Trezentos',
        'Quatrocentos',
        'Quinhentos',
        'Seicentos',
        'Setecentos',
        'Oitocentos',
        'Novecentos');

    function tbRCopy(const S: string; PosStart, nChar: integer): string;
    begin
        if Length(S) < PosStart then
            Result := ''
        else
            Result := Copy(S, Length(S) - (PosStart + nChar) + 2, nChar);
    end;

    function tbPadL(const S: string; Len: integer; Repl: string = ''): string;
    begin
        if Repl = '' then
            Repl := ' ';
        Result := S;
        while Length(Result) < Len do
            Result := Repl + Result;
        Result := tbRCopy(Result, 1, Len);
    end;

    function ExtensoDigito(Digito: Char; Tipo: TTypeDigit): string;
    begin
        case Tipo of
            dig1_9:   Result := Nomes1_9[ Digito ];
            dig10_19: Result := Nomes10_19[ Digito ];
            digDez:   Result := NomesDez[ Digito ];
            digCem:   Result := NomesCem[ Digito ]
        else
            Result := '<Erro ExtensoDigito>';
        end;
    end;

    function Extenso1_999(Valor: Cardinal): string;
    var
        sUni, sDez, sCem, S: string;
    begin
        Result := '';
        if Valor > 999 then
            Result := '<Erro Extenso1_999>'
        else
        begin
            S := FormatFloat('000', Valor);
            if S = '100' then
                Result := 'Cem'
            else
            begin
                sCem := ExtensoDigito( S[1], digCem );
                if S[2] = '1' then
                    sDez := ExtensoDigito( S[3], dig10_19 )
                else
                begin
                    sDez := ExtensoDigito( S[2], digDez );
                    sUni := ExtensoDigito( S[3], dig1_9 );
                end;
                Result := sCem;
                if (Result <> '') and (sDez <> '') then
                    Result := Result + ' e ';
                Result := Result + sDez;
                if (Result <> '') and (sUni <> '') then
                    Result := Result + ' e ';
                Result := Result + sUni;
            end;
        end;
    end;

var
    S, Temp: string;
    I, J: Cardinal;
begin
    Result := '';
    if Valor > 999999999999.99 then begin { Só transcreve até bilhões }
        Result := 'Valor Muito Extenso';
        Exit;
    end;

    S := FormatFloat( '0.00', Valor );
    S := tbPadL( S, 15, '0' );

    { Bilhões }
    I := StrToInt( Copy( S, 1, 3 ) );
    Temp := Extenso1_999( I );
    if Temp <> '' then
    begin
        if I = 1 then
            Temp := Temp + ' Bilhão'
        else
            Temp := Temp + ' Bilhões';
    end;
    Result := Temp;

    { Milhões }
    I := StrToInt( Copy( S, 4, 3 ) );
    Temp := Extenso1_999( I );
    if Temp <> '' then
    begin
        if I = 1 then
            Temp := Temp + ' Milhão'
        else
            Temp := Temp + ' Milhões';
    end;
    if (Result <> '') and (Temp <> '') then
        Result := Result + ', ';
    Result := Result + Temp;

    { Mil }
    I := StrToInt( Copy( S, 7, 3 ) );
    Temp := Extenso1_999( I );
    if Temp <> '' then
        Temp := Temp + ' Mil';
    if (Result <> '') and (Temp <> '') then
        Result := Result + ', ';
    Result := Result + Temp;

    { Unidades }
    I := StrToInt( Copy( S, 10, 3 ) );
    Temp := Extenso1_999( I );
    if (Result <> '') and (Temp <> '') then
        Result := Result + ', ';
    Result := Result + Temp;

    if Result <> '' then
    begin
        if Valor < 2 then
            Result := Result + ' ' + MoedaSing
        else
        begin
            if (tbRCopy( Result, 1, 2 ) = 'ão') or (tbRCopy( Result, 1, 3 ) = 'ões') then
                Result := Result + ' de';
            Result := Result + ' ' + MoedaPlural;
        end;
    end;

    { Centavos }
    I := StrToInt( Copy( S, 14, 2 ) );
    Temp := Extenso1_999( I );
    if Temp <> '' then
    begin
        if I = 1 then
            Temp := Temp + ' ' + CentSing
        else
            Temp := Temp + ' ' + CentPlural;
    end;
    if (Result <> '') and (Temp <> '') then
        Result := Result + ', ';
    Result := Result + Temp;

    { Troca a útima vírgula por  'e' }
    for J := Length( Result ) downto 1 do
        if Result[J] = ',' then
        begin
            Delete( Result, J, 1 );
            Insert( ' e', Result, J );
            Break;
        end;
end;

function ExtensoDeGrana;
begin
    Result := Extenso(Valor, 'Real', 'Reais', 'Centavo', 'Centavos')
end;

function ExtToTransNum;
begin
    Result := MyLeft(FormatFloat(StringOfChar('0', Count), N), Count);
end;

function StrToTransStr;
begin
    Result := PadR(UpperCase(PlainText(S, True)), Count);
end;

function DateToTransDate;
begin
    Result := PadR(FormatDateTime('ddmmyy', D), 6);
end;

function DateToTransDate2;
begin
    Result := PadR(FormatDateTime('yymmdd', D), 6);
end;

function DateToTransDateMask;
begin
    Result := PadR(FormatDateTime(Mask, D), Length(Mask));
end;

function TransNumToCurr;
begin
    Result := MyRound(StrToCurr(S) / 100, 2);
end;

function TransNumToInt;
begin
    Result := StrToInt(S);
end;

function TransStrToStr;
begin
    Result := TrimRight(S);
end;

function TransDateToDateTime;
    function GetDateOrder(const DateFormat: string): TDateOrder;
    var
        I: Integer;
    begin
        Result := doMDY;
        I := 1;
        while I <= Length(DateFormat) do
        begin
            case Chr(Ord(DateFormat[I]) and $DF) of
                'E': Result := doYMD;
                'Y': Result := doYMD;
                'M': Result := doMDY;
                'D': Result := doDMY;
            else
                Inc(I);
                Continue;
            end;
            Exit;
        end;
        Result := doMDY;
    end;

    function FDay: string;
    begin
        Result := Copy(S, 1, 2);
    end;

    function FMonth: string;
    begin
        Result := Copy(S, 3, 2);
    end;

    function FYear: string;
    begin
        Result := Copy(S, 5, 2);
    end;
begin
    case GetDateOrder(ShortDateFormat) of
        doMDY: Result := StrToDate(FMonth + DateSeparator + FDay + DateSeparator + FYear);
        doDMY: Result := StrToDate(FDay + DateSeparator + FMonth + DateSeparator + FYear);
        doYMD: Result := StrToDate(FYear + DateSeparator + FMonth + DateSeparator + FDay);
    else
        raise Exception.Create('Formato de data inválido');
    end;
end;

function TransDate2ToDateTime;
begin
    Result := EncodeDate(StrToInt(MySubs(S, 1, 4)), StrToInt(MySubs(S, 5, 2)), StrToInt(MySubs(S, 7, 2)));
end;

function TransDateDDMMAAAAToDateTime;
begin
    Result :=
        EncodeDate(
            StrToInt(MySubs(S, 5, 4)),
            StrToInt(MySubs(S, 3, 2)),
            StrToInt(MySubs(S, 1, 2))
        );
end;

{Retorna o dígito verificador mod 11.}
function DV11;
var
    S: string;
    I, M: Integer;
begin
    Result := 0;
    S := VarAsString(Num);
    M := Length(S);
    for I := M downto 1 do
        Result := Result + (StrToInt(S[I]) * (9 - ((((M - I) + 1) - 1) mod 8)));
    Result := (Result mod 11) mod 10;
end;

function MyCutTime(ADate: TDateTime): TDateTime;
begin
    Result := Trunc(ADate);
end;

function ForceTime;
begin
    Result := Trunc(ADate);
    if not BeginOfDay then
        Result := Result + EncodeTime(23, 59, 59, 000);
end;

function ComDateTimeToStr;
begin
    Result := FormatDateTime('yyyy/mm/dd hh:nn:ss:zzz', DateTime);
end;

function ComStrToDateTime;
begin
    Result :=
        EncodeDate(
            StrToInt(MySubs(DateTime, 01, 4)),
            StrToInt(MySubs(DateTime, 06, 2)),
            StrToInt(MySubs(DateTime, 09, 2))
        )
        +
        EncodeTime(
            StrToInt(MySubs(DateTime, 12, 2)),
            StrToInt(MySubs(DateTime, 15, 2)),
            StrToInt(MySubs(DateTime, 18, 2)),
            StrToInt(MySubs(DateTime, 21, 3))
        );
end;

function MyCompareText;
begin
    Result := S2 = MyLeft(S1, Length(S2));
end;

function MyLikeText;
begin
    Result := S1 = MyLeft(S2, Length(S1));
end;

procedure EditText;
var
  FPath: array[0..MAX_PATH + 1] of Char;
  Flag: Boolean;
begin
    with TStringList.Create do
        try
            if IsFile then
            begin
                LoadFromFile(S);
                StrPCopy(FPath, S);
                Flag := Count > 0;
            end
            else
            begin
                Text := S;
                StrPCopy(FPath, ArqTemp('txt'));
                SaveToFile(StrPas(FPath));
                Flag := True;
            end;
        finally
            Free;
        end;
    if Flag then
        ShellExecute(Application.Handle, 'Open', FPath, '', '', SW_SHOW);
end;

procedure MyConcat;
begin
    S := S + Subs;
end;

function ConcordaEmNumero;
begin
    if N > 1 then
    begin
        if Plural = '' then
            Result := Singular
        else
            Result := Plural;
    end
    else if not (Plural = '') then
        Result := Singular;
    Result := S + Result;
end;

function ConcordaEmGenero;
begin
    if Gen = 1 then
        Result := Masculino
    else
        Result := Feminino;
end;

function InvertString;
var
    I: Integer;
begin
    Result := '';
    for I := Length(S) downto 1 do
        MyConcat(Result, S[I]);
end;

procedure MySetPropValue;
var
    I: Integer;
begin
    for I := Low(Objects) to High(Objects) do
        SetPropValue(Objects[I], PropName, PropValue);
end;

function ParamValue;
var
    S: string;
begin
    Result := NULL;
    with Params do
    begin
        try
            S := Values[Param];
            if S = '' then
                S := Default;
            Result := VarAsType(S, VarType);
        except
            on E: Exception do
            begin
                case VarType of
                    varByte, varSmallint, varInteger:
                        S := 'Integer';
                    varDouble:
                        S := 'Float';
                    varCurrency:
                        S := 'Currency';
                    varDate:
                        S := 'Date/Time';
                    varBoolean:
                        S := 'Boolean';
                    varString:
                        S:= 'String';
                else
                    S := 'Desconhecido';
                end;
                E.Message := 'O valor ''' + Values[Param] + ''' do parâmetro ''' + Param + ''' não pode ser convertido para o tipo ''' + S + '''.' + LINE_FEED2 + 'Verifique o parâmetro informado e tente novamente.';
                raise;
            end;
        end;
    end;
end;

procedure MyAssert;
begin
    if not Condition then raise Exception.Create(ErrorMessage);
end;

procedure Nunca;
begin
    if Msg = '' then Msg := 'Condição inválida.';
        Assert(False, Msg);
end;

procedure SaveText;
begin
    with TStringList.Create do
        try
            Text := TheText;
            SaveToFile(FileName);
        finally
            Free;
        end;
end;

function SubSet;
    function VarRecValue(VarRec: TVarRec): Variant;
    begin
        with VarRec do
        begin
            case VType of
                vtInteger:
                    Result := IntToStr(VInteger);
                vtBoolean:
                    Result := VBoolean;
                vtChar:
                    Result := VChar;
                vtExtended:
                    Result := FloatToStr(VExtended^);
                vtString:
                    Result := VString^;
                vtObject:
                    Result := VObject.ClassName;
                vtClass:
                    Result := VClass.ClassName;
                vtAnsiString:
                    Result := string(VAnsiString);
                vtCurrency:
                    Result := CurrToStr(VCurrency^);
                vtVariant:
                    Result := string(VVariant^);
                vtInt64:
                    Result := IntToStr(VInt64^);
            end;
        end;
    end;
var
    I: Integer;
begin
    Result := NULL;
    for I := Low(Values) to High(Values) do
        if AnsiSameText(VarAsString(Value), VarAsString(VarRecValue(Values[I]))) then
        begin
            Result := VarRecValue(Items[I]);
            Break;
        end;
end;

function IncludeByteSet;
begin
    Result := ByteSet or ByteSubSet;
end;

function DiferencaIrrisoria(Diff: Double): Boolean;
begin
    Result := Abs(Diff) < 0.005;
end;

function Nomenclatura(S: string): string;
begin
    Result := ReadSystemConfig('Nomenclaturas', S, S);
end;

function IsEmptyStr;
begin
    Result := S = EmptyStr;
end;

function VarZeroValue;
begin
    case VarType of
        varSmallint, varInteger, varByte:
            Result := 0;
        varSingle, varDouble, varCurrency:
            Result := 0.00;
        varDate:
            Result := 0.00;
        varBoolean:
            Result := False;
        varString:
            Result := '';
    else
        Result := NULL;
    end;
end;

function VarConvert;
begin
    if VarIsNull(V) or (VarAsString(V) = '') then
        Result := VarZeroValue(VarType)
    else
        Result := VarAsType(V, VarType);
end;

function ParamValueStrDelim;
begin
    with TStringList.Create do
        try
            CommaText := StrTrans(Params, ';', ',');
            Result := VarConvert(Values[Param], varType);
        finally
            Free;
        end;
end;

function VarToDelimStr;
var
    I: Integer;
begin
    if not VarIsArray(V) then
        Result := VarToStr(V)
    else
    begin
        Result := '';
        for I := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
            Result := Result + VarToDelimStr(V[I], DelimStr) + DelimStr;
        Delete(Result, Length(Result), 1);
    end;
end;

function DelimStrToVar;
var
    I, J: Integer;
begin
    J := StringPartCount(S, DelimChar);
    Result := MyVarArrayCreate(J, NULL);
    for I := 1 to J do
        Result[I] := VarAsType(StringPart(S, DelimChar, I), VarType);
end;

function MyVarArrayCreate;
var
    I: Integer;
begin
    Result := VarArrayCreate([0, Bounds - 1], varVariant);
    for I := 0 to Bounds -1 do
        Result[I] := Default;
end;

function MyVarArrayHighBound;
begin
    Result := VarArrayHighBound(A, 1);
end;

function PrimeiraLetraCaps;
begin
    Result := AnsiUpperCase(MyLeft(S, 1)) + MySubs(S, 2);
end;



function StrToChar;
begin
    if S = '' then
        Result := ' '
    else
        Result := S[1];
end;

procedure Sugestao(Form: TForm; Tabela: TDataSet; Sugestao: Boolean);
var
    I: Integer;
    S: string;
begin
    try
        for I := 0 to Tabela.FieldCount - 1 do
            if Sugestao then
            begin
                S := ReadConfig(Form.Name,Tabela.Fields.Fields[I].Name, '');
                if S = '' then
                    Tabela.Fields[I].Clear
                else
                    Tabela.Fields[I].AsString := S;
            end
            else
            begin
                if Tabela.Fields[I].IsNull then
                    S := ''
                else
                    S := Tabela.Fields[I].AsString;
                WriteConfig(Form.Name, Tabela.Fields[I].Name, S);
            end;
    except
    end;
end;


function DirectoryFilesList(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true): TStrings;
var
	i: integer;
	listatemp, listatemp2: TStrings;

	procedure ListarDiretorios(Folder: string; lista: Tstrings);
	var
		Rec: TSearchRec;
		i: integer;
		temps: string;
  	begin
		lista.Clear;
		if SysUtils.FindFirst(Folder + '*', faDirectory, Rec) = 0 then
			try
				repeat
					lista.Add(rec.Name);
				until SysUtils.FindNext(Rec) <> 0;
			finally
				if lista.count <> 0 then
				begin
				// deleta o diretorio ..
				lista.Delete(1);
				// deleta o diretorio .
				lista.Delete(0);
		        i := 0;
				//deleta os arquivos isto e fica apenas os diretorios
				if lista.count <> 0 then
				begin
					repeat
						temps := lista.Strings[i];
						temps := extractfileext(temps);
						if temps <> '' then
							lista.Delete(i)
						else
							inc(i);
					until i >= lista.Count;
				end;
			end;
		end;
	end;

	procedure ListarAtahos(Folder, mask: string; Lista: Tstrings);
	var
		Rec: TSearchRec;
	begin
		lista.Clear;
		if SysUtils.FindFirst(Folder + mask, faAnyFile, Rec) = 0 then
			try
				repeat
					lista.Add(rec.Name);
				until SysUtils.FindNext(Rec) <> 0;
			finally
				SysUtils.FindClose(Rec);
			end;
	end;

	procedure AddLIstInOther(ListSource, ListDestino: TStrings);
	var
		f: integer;
	begin
		for f := 0 to ListSource.Count - 1 do
		begin
			ListDestino.Add(ListSource.Strings[f]);
		end;
	end;

begin
	listatemp := TStringList.Create;
	listatemp2 := TStringList.Create;
	ListarAtahos(diretorioInicial, mascara, listatemp);
	if listtotaldir = true then
	begin
		for i := 0 to listatemp.Count - 1 do
		begin
			listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];
		end;
	end;
	AddLIstInOther(listatemp, listatemp2);
	if recursive = true then
	begin
		ListarDiretorios(diretorioInicial, listatemp);
		for i := 0 to listatemp.Count - 1 do
		begin
			DirectoryFilesList(diretorioInicial + listatemp.Strings[i] + '\', mascara, listtotaldir, recursive);
		end;
	end;
	listatemp.Free;
	result := listatemp2;
end;


function RegisterActiveXServer(const ServerLocation: string; Register: Boolean): Boolean;
var
	ServerDllRegisterServer: function: HResult; stdcall;
	ServerDllUnregisterServer: function: HResult; stdcall;
	ServerHandle: THandle;

	procedure UnloadServerFunctions;
	begin
		@ServerDllRegisterServer := nil;
		@ServerDllUnregisterServer := nil;
		FreeLibrary(ServerHandle);
	end;

	function LoadServerFunctions: Boolean;
	begin
		Result := False;
		ServerHandle := SafeLoadLibrary(ServerLocation);
		if (ServerHandle <> 0) then
		begin
			@ServerDllRegisterServer := GetProcAddress(ServerHandle, 'DllRegisterServer');
			@ServerDllUnregisterServer := GetProcAddress(ServerHandle, 'DllUnregisterServer');
			if (@ServerDllRegisterServer = nil) or (@ServerDllUnregisterServer = nil) then
				UnloadServerFunctions
			else
				Result := True;
		end;
	end;

begin
	Result := False;
	try
		if (LoadServerFunctions) then
			try
				case (Register) of
					False: Result := ServerDllUnregisterServer = S_OK;
					True: Result := ServerDllRegisterServer = S_OK;
				end;
			finally
				UnloadServerFunctions;
			end;
	except
	end;
end;



{**********************************************************
                Funcoes Usadas na Trava
**********************************************************}


function KeyGen(S, K: string): string;
var
	I, JK, JS: Byte;
begin
    Result := '';
    for I := 1 to Length(S) do
    begin
        JK := StrToInt('$' + K[I mod Length(K) + 1]);
        JS := StrToInt('$' + S[I]);
        Result := Result + Format('%.1x', [JK xor JS]);
    end;
end;

function Cripto(S, K: string): string;
begin
    Result := KeyGen(S, K);
end;

function Decripto(S, K: string): string;
begin
    Result := KeyGen(S, K);
end;

function CriptoDate(DateTime: Real): string;
var
    I: Integer;
begin
    Randomize;
    I := Random(98)+1;
    Result := Cripto(FloatTOStr(DateTime),FormatFloat('00',I)) + FormatFloat('00',I);
end;

function DeCriptoDate(Key: String): TDateTime;
begin
	Result := StrToFloat(Cripto(Copy(Key,1,Length(Key)-2),MyRight(Key,2)));
end;


function ReadAccess;
begin
	with TIniFile.Create(ArqSis('Acesso.ini')) do
		try
			Result := ReadString(Section, Ident, Default);
		finally
			Free;
		end;
end;

procedure WriteAccess;
begin
	with TIniFile.Create(ArqSis('Acesso.ini')) do
		try
			WriteString(Section, Ident, Value);
		finally
			Free;
		end;
end;

procedure PostDate;
begin
	if DecriptoDate(ReadAccess('Licença','Data','')) < Date() then
		WriteAccess('Licença','Data',CriptoDate(Date()));
end;

function CheckDate: Boolean;
begin
	if ReadAccess('Licença','Data','') <> '' then
		if (DecriptoDate(ReadAccess('Licença','Data','')) > Date()) then
		begin
			Result := False;
			Erro('A data é menor que a data do último acesso'+#13+
						 'a  esta  aplicação. Atualize a data  de  seu'+#13+
						 'computador  ou  entre  em  contato  com  a'+#13+
						 'Solução Sistemas. Telefone: (85) 261.9661.'+#13+
						 'Último acesso: '+ DateToStr(DecriptoDate(ReadAccess('Licença','Data','')))+'.');
		end
        else
            Result := True;
end;


{*** Envia comando para o dos e retorna a captura ***}
function GetConsoleOutput(const CommandLine:string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutFile, AppProcess, AppThread : THandle;
  RootDir, WorkDir, StdOutFileName:string;
const
  FUNC_NAME = 'GetConsoleOuput';
begin
  try
    StdOutFile:=0;
    AppProcess:=0;
    AppThread:=0;
    Result:='';

    // Initialize dirs
    RootDir:=ExtractFilePath(ParamStr(0));
    WorkDir:=ExtractFilePath(CommandLine);

    // Check WorkDir
    if not (FileSearch(ExtractFileName(CommandLine),WorkDir)<>'') then
        WorkDir:=RootDir;

   // Initialize output file security attributes
    FillChar(SA,SizeOf(SA),#0);
    SA.nLength:=SizeOf(SA);
    SA.lpSecurityDescriptor:=nil;
    SA.bInheritHandle:=True;

    // Create Output File
    StdOutFileName:=RootDir+'output.tmp';
    StdOutFile:=CreateFile(PChar(StdOutFileName),
                   GENERIC_READ or GENERIC_WRITE,
                   FILE_SHARE_READ or FILE_SHARE_WRITE,
                   @SA,
                   CREATE_ALWAYS, // Always create it
                   FILE_ATTRIBUTE_TEMPORARY or // Will cache in memory
                                               // if possible
                   FILE_FLAG_WRITE_THROUGH,
                   0);

    // Check Output Handle
    if StdOutFile = INVALID_HANDLE_VALUE then
      raise Exception.CreateFmt('Function %s() failed!' + #10#13 +
        'Command line = %s',[FUNC_NAME,CommandLine]);

    // Initialize Startup Info
    FillChar(SI,SizeOf(SI),#0);
    with SI do begin
      cb:=SizeOf(SI);
      dwFlags:=STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow:=SW_HIDE;
      hStdInput:=GetStdHandle(STD_INPUT_HANDLE);
      hStdError:=StdOutFile;
      hStdOutput:=StdOutFile;
    end;

    // Create the process
    if CreateProcess(nil, PChar(CommandLine), nil, nil,
                     True, 0, nil,
                     PChar(WorkDir), SI, PI) then begin
      WaitForSingleObject(PI.hProcess,INFINITE);
      AppProcess:=PI.hProcess;
      AppThread:=PI.hThread;
      end
    else
      raise Exception.CreateFmt('CreateProcess() in function %s() failed!'
                   + #10#13 + 'Command line = %s',[FUNC_NAME,CommandLine]);

    CloseHandle(StdOutFile);
    StdOutFile:=0;

    with TStringList.Create do
    try
      LoadFromFile(StdOutFileName);
      Result:=Text;
    finally
      Free;
    end;

  finally
    // Close handles
    if StdOutFile <> 0 then CloseHandle(StdOutFile);
    if AppProcess <> 0 then CloseHandle(AppProcess);
    if AppThread <> 0 then CloseHandle(AppThread);

    // Delete Output file
    if FileExists(StdOutFileName) then SysUtils.DeleteFile(StdOutFileName);
  end;

end;


{*
* @Author:
*   Nelson Carlson Filho (ncarlsonf@gmail.com)
* @About:
*   A rotina recebe um form/datamodule e busca todos os
*   componentes de conexão.  Ao encontra-los conecta.
*   caso ocorram erros retorna uma string não vazia contendo os erros.
*}

function connConnect(form: TComponent; closeApp: boolean): String;
var
    conn: TAdoConnection;
    dm: TDataModule;
    fm: TForm;
    i: Integer;
begin

    result := '';
    if (form is TForm) then
    begin
        fm := TForm(form);
        for i := 1 to fm.ComponentCount do
        begin
            if fm.Components[i-1] is TAdoConnection then
            begin
                conn := TAdoConnection(fm.Components[i-1]);
                if conn.Connected then
                    conn.Close();
                conn.ConnectionString := fnGetStrConnect();
                conn.LoginPrompt := false;
                try
                conn.Open();
                except
                    on e: Exception do
                    begin
                        result := result + #13#10 + e.Message;
                        if closeApp then
                        begin
                            MessageDlg(result, mtError, [mbOk], 0);
                            Application.Terminate;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if (form is TDataModule) then
    begin
        dm := TDataModule(form);
        for i := 1 to dm.ComponentCount do
        begin
            if dm.Components[i-1] is TAdoConnection then
            begin
                conn := TAdoConnection(dm.Components[i-1]);
                if conn.Connected then
                    conn.Close();
                conn.ConnectionString := fnGetStrConnect();
                conn.LoginPrompt := false;
                try
                conn.Open();
                except
                    on e: Exception do
                    begin
                        result := result + #13#10 + e.Message;
                        if closeApp then
                        begin
                            MessageDlg(result, mtError, [mbOk], 0);
                            Application.Terminate;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if result <> '' then
        result := result + #13#10;

end;


{***
* Executa um arquivo chamando-o pelo programa associado a ele.
*}
procedure ExecFile(F: String);
var
    r: String;
begin
    case ShellExecute(Application.Handle, nil, PChar(F), nil, nil, SW_SHOWNORMAL) of
        ERROR_FILE_NOT_FOUND: r := 'O arquivo especificado não foi encontrado.';
        ERROR_PATH_NOT_FOUND: r := 'O caminho especificado não foi encontrado.';
        ERROR_BAD_FORMAT: r := 'O arquivo .EXE é inválido (não é um executável Win32 ou erro na imagem do arquivo).';
        SE_ERR_ACCESSDENIED: r := 'O sistema operacional não permitiu o acesso ao arquivo.';
        SE_ERR_ASSOCINCOMPLETE: r := 'A associação com o tipo de arquivo é incompleta ou inválida.';
        SE_ERR_DDEBUSY: r := 'A transação DDE não foi completada porque outra transação DDE já foi iniciada.';
        SE_ERR_DDEFAIL: r := 'A transação DDE falhou.';
        SE_ERR_DDETIMEOUT: r := 'A transação DDE não foi completada pois excedeu o tempo limite.';
        SE_ERR_DLLNOTFOUND: r := 'A dll especificada não foi encontrada.';
        SE_ERR_NOASSOC: r := 'A existe associação.';
        SE_ERR_OOM: r := 'Não foi possivel reservar memória para a conclusão do processo..';
        SE_ERR_SHARE: r := 'Violação no compartilhamento de memória.';
    else
        Exit;
    end;
    MessageDlg(r, mtError, [mbOk], 0);
end;

function RunAsAdmin(hWnd: HWND; filename: string; Parameters: string): Boolean;
{
    See Step 3: Redesign for UAC Compatibility (UAC)
    http://msdn.microsoft.com/en-us/library/bb756922.aspx
}
var
    sei: TShellExecuteInfo;
begin
    ZeroMemory(@sei, SizeOf(sei));
    sei.cbSize := SizeOf(TShellExecuteInfo);
    sei.Wnd := hwnd;
    sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
    sei.lpVerb := PChar('runas');
    sei.lpFile := PChar(Filename); // PAnsiChar;
    if parameters <> '' then
        sei.lpParameters := PChar(parameters); // PAnsiChar;
    sei.nShow := SW_SHOWNORMAL; //Integer;

    Result := ShellExecuteEx(@sei);
end;


function EncodeStr255(const S: string; K: string = ''): string;
var
	JK, JS: Byte;
  I, Lk: Integer;
  C: Char;
begin
  if K = '' then K := PANTERA_KEY;
  Result := '';
  try
    Lk := Length(K);
	  for I := 1 to Length(S) do
    begin
      C := PlainText(UpCase(K[(I mod Lk) + 1]))[1];
      case C of
        '0'..'9': JK := Ord(C) - Ord('0');
        'A'..'Z': JK := Ord(C) - Ord('A') + 10;
      else
        JK := 0;
      end;
      JS := Ord(S[I]);
      if (JK xor JS) = 0 then Erro('Caractere zero encontrado na criptografia.');
      Result := Result + Chr(JK xor JS);
    end;
  except
    Result := '';
    raise;
  end;
end;

function ReverseStr(const S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := Length(S) downto 1 do Result := Result + S[I];
end;

function CriptoStr255(const S: string; const Key: string = ''): string;
begin
  Result := EncodeStr255(ReverseStr(EncodeStr255(S, Key)), Key);
end;

function DeCriptoStr255(const S: string; const Key: string = ''): string;
begin
  Result := EncodeStr255(ReverseStr(EncodeStr255(S, Key)), Key);
end;

function StrCmp(s1: String; s2: String; cs: Boolean): integer;
var
    i, min: Integer;
begin
    result := 0;
    if not(cs) then
    begin
        s1 := AnsiLowerCase(s1);
        s2 := AnsiLowerCase(s2);
    end;

    if length(s1) < length(s2) then min := length(s1)
    else min := length(s2);

    if length(s1) > min then
        result := min + 1;

    if length(s2) > min then
        result := min + 1;

    for i := 1 to min do
    begin
        if s1[i] <> s2[i] then
        begin
            result := i;
            break;
        end;
    end;
end;

{ Substitui um texto ou caractere dentro da string}
function Replace(Text, Busca, Troca : string) : string;
var
  n,tam : integer;
begin
  tam:= length(busca);
  n := length(Text);
  while n > 0 do
  begin
    if UpperCase(Copy(Text,n,tam)) = UpperCase(Busca) then
    begin
      Delete(Text,n,tam);
      Insert(Troca,Text,n);
    end;
    dec(n);
    if n > length(Text) then
        n := length(Text);
  end;
  Result := Text;
end;

function StrReplace(Text, Busca, Troca: string) : string;
begin
    result := Replace(Text, Busca, Troca);
end;

function PalavrasComecamMaiusculas(Text: String): String;
var
    i: Integer;
    vIn, vOut: String;
begin
    vIn := Text;
    vOut := '';
    for i := 1 to length(vIn) do
    begin
        if i = 1 then
        begin
            vOut := UpperCase(vIn[i] + '');
        end
        else
        begin
            if vIn[i-1] = ' ' then
            begin
                if not((LowerCase(Copy(vIn,i,2)) = 'e ')
                    or (LowerCase(Copy(vIn,i,3)) = 'em ')
                    or (LowerCase(Copy(vIn,i,3)) = 'ou ')
                    or (LowerCase(Copy(vIn,i,3)) = 'de ')
                    or (LowerCase(Copy(vIn,i,3)) = 'da ')
                    or (LowerCase(Copy(vIn,i,3)) = 'do ')
                    or (LowerCase(Copy(vIn,i,4)) = 'das ')
                    or (LowerCase(Copy(vIn,i,4)) = 'dos ')
                    or (LowerCase(Copy(vIn,i,4)) = 'com ')
                    or (LowerCase(Copy(vIn,i,5)) = 'dela ')
                    or (LowerCase(Copy(vIn,i,6)) = 'delas ')
                    or (LowerCase(Copy(vIn,i,4)) = 'por ')
                    or (LowerCase(Copy(vIn,i,5)) = 'pela ')
                    or (LowerCase(Copy(vIn,i,6)) = 'pelos ')
                    or (LowerCase(Copy(vIn,i,6)) = 'pelas ')
                    or (LowerCase(Copy(vIn,i,5)) = 'para ')) then
                begin
                    vOut := VOut + UpperCase(vIn[i] + '')
                end
                else
                begin
                    vOut := vOut + LowerCase(vIn[i] + '');
                end;
            end
            else
                vOut := vOut + LowerCase(vIn[i] + '');
        end;
    end;
    Result := vOut;
end;

{A função CursorPos do objeto nativo Mouse retorna um ponto com as posições do mouse referente a coordenada (0,0) da TELA. Diferentemente, a função abaixo retorna um ponto TPoint com as posições X e Y do mouse com relação a coordenada (0,0) da JANELA passada como parâmetro.
Uso:
    GetMousePos(form1).X    retorna a posicao X do mouse
    GetMousePos(form1).Y    retorna a posicao Y do mouse
    GetMousePos(form1)       retorna um objeto Tpoint
IMPORTANTE: Se o mouse estiver fora da janela, as duas coordenadas são fixadas em -1. }
function GetMousePos(janela:TForm):TPoint;
var
    ponto: TPoint;
begin
    ponto := janela.ClientOrigin;
    ponto.x := mouse.CursorPos.x - ponto.x;
    ponto.y := mouse.CursorPos.y - ponto.y;
    if (ponto.x < 0)
        or (ponto.x > janela.Width)
        or (ponto.y < 0)
        or (ponto.y > janela.Height) then
    begin
        ponto.y := -1;
        ponto.x := -1;
    end;
    result := ponto;
end;

function InputPassword(const ACaption, APrompt: string; var Value: string): Boolean;
    function GetAveCharSize(Canvas: TCanvas): TPoint;
    var
      I: Integer;
      Buffer: array[0..51] of Char;
    begin
      for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
      for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
      GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
      Result.X := Result.X div 52;
    end;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        PasswordChar := '*';
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function LoginUser(conn: TAdoConnection; user: String; pass: String; admin: boolean): Boolean;
var
    qr: TAdoQuery;
    sel: String;
begin
    pass := CriptoStr255(pass, '');
    sel :=
        ' SELECT ' +
        '    1 ' +
        ' FROM Fornecedores f INNER JOIN Fornecedores_Regras fr ON f.Código = fr.Fornecedor ' +
        '	INNER JOIN Regras r ON fr.Regra = r.Código ' +
        ' WHERE ' +
        ' f.Nome = '#39 + user + #39' ' +
        ' AND f.Senha = '#39 + pass + #39' ';

    if admin then
        sel := sel + ' AND r.Descrição = '#39'ADMINISTRADORES'#39' ';

    qr := fnQrNew(conn, sel);
    qr.Open();
    result := (qr.RecordCount > 0);
    qr.Close;
    qr.Free();
end;

function getLoginDlg(conn: TAdoConnection; const tentativas: integer = 1): boolean;
var
    user, pass: String;
    tentar: boolean;
    tentativa, tentativas2: Integer;
begin
    result := false;
    tentativas2 := tentativas;
    if tentativas2 < 1 then
        tentativas2 := 1;
    if tentativas2 > 10 then
        tentativas2 := 10;

    user := '';
    pass := '';
    tentar := true;
    tentativa := 1;
    while (result = false) and (tentar) and (tentativa <= tentativas2) do
    begin
        with T_fmLoginDlg.Create(Application) do
        try
            edUser.Text := user;
            ShowModal();
            tentar := (ModalResult = mrOk);
            user := edUser.Text;
            pass := edPass.Text;
        finally
            Free();
        end;

        result := LoginUser(conn, user, pass, false);
        if (not result) and (tentar) then
        begin
            if ((Tentativas - Tentativa) > 0) then
                MessageDlg('Autenticação inválida. Você tem mais ' + IntToStr(Tentativas - Tentativa) + ' tentativas.', mtWarning, [mbOk], 0)
            else
                MessageDlg('Autenticação inválida.', mtWarning, [mbOk], 0)
        end;
        inc(tentativa);
    end;
end;


{ Obtém o caminho do Desktop }
{
    Constantes para  GetDesktopPath ... SHGetSpecialFolderLocation ...

    CSIDL_DESKTOP, CSIDL_INTERNET, CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS,
    CSIDL_PERSONAL, CSIDL_FAVORITES, CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO,
    CSIDL_BITBUCKET, CSIDL_STARTMENU, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES,
    CSIDL_NETWORK, CSIDL_NETHOOD, CSIDL_FONTS, CSIDL_TEMPLATES, CSIDL_COMMON_STARTMENU,
    CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTUP, CSIDL_COMMON_DESKTOPDIRECTORY,
    CSIDL_APPDATA, CSIDL_PRINTHOOD, CSIDL_ALTSTARTUP, CSIDL_COMMON_ALTSTARTUP,
    CSIDL_COMMON_FAVORITES, CSIDL_INTERNET_CACHE, CSIDL_COOKIES, CSIDL_HISTORY
}
function GetDeskTopPath(frmHandle: HWND): string;
var
  shellMalloc: IMalloc;
  ppidl: PItemIdList;
  PerDir: string;
begin
  ppidl := nil;
  try
    if SHGetMalloc(shellMalloc) = NOERROR then
    begin
      SHGetSpecialFolderLocation(frmHandle, CSIDL_DESKTOPDIRECTORY, ppidl);
      SetLength(Result, MAX_PATH);
      if not SHGetPathFromIDList(ppidl, PChar(Result)) then
        raise exception.create('SHGetPathFromIDList failed : invalid pidl');
      SetLength(Result, lStrLen(PChar(Result)));
    end;
    if ((length(result) > 0) and (result[length(result)] <> '\')) then
        result := result + '\';
  finally
   if ppidl <> nil then
         shellMalloc.free(ppidl);
  end;
end;


function SHAutoComplete(hwndEdit: HWND; dwFlags: dWord): LongInt; stdcall; external 'shlwapi.dll';

function MakeAutoComplete(hwndEdit: HWND): LongInt;
    const
      SHACF_AUTOSUGGEST_FORCE_ON = $10000000;
      SHACF_AUTOSUGGEST_FORCE_OFF = $20000000;
      SHACF_AUTOAPPEND_FORCE_ON = $40000000;
      SHACF_AUTOAPPEND_FORCE_OFF = $80000000;
      SHACF_DEFAULT = $0;
      SHACF_FILESYSTEM = $1;
      SHACF_URLHISTORY = $2;
      SHACF_URLMRU = $4;
      SHACF_URLALL = (SHACF_URLHISTORY or SHACF_URLMRU);
begin
    Result := shAutoComplete(hwndEdit, SHACF_FILESYSTEM);
end;

{Ao contrário do Sleep, o Delay permite que que o programa continue
a processar as mensagens do Windows (mouse, teclado, etc).}
procedure Delay(MSec: Cardinal);
var
  Start: Cardinal;
begin
  Start := GetTickCount;
  repeat
    Application.ProcessMessages;
  until (GetTickCount - Start) >= MSec;
end;

{Aplica Data/Hora de criação para um determinado arquivo. Se for bem sucedida
a operação retorna true.

    Exemplo de uso:

    var
      DataHora: TDateTime;
    begin
      -- Define a data para 5-Fev-1999 e a hora para 10:30
      DataHora := EncodeDate(1999, 2, 5) + EncodeTime(10, 30, 0, 0);
      if DefineDataHoraArq('c:\teste\logo.bmp', DataHora) then
        ShowMessage('Data/Hora do arquivo definida com sucesso.')
      else
        ShowMessage('Não foi possível definir data/hora do arquivo.');
    end; }
function FileSetDateTime(NomeArq: string; DataHora: TDateTime): boolean;
var
  F: integer;
begin
  Result := false;
  F := FileOpen(NomeArq, fmOpenWrite or fmShareDenyNone);
  try
    if F > 0 then
      Result := FileSetDate(F, DateTimeToFileDate(DataHora)) = 0;
  finally
    FileClose(F);
  end;
end;




////////////////////////////////////////////////////////////////////////////
///
// Procedure/Function : procedure ImpressoraOnLine
// Objetivo             : Verificar se a impressora esta on Line
// Autor                  : Maurício Grasser
// Data da Criação : 11/02/2005
// Parâmetros        : nenhum
// Retorno              : Cardinal
// Observaçoes      : Utilizada em conjunto com a função
//                              GetCurrentPrinterHandle
// Exemplo             : if ImpressoraOnLine = 0 then ShowMessage(''Impressora desligada'');
////////////////////////////////////////////////////////////////////////////
///

{
function ImpressoraOnLine: Cardinal;
var
   hPrinter    : THandle;
   pInfo       : PPrinterInfo2;
   bytesNeeded : DWORD;
begin
   hprinter := GetCurrentPrinterHandle;
   try
      Winspool.GetPrinter(hPrinter, 2, Nil, 0, @bytesNeeded);
      pInfo := AllocMem(bytesNeeded );
      try
         Winspool.GetPrinter(hPrinter, 2, pInfo, bytesNeeded, @bytesNeeded);
         Result := pInfo^.Status;
      finally
         FreeMem(pInfo);
       end;
    finally
       ClosePrinter(hPrinter);
    end;
end;

function GetCurrentPrinterHandle: THandle;
var
   Device, Driver, Port : array[0..255] of char;
   hDeviceMode: THandle;
begin
   Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
   if not OpenPrinter(@Device, Result, nil) then
      RaiseLastWin32Error;
end;

}

{*** BitsToLeft ***}
function BitsToLeft(i: Byte; n: Integer): Byte;
var
    x: Integer;
begin
    if (n <= 0) then
        n := 1;
    for x := 1 to n do
        i := (i shl 1) + (i shr 7);
    result := i;
end;

{*** BitsToRight ***}
function BitsToRight(i: Byte; n: Integer): Byte;
var
    x: Integer;
begin
    if (n <= 0) then
        n := 1;
    for x := 1 to n do
        i := (i shr 1) + (i shl 7);
    result := i;
end;

{*** BitsInvertSymetric ***}
function BitsInvertSymetric(i: Byte): Byte;
var
    j, k: Integer;
begin
    k := 0;
    for j := 1 to 8 do
    begin
        k := k + ((i and 1) * Round(power(2, (8-j))));
        i := (i shr 1);// + (i shl 7);
    end;
    result := Byte(k);
end;

function StrBool(v: String): boolean;
begin
    result := false;
    v := Trim(UpperCase(v));
    if (v = 'S') or (v = 'SIM') or (v = 'Y') or (v = 'YES') or (v = '1') or (v = 'T') or (v = 'TRUE')
        or (v = 'V') or (v = 'VERDADE') or (v = 'VERDADEIRO') or (v = 'OK') or (v = 'AFIRMATIVO')
        or (v = 'LIGADO') or (v = 'ACESO') or (v = 'CORRETO') or (v = 'CONFIRMADO') or (v = 'CERTO')
        or (v = 'COM CERTEZA') or (v = 'CERTAMENTE') or (v = 'ACEITO') or (v = 'PERMITIDO')
        or (v = 'TEM PERMISSÃO') or (v = 'LOGIN ACEITO') or (v = 'PERMISSÃO CONCEDIDA') then
    begin
        result := true;
    end;
end;

{Obtém o número de série da placa mãe}
function PlacaMaeSN(): String;
var
    a,b,c,d: LongWord;
    CPUID: string;
begin
    asm
    push EAX
    push EBX
    push ECX
    push EDX

    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX

    pop EDX
    pop ECX
    pop EBX
    pop EAX

    {
    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX
    }
    end;
    CPUID:=inttohex(a,8) + '-' + inttohex(b,8) + '-' + inttohex(c,8) + '-' + inttohex(d,8);
    Result := CPUID;
end;

function MacAddress: string;
var
    Lib: Cardinal;
    Func: function(GUID: PGUID): Longint; stdcall;
    GUID1, GUID2: TGUID;
begin
    Result := '';
    Lib := LoadLibrary('rpcrt4.dll');
    if Lib <> 0 then
    begin
        @Func := GetProcAddress(Lib, 'UuidCreateSequential');
        if Assigned(Func) then
        begin
            if (Func(@GUID1) = 0) and
                (Func(@GUID2) = 0) and
                (GUID1.D4[2] = GUID2.D4[2]) and
                (GUID1.D4[3] = GUID2.D4[3]) and
                (GUID1.D4[4] = GUID2.D4[4]) and
                (GUID1.D4[5] = GUID2.D4[5]) and
                (GUID1.D4[6] = GUID2.D4[6]) and
                (GUID1.D4[7] = GUID2.D4[7]) then
            begin
                Result := IntToHex(GUID1.D4[2], 2) + '-' +
                    IntToHex(GUID1.D4[3], 2) + '-' +
                    IntToHex(GUID1.D4[4], 2) + '-' +
                    IntToHex(GUID1.D4[5], 2) + '-' +
                    IntToHex(GUID1.D4[6], 2) + '-' +
                    IntToHex(GUID1.D4[7], 2);
            end;
        end;
    end;
end;

function MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then
  begin
    Result := I >= 0;
    while I < 0 do
    begin
      Result := ShowCursor(LongBool(true)) >= 0;
      Inc(I);
    end;
  end
  else
  begin
    Result := I < 0;
    while I >= 0 do
    begin
      Result := ShowCursor(LongBool(false)) < 0;
      Dec(I);
    end;
  end;
end;

function StrToAlfaNum(s: String): String;
var
    i: Integer;
    t: String;
begin
    t := UpperCase(s);
    result := '';
    for i := 1 to length(s) do
    begin
        if t[i] in [
                'A','B','C','D','E','F','G','H','I','J',
                'K','L','M','N','O','P','Q','R','S','T',
                'U','V','W','X','Y','Z','0','1','2','3',
                '4','5','6','7','8','9','_'] then
            result := result + s[i];
    end;
end;

{checa se uma string guarda o valor de um número inteiro}
function StrIsInteger(s: String): boolean;
var i: Integer; // 0 a 9223372036854775807
begin
    result := true;
    if ((length(s) = 0) or (length(s) > 19)) then
    begin
        result := false;
    end
    else
    begin
        for i := 1 to length(s) do
            if not(s[i] in ['0','1','2','3','4','5','6','7','8','9']) then
                result := false;
    end;
end;

function numParteInteira(n: Real): Integer;
var
    inteiro: String;
begin
    inteiro := IntToStr(Trunc(n));
    result := StrToInt(inteiro);
end;

function numParteFracionaria(n: Real; const digitos: Integer = 2): Integer;
var
    d: Double;
    fracionario: String;
begin
    if n < 0 then
        n := n * -1;
    d := n - Trunc(n);
    d := d * power(10, digitos);
    result := Round(d);
end;


{ checa se um arquivo está em uso }
function FileInUse(const FileName: String): Boolean;
var
    HFileRes: HFILE;
begin
    Result := False;
    if not FileExists(FileName) then
        Exit;
    HFileRes := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0 );
    Result := (HFileRes = INVALID_HANDLE_VALUE);
    if not Result then
        CloseHandle(HFileRes);
end;


function CharIndex(s: String; chr: char): Integer;
var
    i: Integer;
begin
    result := 0;
    for i := length(s) downto 1 do
        if s[i] = chr then
        begin
            result := i;
            break;
        end;

end;

function FileExtension(FileName: String): String;
var
    s: String;
begin
    result := '';
    s := LowerCase(ExtractFileName(FileName));
    if (length(s) > 0) and  (CharIndex(s, '.') > 0) and (s[length(s)] <> '.') then
    begin
        result := Copy(s, CharIndex(s, '.'), length(s));
    end;
end;

procedure StrSaveToFile(str: String; fileName: String);
var
    s: TStringList;
begin
    try
        s := TStringList.Create();
        s.Clear;
        s.Text := str;
        s.SaveToFile(fileName);
    finally
        s.Free;
    end;
end;

// Cria uma caixa de diálogo de data
function getDataDlg(var d: TDateTime; const MostrarHora: boolean = false): boolean;
begin
    d := StrToDate('01/01/1900');
    result := false;
    with T_fmDataDlg.Create(Application) do
    try
        dtData.Date := now();
        dtHora.Time := StrToTime('00:00:00');
        dtHora.Visible := MostrarHora;
        if (ShowModal() = mrOk) then
        begin
            d := StrToDateTime(DateToStr(dtData.Date) + ' ' + TimeToStr(dtHora.Time));
            result := true;
        end;
    finally
        Free();
    end;
end;

// Cria uma caixa de diálogo que pergunta um período
function getPeriodoDlg(var d1, d2: TDateTime; const MostrarHora: boolean = false): boolean;
begin
    //d1 := StrToDate('01/01/1900');
    //d2 := StrToDate('01/01/1900');
    result := false;
    with T_fmPeriodoDlg.Create(Application) do
    try
        dtData1.Date := now();
        dtHora1.Time := StrToTime('00:00:00');
        dtHora1.Visible := MostrarHora;
        dtData2.Date := now();
        dtHora2.Time := StrToTime('00:00:00');
        dtHora2.Visible := MostrarHora;
        if (ShowModal() = mrOk) then
        begin
            d1 := StrToDateTime(DateToStr(dtData1.Date) + ' ' + TimeToStr(dtHora1.Time));
            d2 := StrToDateTime(DateToStr(dtData2.Date) + ' ' + TimeToStr(dtHora2.Time));
            if d2 >= d1 then
            begin
                result := true;
            end;
        end;
    finally
        Free();
    end;
end;

// Converte uma data para o formato do SQL
function DateToSQL(d: TDateTime; const delimit: boolean = true; const cast: boolean = false): String;
begin
    result := FormatDateTime('yyyymmdd hh:nn:ss.zzz', d);
    if delimit then
        result := #39 + result + #39;
    if cast then
    begin
        if not delimit then
            result := #39 + result + #39;
        result := 'CAST(' + result + ' AS DATETIME)';
    end;
end;

function DateFromSQL(conn: TAdoConnection): TDateTime;
var
    qr: TAdoQuery;
begin
    qr := fnQrNew(conn, 'SELECT [Data] = GETDATE()', true);
    if not qr.Active then qr.Open();
    result := qr.FieldByName('Data').AsDateTime;
    if qr.Active then qr.Close();
    qr.Free();
end;

function ExpirarAplicativo(Application: TApplication; Form: TForm; validoAte: TDateTime; const diasAntesAvisando: integer = 15): boolean;
var
    validade: TDateTime;
begin
    result := false;
    validade := validoAte;

    form.Caption := form.Caption + ' - Versão válida até ' + DateToStr(validade);
    // PRAZO DE VALIDADE DESTE EXECUTÁVEL
    if (now() <= validade) and (DateUtils.DaysBetween(now(), validade) <= diasAntesAvisando) then
    begin
        if MessageDlg(
            'Atenção, esta versão só irá funcionar até ' + iif(DateUtils.DaysBetween(now(), validade) > 0, 'o dia ' + DateToStr(validade), 'hoje as 23:59:59') + '.'#13#10 +
            iif(DateUtils.DaysBetween(now(), validade) >= 2, 'Você tem mais ' + IntToStr(DateUtils.DaysBetween(now(), validade)) + ' dias para atualizar.'#13#10, '') +
            'Você pode baixar a versão mais nova no endereço:'#13#10+
            '   http://www.solucaosistemas.net/android/'#13#10 +
            'Deseja baixar para atualizar agora?', mtInformation, [mbYes, mbNo],0) = mrYes then
        begin
            ExecFile('http://www.solucaosistemas.net/android/');
        end;
    end;
    if (now() > validade) then
    begin
        MessageDlg(
            'Esta versão do programa está expirada.'#13#10 +
            'Baixe o "SSWebServer.exe" e o substitua pela versão mais recente.'#13#10+
            'O endereço para baixar é:'#13#10 +
            '   http://www.solucaosistemas.net/android/', mtInformation, [mbOk], 0);
        ExecFile('http://www.solucaosistemas.net/android/');
        NotePad(form.Caption + ' - Versão válida até ' + DateToStr(validade));        
        result := true;
    end;
end;


function CapturarWebCam(destino:string) : boolean;
type
    T_capCreateCaptureWindowA = function(lpszWindowName: pchar; dwStyle: dword; x, y, nWidth, nHeight: word; ParentWin: dword; nId: word): dword; stdcall;
const
   WM_WEBCAM = $400;
   WM_CONECTAR_DRIVER_WEBCAM    = WM_WEBCAM + $a;
   WM_DESCONECTAR_DRIVER_WEBCAM = WM_WEBCAM + $b;
   WM_GUARDAR_CAPTURA = WM_WEBCAM + 25;
   WM_FECHAR_WEBCAM = $0010;
var
    dllHandle: Cardinal;
    capCreateCaptureWindowA: T_capCreateCaptureWindowA;
    HwebCam: HWND;
begin

    HwebCam   := 0;
    Result        := False;
    dllHandle := LoadLibrary('avicap32.dll');
    if dllHandle <> 0 then
    try

        @capCreateCaptureWindowA := GetProcAddress(dllHandle, 'capCreateCaptureWindowA') ;
        if Assigned(capCreateCaptureWindowA) then
        begin                                            //WS_CHILD   //WS_VISIBLE
            HwebCam := capCreateCaptureWindowA('CaptureWindow', $40000000 and $10000000, 0, 0, 0, 0, GetDesktopWindow, 0);
            if SendMessage(HwebCam, WM_CONECTAR_DRIVER_WEBCAM, 0, 0) <> 1 then
            begin
                HwebCam   := 0;
                Result        := False;
            end
            else
            begin
                SendMessage(HwebCam, WM_GUARDAR_CAPTURA, wparam(0), lparam(PChar(destino)));
                SendMessage(HwebCam, WM_FECHAR_WEBCAM, 0, 0);
                SendMessage(HwebCam, WM_FECHAR_WEBCAM, 0, 0);
                HwebCam   := 0;
                Result        := True;
            end;
        end
        else
            Result := False;
    finally
        FreeLibrary(dllHandle);
    end;
end;

procedure TaskKillByName(ProcName: String);
var
    hprocessID: INTEGER;
    processHandle: THandle;
    DWResult: DWORD;
    hWindowHandle: DWORD;
begin
    hWindowHandle := FindWindow(PAnsiChar(ProcName), nil);
    while (hWindowHandle > 0) do
    begin
        hWindowHandle := FindWindow(PAnsiChar(ProcName), nil);
        SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0, SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
        if isWindow(hWindowHandle) then
        begin
            PostMessage(hWindowHandle, WM_QUIT, 0, 0);
            { Get the process identifier for the window}
            GetWindowThreadProcessID(hWindowHandle, @hprocessID);
            if hprocessID <> 0 then
            begin
                { Get the process handle }
                processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, hprocessID);
                if processHandle <> 0 then
                begin
                    { Terminate the process }
                    TerminateProcess(processHandle, 0);
                    CloseHandle(ProcessHandle);
                end;
            end;
        end;
        hWindowHandle := FindWindow(PAnsiChar(ProcName), nil);
    end;
end;


function TaskKillByExeName(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then 
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


procedure TaskKillByPID(pid: HWND);
var
    hprocessID: INTEGER;
    processHandle: THandle;
    DWResult: DWORD;
    hWindowHandle: HWND;
begin
    hWindowHandle := pid;
    SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0, SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
    if isWindow(hWindowHandle) then
    begin
        PostMessage(hWindowHandle, WM_QUIT, 0, 0);
        { Get the process identifier for the window}
        GetWindowThreadProcessID(hWindowHandle, @hprocessID);
        if hprocessID <> 0 then
        begin
            { Get the process handle }
            processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, hprocessID);
            if processHandle <> 0 then
            begin
                { Terminate the process }
                TerminateProcess(processHandle, 0);
                CloseHandle(ProcessHandle);
            end;
        end;
    end;
end;

procedure TaskShowByName(ProcName: String);
var
    pid: HWND;
begin
    pid := FindWindow('', PAnsiChar(ProcName));
    if (pid > 0) then
        ShowWindow(pid, SW_SHOW);
end;

procedure TaskShowByPID(pid: HWND);
begin
    ShowWindow(pid, SW_SHOW);
end;




function ExeProcessToHWnd(ProcessName : string) : HWND;
    var
      PidNum : DWORD;
      AHandle : HWND;
  function EnumProcess(hHwnd : HWND; lParam : integer) : boolean; stdcall;
  var
    pPid : DWORD;
  begin
    Result := (hHwnd <> 0);
    if Result = True then
    begin
      GetWindowThreadProcessId(hHwnd, pPid);
      if pPid = PidNum then
      begin
        if (GetWindowLong(hHWND, GWL_HWNDPARENT) = 0)
          and (IsWindowVisible(hHWND) or IsIconic(hHWND)) then
        begin
          AHandle := hHWND;
        end;
      end;
    end;
    Result := True;
  end;

  function ProcessIDFromAppname32(AppName : string) : DWORD;
  var
    SnapShot : THandle;
    processEntry : TProcessEntry32;
  begin
    Result := 0;
    AppName := AnsiUpperCase(AppName);
    SnapShot := CreateToolhelp32SnapShot(TH32CS_SNAPPROCESS, 0);
    if SnapShot <> 0 then
    try
      ProcessEntry.dwSize := SizeOf(ProcessEntry);
      if Process32First(SnapShot, ProcessEntry) then
        repeat
          if Pos(AppName, AnsiUpperCase(ExtractFilename
            (StrPas(processEntry.szExeFile)))) > 0 then
          begin
            Result := ProcessEntry.th32ProcessID;
            Break;
          end;
        until not Process32Next(SnapShot, ProcessEntry);
    finally
      CloseHandle(SnapShot);
    end;
  end;

begin
  PidNum := ProcessIDFromAppname32(ProcessName);
  EnumWindows(@EnumProcess, 0);
  Result := AHandle;
end;


procedure TaskHideByName(ProcName: String);
var
    pid: HWND;
begin
    pid := FindWindow(nil, PAnsiChar(ProcName));
    //pid := ExeProcessToHWnd(ProcName);
    if (pid > 0) then
        ShowWindow(pid, SW_HIDE);
end;

procedure TaskHideByPID(pid: HWND);
begin
    ShowWindow(pid, SW_HIDE);
end;


procedure SplitStr(str, delim: String; var a: TDinArrayStr); overload;
var
    s: String;
    t, p: Integer;
begin
    t := 0;
    SetLength(a, t);
    while pos(delim, str) > 0 do
    begin
        p := pos(delim, str);
        s := '';
        if p > 1 then
            s := Copy(str, 1, p-1);
        inc(t);
        SetLength(a, t);
        a[High(a)] := s;
        p := p + length(delim);
        if p <= length(str) then
            str := Copy(str, p, length(str))
        else
            str := '';
    end;
    inc(t);
    SetLength(a, t);
    a[High(a)] := str;
end;

procedure SplitStr(str, delim: String; a: TStrings); overload;
var
    s: String;
    t, p: Integer;
begin
    if not Assigned(a) then
        Exit;
    a.Clear();
    while pos(delim, str) > 0 do
    begin
        p := pos(delim, str);
        s := '';
        if p > 1 then
            s := Copy(str, 1, p-1);
        a.Add(s);
        p := p + length(delim);
        if p <= length(str) then
            str := Copy(str, p, length(str))
        else
            str := '';
    end;
    a.Add(str);
end;

function SplitStr(str, delim: String): TStringList; overload;
var
    s: String;
    p: Integer;
begin
    result := TStringList.Create();
    result.Clear();
    while pos(delim, str) > 0 do
    begin
        p := pos(delim, str);
        s := '';
        if p > 1 then
            s := Copy(str, 1, p-1);
        result.Add(s);
        p := p + length(delim);
        if p <= length(str) then
            str := Copy(str, p, length(str))
        else
            str := '';
    end;
    result.Add(str);
end;

function SortLines(lines: String): String;
var
    s: TStringList;
begin
    result := lines;
    s := TStringList.Create;
    s.Text := lines;
    try
        try
            s.Sorted := True;
            s.Sort;
            result := Trim(s.Text);
        except
        end;
    finally
        s.Free();
    end;
end;

// index: 1 a n
function ItemStr(str, delim: String; index: Integer): String;
var
    a: TDinArrayStr;
begin
    result := '';
    SplitStr(str, delim, a);
    if (index > 0) and (index <= (High(a)+1)) then
        result := a[index-1];
    SetLength(a, 0);
end;

function ItemStrCount(str, delim: String): Integer;
var
    a: TDinArrayStr;
begin
    SplitStr(str, delim, a);
    result := High(a) + 1;
    SetLength(a, 0);
end;

function ItemStrValue(str, delim: String; index: Integer): String; overload;
var
    p: Integer;
    a: TDinArrayStr;
begin
    SplitStr(str, delim, a);
    str := '';
    result := '';
    if (index > 0) and (index <= (High(a)+1)) then
        str := a[index-1];
    p := Pos('=',str)+1;
    if p <= length(str) then
        result := Copy(str, p, length(str));
    SetLength(a, 0);
end;

function ItemStrValue(str, delim: String; name: String): String; overload;
var
    p: Integer;
    a: TDinArrayStr;
    i: Integer;
    s: String;
begin
    result := '';
    SplitStr(str, delim, a);
    for i := Low(a) to High(a) do
    begin
        p := Pos('=',a[i])-1;
        if (p > 0) then
        begin
            s := Copy(a[i], 1, p);
            if UpperCase(Trim(s)) = UpperCase(Trim(name)) then
            begin
                p := Pos('=',a[i])+1;
                if p <= length(a[i]) then
                begin
                    result := Copy(a[i], p, length(a[i]));
                    break;
                end;
            end;
        end;
    end;
    SetLength(a, 0);
end;

function ItemStrName(str, delim: String; index: Integer): String;
var
    p: Integer;
    a: TDinArrayStr;    
begin
    SplitStr(str, delim, a);
    str := '';
    result := '';
    if (index > 0) and (index <= (High(a)+1)) then
        str := a[index-1];
    p := Pos('=',str)-1;
    if p > 0 then
        result := Copy(str, 1, p);
end;

function WriteToFile(text: String; fileName: String; const overWrite: boolean = false; const append: boolean = false): boolean;
var
    l: TStringList;
begin
    result := false;
    if (not overWrite) and (FileExists(fileName)) then
        exit;       

    if length(text) >= 2 then
        if (text[length(text)-1] = #13) and (text[length(text)] = #10) then
            text := text + #13#10;

    result := true;
    l := TStringList.Create();
    if FileExists(fileName) and append then
    begin
        try
            l.LoadFromFile(fileName);
            l.Text := Copy(l.Text,1,length(l.Text)-2) + text;
        except
            result := false;
        end;
    end
    else
    begin
        l.Text := text;
    end;

    try
        l.SaveToFile(fileName);
    except
        result := false;
    end;
    l.Free();
end;

function ReadFromFileBin(fileName: String): TDinArrayBytes;
var
    f: file of Byte;
    len: Integer;
    i: Integer;
begin
    SetLength(result, 0);
    if not FileExists(fileName) then
        Exit;
    len := GetFileSize(fileName);
    SetLength(result, len);
    i := 0;
    AssignFile(f, fileName);
    Reset(f);
    while (not Eof(f)) and (i <= len) do
    begin
        Read(f, result[i]);
        i := i + 1;
    end;
    CloseFile(f);
end;

procedure WriteToFileBin(aByte: TDinArrayBytes; fileName: String; const overwrite: boolean = true);
var
    f: file of Byte;
    i: Integer;
begin
    if FileExists(fileName) and (not overwrite) then
        Exit;
    AssignFile(f, fileName);
    Rewrite(f);
    for i := Low(aByte) to High(aByte) do
    begin
        Write(f, aByte[i]);
    end;
    CloseFile(f);
end;



function ReadFromFile(fileName: String): String;
var
    l: TStringList;
    s: String;
begin
    result := '';
    if not FileExists(fileName) then
        exit;
    l := TStringList.Create();
    l.LoadFromFile(fileName);
    s := l.Text;
    l.Free();
    if (length(s) >= 2) and (s[length(s)-1] = #13) and (s[length(s)] = #10) then
        s := Copy(s, 1, length(s)-2);
    result := s;
end;


function IdadeCompleta(Data: TDateTime): String; overload;
var
    DataIni, DataFim : TDateTime;
    Idade : String;
    Resto : Integer;
    iDia, iMes, iAno, fDia, fMes, fAno : Word;
    nDia, nMes, nAno, DiaBissexto : Double;
begin
    dataIni := data;
    dataFim := now();

    DecodeDate(DataIni,iAno,iMes,iDia);
    DecodeDate(DataFim,fAno,fMes,fDia);
    nAno := fAno - iAno;
    if nAno > 0 then
        if fMes < iMes then
            nAno := nAno - 1
        else if (fMes = iMes) and (fDia < iDia) then
            nAno := nAno - 1;

    if fMes < iMes then
    begin
        nMes := 12 - (iMes-fMes);
        if fDia < iDia then
            nMes := nMes - 1;
    end
    else if fMes = iMes then
    begin
        nMes := 0;
        if fDia < iDia then
            nMes := 11;
    end
    else if fMes > iMes then
    begin
        nMes := fMes - iMes;
        if fDia < iDia then
            nMes := nMes - 1;
    end;

    nDia := 0;

    if fDia > iDia then
        nDia := fDia - iDia;
    if fDia < iDia then
        nDia := (DataFim-IncMonth(DataFim,-1))-(iDia-fDia);
    Result := '';
    if nAno = 1 then
        Result := FloatToStr(nAno)+ ' Ano '
    else if nAno > 1 then
        Result := FloatToStr(nAno)+ ' Anos ';

    if nMes = 1 then
        Result := Result + FloatToStr(nMes)+ ' Mês '
    else if nMes > 1 then
        Result := Result + FloatToStr(nMes)+ ' Meses ';

    if nDia = 1 then
        Result := Result + FloatToStr(nDia)+ ' Dia '
    else if nDia > 1 then
        Result := Result + FloatToStr(nDia)+ ' Dias ';

end;


function IdadeCompleta(DataIni, DataFim: TDateTime): String; overload;
var

    Idade : String;
    Resto : Integer;
    iDia, iMes, iAno, fDia, fMes, fAno : Word;
    nDia, nMes, nAno, DiaBissexto : Double;
begin
    DecodeDate(DataIni,iAno,iMes,iDia);
    DecodeDate(DataFim,fAno,fMes,fDia);
    nAno := fAno - iAno;
    if nAno > 0 then
        if fMes < iMes then
            nAno := nAno - 1
        else if (fMes = iMes) and (fDia < iDia) then
            nAno := nAno - 1;

    if fMes < iMes then
    begin
        nMes := 12 - (iMes-fMes);
        if fDia < iDia then
            nMes := nMes - 1;
    end
    else if fMes = iMes then
    begin
        nMes := 0;
        if fDia < iDia then
            nMes := 11;
    end
    else if fMes > iMes then
    begin
        nMes := fMes - iMes;
        if fDia < iDia then
            nMes := nMes - 1;
    end;

    nDia := 0;

    if fDia > iDia then
        nDia := fDia - iDia;
    if fDia < iDia then
        nDia := (DataFim-IncMonth(DataFim,-1))-(iDia-fDia);

    Result := '';
    Result := Format('A%.4d;M%.2d;D%.2d', [Trunc(nAno), Trunc(nMes), Trunc(nDia)]);

end;


function Periodo(DataIni, DataFim: TDateTime): String; overload;
var
  Data: TDateTime;
  Resto : Double;
  Dias, Horas, Minutos, Segundos: string;
  Sinal: String;
begin
    Sinal := '+';
    if DataFim < DataIni then
    begin
        Sinal := '-';
        Data := DataIni;
        DataIni := DataFim;
        DataFim := Data;
    end;

    Data := DataFim - DataIni;
    Dias := Format('%.8d', [Trunc(Data)]);;
    Resto := Frac(Data);
    Horas := Format('%.6d', [Trunc(Resto * 24)]);;
    Resto := Frac(Resto * 24);
    Minutos := Format('%.6d', [Trunc(Resto * 60)]);
    Resto := Frac(Resto * 60);
    Segundos := Format('%.6d', [Trunc(Resto * 60)]);
    Result := Sinal + 'D' + Dias + ';H' + Horas + ';M' + Minutos + ';S' + Segundos;

end;

function Periodo(segundos: LongInt): String; overload;
var
    secs: LongInt;
    d, h, m: Word;
begin
    secs := Segundos;
    h := Secs div 3600;
    Secs := Secs mod 3600;
    m := Secs div 60;
    Secs := Secs mod 60;
    d := h div 24;
    h := h mod 24;
    Result := Format('D%.6d;H%.4d;M%.4d;S%.4d', [d, h, m, secs]);
end;


// adiciona tempo a uma data/hora
function DateTimeAdd(date: TDateTime; const days: LongInt = 0; const hours: LongInt = 0; const minutes: LongInt = 0; const seconds: LongInt = 0): TDateTime;
begin
    result := date;
    result := IncDay(result, days);
    result := IncHour(result, hours);
    result := IncMinute(result, minutes);
    result := IncSecond(result, seconds);
end;

// validar cpf
function ValidarCPF(num: string): boolean;
var
    n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
    d1, d2: integer;
    digitado, calculado: string;
    //esta função retira os caracteres diferentes de 0..9 de uma string
    function SoNum(digitado: String): String;
    var
        i: integer;
    begin
        Result := '';
        for i:=1 To Length(digitado) do
            if digitado[I] In ['0', '1','2','3','4','5','6','7','8','9'] then
                Result := Result + digitado[I];
    end;
begin
    num := SoNum(num);
    while length(num) < 11 do
        num := '0' + num;
    n1 := StrToInt(num[1]);
    n2 := StrToInt(num[2]);
    n3 := StrToInt(num[3]);
    n4 := StrToInt(num[4]);
    n5 := StrToInt(num[5]);
    n6 := StrToInt(num[6]);
    n7 := StrToInt(num[7]);
    n8 := StrToInt(num[8]);
    n9 := StrToInt(num[9]);
    d1 := n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
    d1 := 11-(d1 mod 11);
    if d1 >= 10 then
        d1 := 0;
    d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then
        d2 := 0;
    calculado := IntToStr(d1) + IntToStr(d2);
    digitado := num[10] + num[11];
    if calculado = digitado then
        result := true
    else
        result := false;
end;

// validar cgc
function ValidarCGC(num: string): boolean;
var
    n1, n2, n3, n4, n5, n6, n7, n8, n9, n10 ,n11,n12: integer;
    d1, d2: integer;
    digitado, calculado: string;
    //esta função retira os caracteres diferentes de 0..9 de uma string
    function SoNum(digitado: String): String;
    var
        i: integer;
    begin
        Result := '';
        for i:=1 To Length(digitado) do
            if digitado[I] In ['0', '1','2','3','4','5','6','7','8','9'] then
                Result := Result + digitado[I];
    end;
begin
    num := SoNum(num);
    while length(num) < 12 do
        num := '0' + num;
    n1 := strtoint(num[1]);
    n2 := strtoint(num[2]);
    n3 := strtoint(num[3]);
    n4 := strtoint(num[4]);
    n5 := strtoint(num[5]);
    n6 := strtoint(num[6]);
    n7 := strtoint(num[7]);
    n8 := strtoint(num[8]);
    n9 := strtoint(num[9]);
    n10 := strtoint(num[10]);
    n11 := strtoint(num[11]);
    n12 := strtoint(num[12]);
    d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then
        d1 := 0;
    d2 := d2 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then
        d2 := 0;
    calculado := IntToStr(d1) + IntToStr(d2);
    digitado := num[13] + num[14];
    if calculado = digitado then
        result := true
    else
        result := false;
end;

// valida cnpj
function ValidarCNPJ(CNPJ: String): Boolean;
var vCNPJ, vDigito: String;
    DF1, DF2: Integer;
begin
  Result := False;

  vCNPJ := CNPJ;

  // Removendo caracteres especiais
  vCNPJ := StringReplace( vCNPJ, '.', '', [rfReplaceAll] );
  vCNPJ := StringReplace( vCNPJ, '-', '', [rfReplaceAll] );
  vCNPJ := StringReplace( vCNPJ, '/', '', [rfReplaceAll] );

  // Verificar tamanho dos dígitos do CNPJ
  if ( Length( vCNPJ ) <> 14 ) then
    Exit;

  // Armazena o número do CNPJ e o digito separados
  vDigito := Copy( vCNPJ, 13, 02 );
  vCNPJ   := Copy( vCNPJ, 01, 12 );

  // Somar e multiplicar os pesos do digito 1 em cada número
  DF1 :=       (StrToInt(vCNPJ[01])*05) + (StrToInt(vCNPJ[02])*04);
  DF1 := DF1 + (StrToInt(vCNPJ[03])*03) + (StrToInt(vCNPJ[04])*02) + (StrToInt(vCNPJ[05])*09);
  DF1 := DF1 + (StrToInt(vCNPJ[06])*08) + (StrToInt(vCNPJ[07])*07) + (StrToInt(vCNPJ[08])*06);
  DF1 := DF1 + (StrToInt(vCNPJ[09])*05) + (StrToInt(vCNPJ[10])*04) + (StrToInt(vCNPJ[11])*03) + (StrToInt(vCNPJ[12])*02);

  // Cálculo da diferença de 11 com o resto de DF1
  DF1 := 11 - ( DF1 mod 11 );

  // Se o resultado anterior for maior ou igual a 10, o dígito 1 é 0,
  // caso contrário, o digito 1 é o próprio resultado.
  if DF1 >= 10 then DF1 := 0;

  // Somar e multiplicar os pesos do digito 2 em cada número
  DF2 :=       (StrToInt(vCNPJ[01])*06) + (StrToInt(vCNPJ[02])*05);
  DF2 := DF2 + (StrToInt(vCNPJ[03])*04) + (StrToInt(vCNPJ[04])*03) + (StrToInt(vCNPJ[05])*02);
  DF2 := DF2 + (StrToInt(vCNPJ[06])*09) + (StrToInt(vCNPJ[07])*08) + (StrToInt(vCNPJ[08])*07);
  DF2 := DF2 + (StrToInt(vCNPJ[09])*06) + (StrToInt(vCNPJ[10])*05) + (StrToInt(vCNPJ[11])*04) + (StrToInt(vCNPJ[12])*03);

  // Somar o resultado do digito 2 com o dobro do digito 1
  DF2 := DF2 + ( DF1 * 2 );

  // Cálculo da diferença de 11 com o resto de DF2
  DF2 := 11 - ( DF2 mod 11 );

  // Se o resultado anterior for maior ou igual a 10, o dígito 2 é 0,
  // caso contrário, o digito 2 é o próprio resultado.
  if DF2 >= 10 then DF2 := 0;

  // Retorna verdadeiro ou falso, caso o dígito informado coincida ou não com o calculado
  Result := vDigito = IntToStr(DF1) + IntToStr(DF2);
end;

// Checa se uma string representa uma data
function ValidarData(data: String): boolean;
var
    s: String;
begin
    result := false;
    try
        s := DateToStr(StrToDate(data));
        if length(s) > 0 then
            result := true;
    except
        result := false;
    end;
end;

// Checa se uma string representa uma hora
function ValidarHora(hora: String): boolean;
var
    s: String;
begin
    result := false;
    try
        s := TimeToStr(StrToTime(hora));
        if length(s) > 0 then
            result := true;
    except
        result := false;
    end;
end;

// Checa se uma string representa uma data e hora
function ValidarDataHora(datahora: String): boolean;
var
    s: String;
begin
    result := false;
    try
        s := DateTimeToStr(StrToDateTime(datahora));
        if length(s) > 0 then
            result := true;
    except
        result := false;
    end;
end;

// Checa se uma string representa um número inteiro
function ValidarInteiro(numInteiro: String): boolean;
var
    s: String;
begin
    result := false;
    try
        s := IntToStr(StrToInt(numInteiro));
        if length(s) > 0 then
            result := true;
    except
        result := false;
    end;
end;

// Checa se uma string representa um número real/ponto flutuante
function ValidarReal(numReal: String): boolean;
var
    s: String;
begin
    result := false;
    try
        s := FloatToStr(StrToFloat(numReal));
        if length(s) > 0 then
            result := true;
    except
        result := false;
    end;
end;


// Verifica se uma e-mail está dentro da norma de nomes de e-mails
function ValidarEmail(sEmail: string): boolean;
const
    // Caracteres válidos
    ATOM_CHARS = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
    // Caracteres válidos em uma cadeia
    QUOTED_STRING_CHARS = [#0..#255] - ['"', #13, '\'];
    // Caracteres válidos em um subdominio
    LETTERS = ['A'..'Z', 'a'..'z'];
    LETTERS_DIGITS = ['0'..'9', 'A'..'Z', 'a'..'z'];
    SUBDOMAIN_CHARS = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];
type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR, STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN, STATE_SUBDOMAIN, STATE_HYPHEN);
var
    State: States;
    i, n, iSubdomains: integer;
    c: char;
begin
    State := STATE_BEGIN;
    n := Length(sEmail);
    i := 1;
    iSubdomains := 1;
    while (i <= n) do
    begin
        c := sEmail[i];
        case State of
            STATE_BEGIN:
                if c in atom_chars then
                    State := STATE_ATOM
                else if c = '"' then
                    State := STATE_QTEXT
                else
                    break;
            STATE_ATOM:
                if c = '@' then
                    State := STATE_EXPECTING_SUBDOMAIN
                else if c = '.' then
                    State := STATE_LOCAL_PERIOD
                else if not (c in atom_chars) then
                    break;
            STATE_QTEXT:
                if c = '\' then
                    State := STATE_QCHAR
                else if c = '"' then
                    State := STATE_QUOTE
                else if not (c in quoted_string_chars) then
                    break;
            STATE_QCHAR:
                State := STATE_QTEXT;
            STATE_QUOTE:
                if c = '@' then
                    State := STATE_EXPECTING_SUBDOMAIN
                else if c = '.' then
                    State := STATE_LOCAL_PERIOD
                else
                    break;
            STATE_LOCAL_PERIOD:
                if c in atom_chars then
                    State := STATE_ATOM
                else if c = '"' then
                    State := STATE_QTEXT
                else
                    break;
            STATE_EXPECTING_SUBDOMAIN:
                if c in letters then
                    State := STATE_SUBDOMAIN
                else
                    break;
            STATE_SUBDOMAIN:
                if c = '.' then
                begin
                    Inc(iSubdomains);
                    State := STATE_EXPECTING_SUBDOMAIN
                end
                else if c = '-' then
                    State := STATE_HYPHEN
                else if not (c in letters_digits) then
                    break;
            STATE_HYPHEN:
                if c in letters_digits then
                    State := STATE_SUBDOMAIN
                else if c <> '-' then
                    break;
        end;
        Inc(i);
    end;

    if i <= n then
        Result := False
    else
        Result := (State = STATE_SUBDOMAIN) and (iSubdomains >= 2);

    //se sEmail esta vazio retorna true
    if sEmail = '' then
        Result := true;
end;


//Função: verificar o CEP de acordo com o estado escolhido
//Retorna: True caso esteja correto, False caso incorreto
//Exemplo: VerificaCEP(CmbBoxEstado.Text, edtCEP.Text)
//Obs.: Deve-se utilizar os seguintes items para a combo:
(*
AC,AL,AM,AP,BA,CE,DF,ES,GO,MA,MG,MS,MT,PA,PB,PE,PI ,PR,RJ,RN,RO,RR,RS,SC,SE,SP,TO
*)
function ValidarCEP(UF, CEPDigitado: String): Boolean;
    //esta função retira os caracteres diferentes de 0..9 de uma string
    function SoNum(digitado: String): String;
    var
        i: integer;
    begin
        Result := '';
        for i:=1 To Length(digitado) do
            if digitado[I] In ['0', '1','2','3','4','5','6','7','8','9'] then
                Result := Result + digitado[I];
    end;
var
    cep : integer; //guarda o cep sem mascara como inteiro
begin
    Result := True;
    cep := StrToInt(SoNum(CEPDigitado));
    //verifica o cep digitado em relacao ao estado escolhido
    if UF = '' then
    begin
        result := false;
        exit;
    end;
    if UF = 'SP' then if ((cep < 10000000) or (cep > 19999999)) then Result := False;
    if UF = 'RJ' then if ((cep < 20000000) or (cep > 28999999)) then Result := False;
    if UF = 'MS' then if ((cep < 79000000) or (cep > 79999999)) then Result := False;
    if UF = 'MG' then if ((cep < 30000000) or (cep > 39999999)) then Result := False;
    if UF = 'MT' then if ((cep < 78000000) or (cep > 78899999)) then Result := False;
    if UF = 'AC' then if ((cep < 69900000) or (cep > 69999999)) then Result := False;
    if UF = 'AL' then if ((cep < 57000000) or (cep > 57999999)) then Result := False;
    if UF = 'AM' then if ((cep < 69000000) or (cep > 69899999)) then Result := False;
    if UF = 'AP' then if ((cep < 68900000) or (cep > 69999999)) then Result := False;
    if UF = 'BA' then if ((cep < 40000000) or (cep > 48999999)) then Result := False;
    if UF = 'CE' then if ((cep < 60000000) or (cep > 63999999)) then Result := False;
    if UF = 'DF' then if ((cep < 70000000) or (cep > 73699999)) then Result := False;
    if UF = 'ES' then if ((cep < 29000000) or (cep > 29999999)) then Result := False;
    if UF = 'GO' then if ((cep < 73700000) or (cep > 76999999)) then Result := False;
    if UF = 'MA' then if ((cep < 65000000) or (cep > 65999999)) then Result := False;
    if UF = 'PA' then if ((cep < 66000000) or (cep > 68899999)) then Result := False;
    if UF = 'PB' then if ((cep < 58000000) or (cep > 58999999)) then Result := False;
    if UF = 'PE' then if ((cep < 50000000) or (cep > 56999999)) then Result := False;
    if UF = 'PI' then if ((cep < 64000000) or (cep > 64999999)) then Result := False;
    if UF = 'PR' then if ((cep < 80000000) or (cep > 87999999)) then Result := False;
    if UF = 'RN' then if ((cep < 59000000) or (cep > 59999999)) then Result := False;
    if UF = 'RO' then if ((cep < 78900000) or (cep > 78999999)) then Result := False;
    if UF = 'RR' then if ((cep < 69300000) or (cep > 69399999)) then Result := False;
    if UF = 'RS' then if ((cep < 90000000) or (cep > 99999999)) then Result := False;
    if UF = 'SC' then if ((cep < 88000000) or (cep > 89999999)) then Result := False;
    if UF = 'SE' then if ((cep < 49000000) or (cep > 49999999)) then Result := False;
    if UF = 'TO' then if ((cep < 77000000) or (cep > 77999999)) then Result := False;
end;

// verifica se uma url é válida
function ValidarURL(const Url: string): Boolean;
var
    hSession, hFile : hInternet;
    dwIndex, dwCodeLen: dword;
    dwCode: array[1..20] of char;
    vRes: Pchar;
begin
    Result := False;
    hSession := InternetOpen('InetURL:/1.0',
    INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    if (Assigned(hsession)) then
    begin
        hfile := InternetOpenUrl(hSession, Pchar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);
        dwIndex := 0;
        dwCodeLen := 10;
        HttpQueryInfo(hFile, HTTP_QUERY_STATUS_CODE, @dwCode, dwCodeLen, dwIndex);
        vRes := Pchar(@dwCode);
        Result := (vRes = '200') or (vRes = '302');
        if (Assigned(hFile)) then
            InternetCloseHandle(hFile);
        InternetCloseHandle(hSession);
    end;
end;

// verifica se um inteiro está dentro de um intervalo
function ValidarIntervaloInteiro(valorComparar, valorMinimo, valorMaximo: LongInt): boolean;
begin
    result := (valorComparar >= valorMinimo) and (valorComparar <= valorMaximo);
end;

// verifica se um número double está dentro de um intervalo
function ValidarIntervaloReal(valorComparar, valorMinimo, valorMaximo: Double): boolean;
begin
    result := (valorComparar >= valorMinimo) and (valorComparar <= valorMaximo);
end;

// verifica se uma data/hora está compreendida em um intervalo
function ValidarIntervaloDataHora(valorComparar, valorMinimo, valorMaximo: TDateTime): boolean;
begin
    result := (valorComparar >= valorMinimo) and (valorComparar <= valorMaximo);
end;

// Formata nomes para que comecem com letras maiúsculas
Function FormatarNome(Nome: String): String;
var
    x : Integer;
    lista : Array[0..6] of String[03];
    NomeL : string;
    i: Integer;

    function NaoAchaPreposicao(Palavra : String): Boolean;
    var
        x : Integer;
    begin
        Result := True;
        for x := 0 to High(Lista) do
            if Trim(Palavra) = lista[x] then
                Result := False;
    end;

    function ToLower(Text: String): String;
    var
        Ind: Integer;
    const
        LW = 'áâãàéêíóôõúüûçñ';
        UP = 'ÁÂÃÀÉÊÍÓÔÕÚÜÛÇÑ';
    begin
        Result := '';
        for Ind := 1 to Length(Text) do
            if Pos(Copy(Text, Ind, 1), UP) > 0 then
                Result := Result + Copy(LW, Pos(Copy(Text, Ind, 1), UP), 1)
            else
                Result := Result + LowerCase(Copy(Text, Ind, 1));
    end;

begin
    NomeL := '';
    while (pos('  ', Nome) > 0) do
        Nome := StringReplace(Nome, '  ', ' ', [rfReplaceAll]);
    for i := 1 to length(Nome) do
        if Nome[i] > #27 then
            NomeL := NomeL + Nome[i];
    NomeL := ToLower(NomeL);
    Result := NomeL;
    lista[0] := 'das'; lista[1] := 'dos' ;
    lista[2] := 'de'; lista[3] := 'do' ;
    lista[4] := 'da'; lista[5] := 'di';
    lista[6] := 'von';
    Result := UpCase(Result[1]) + Copy(Result, 2, Length(Result));
    for x := 2 to Length(NomeL) do
    begin
        if NomeL[x] = #32 then
            if Copy(NomeL,x+1,1) <> 'e' then
                if NaoAchaPreposicao(Copy(NomeL,x+1,3)) then
                    Result :=
                        Copy(Result, 1, x)
                        + UpCase(Result[x+1])
                        + Copy(Result, x+2, Length(Result));
    end;
end;

// formata uma string representando um cpf para o formato de cpf
function FormatarCPF(cpf: String): String;
var
    s: String;

    //esta função retira os caracteres diferentes de 0..9 de uma string
    function SoNum(digitado: String): String;
    var
        i: integer;
    begin
        Result := '';
        for i:=1 To Length(digitado) do
            if digitado[I] In ['0', '1','2','3','4','5','6','7','8','9'] then
                Result := Result + digitado[I];
    end;

begin
    result := '';
    s := SoNum(cpf);
    s := Copy(s, 1, 11);
    while length(s) < 11 do
        s := '0' + s;
    s := Copy(s, 1, 3) + '.' + copy(s, 4, 3) + '.' + copy(s, 7, 3) + '-' + copy(s, 10, 2);
    result := s;
end;

// Formata uma string representando um cnpj para o formato de cnpj
function FormatarCNPJ(cnpj: String): String;
var
    s: String;

    //esta função retira os caracteres diferentes de 0..9 de uma string
    function SoNum(digitado: String): String;
    var
        i: integer;
    begin
        Result := '';
        for i:=1 To Length(digitado) do
            if digitado[I] In ['0', '1','2','3','4','5','6','7','8','9'] then
                Result := Result + digitado[I];
    end;

begin
    result := '';
    s := SoNum(cnpj);
    s := Copy(s, 1, 14);
    while length(s) < 14 do
        s := '0' + s;
    s := Copy(s, 1, 2) + '.' + copy(s, 3, 3) + '.' + copy(s, 6, 3) + '/' + copy(s, 9, 4) + '-' + copy(s, 13, 2);
    result := s;
end;

// abre um texto no Bloco de Notas
procedure NotePad(s: String);
var
    n: String;
begin
    n := 'texto.txt';
    WriteToFile(s, n, true, false);
    ExecFile(n);
end;

//Converte uma string representando um Hexadecimal para um Int64
function HexToInt(s : string) : Int64;
begin
  if (s <> '') and (s[1] <> '$') then
    result := strToInt64('$' + s )
  else
    result := strToInt64(s);
end;

// Converte um Int64 para uma string representando um Hexadecimal
function IntToHex(n: Int64; digits: Integer): String;
begin
    result := SysUtils.IntToHex(n, digits);
end;

// Converte um Int64 para uma string representando um número binário/base2
function IntToBin(IValue : Int64; NumBits : word = 64) : string;
var
    RetVar : string;
    i,ILen : byte;
begin
    RetVar := '';
    case NumBits of
        32 : IValue := dword(IValue);
        16 : IValue := word(IValue);
        8  : IValue := byte(IValue);
    end;
    while IValue <> 0 do
    begin
        Retvar := char(48 + (IValue and 1)) + RetVar;
        IValue := IValue shr 1;
    end;
    if RetVar = '' then
        Retvar := '0';
    Result := RetVar;
end;

// converte uma string representando um número binário para um Int64
function BinToInt(BinStr : string) : Int64;
var
    i : byte;
    RetVar : Int64;
begin
    BinStr := UpperCase(BinStr);
    if BinStr[length(BinStr)] = 'B' then
        Delete(BinStr,length(BinStr),1);
    RetVar := 0;
    for i := 1 to length(BinStr) do
    begin
        if not (BinStr[i] in ['0','1']) then
        begin
            RetVar := 0;
            Break;
        end;
        RetVar := (RetVar shl 1) + (byte(BinStr[i]) and 1) ;
    end;
    Result := RetVar;
end;

// Converte uma inteiro com digitos 0,1(pseudobase2) para uma base decimal
function Base10(Base2:Integer) : Integer; assembler;
asm
    cmp    eax,100000000
    jb     @1
    mov    eax,-1
    jmp    @exit
    @1:
    push    ebx
    push   esi
    xor    esi,esi
    mov    ebx,10
    mov    ecx,8
    @2:
    mov    edx,0
    div    ebx
    add    esi,edx
    ror    esi,4
    loop @2
    mov    eax,esi
    pop    esi
    pop    ebx
    @exit:
end;

// inicializa um array de Bytes
procedure AByteInit(var aByte: TDinArrayBytes; const size: Integer = 0);
begin
    SetLength(aByte, size);
end;

// Adiciona um byte para um array dinâmico de bytes
function AByteAdd(var aByte: TDinArrayBytes; b: Byte): integer; overload;
var
    i, l, h: Integer;
begin
    h := High(aByte);
    if h = -1 then
        AByteInit(aByte);
    h := High(aByte) + 2;
    SetLength(aByte, h);
    aByte[h-1] := b;
end;

// Adiciona uma string para um array dinâmico de bytes
function AByteAdd(var aByte: TDinArrayBytes; str: String): integer; overload;
var
    i, l, h: Integer;
    b: Byte;
    de, ate: Integer;
begin
    h := High(aByte);
    if h = -1 then
        h := 1
    else
    begin
        de := h + 1;
        ate := h + length(str) + 1;
    end;
    SetLength(aByte, ate);
    for i := 1 to length(str) do
        aByte[de+i-1] := Byte(str[i]);
end;


// converte uma array dinâmico de bytes para uma string
function AByteToStr(aByte: TDinArrayBytes): String;
var
    i: Integer;
begin
    result := '';
    for i := Low(aByte) to High(aByte) do
        result := result + Char(aByte[i]);
end;

// Converte uma string para um array dinâmico de bytes
procedure StrToAByte(str: String; var aByte: TDinArrayBytes);
var
    i: Integer;
begin
    SetLength(aByte, length(str));
    for i := 1 to length(str) do
        aByte[i-1] := Byte(str[i]);
end;

// informa o checksum de uma sequência de bytes
function CheckSum(aByte: TDinArrayBytes; const de: integer = -1; const ate: Integer = -1): Byte; overload;
var
    i: Integer;
    de2, ate2: Integer;
begin
    result := 0;
    if de = -1 then
    begin
        de2 := Low(aByte);
    end
    else
    begin
        de2 := de;
        if (de2 < Low(aByte)) or (de2 > High(aByte)) then
            de2 := Low(aByte);
    end;

    if ate = -1 then
    begin
        ate2 := High(aByte);
    end
    else
    begin
        ate2 := ate;
        if (ate2 < Low(aByte)) or (ate2 > High(aByte)) then
            ate2 := High(aByte);
    end;

    if (de2 > ate2) then
        de2 := ate;

    for i := de2 to ate2 do
        result := result + aByte[i];
end;

// Informa o checksum de uma string
function CheckSum(str: String; const de: Integer = 0; const ate: Integer = 0): Byte; overload;
var
    i: Integer;
    de2, ate2: Integer;
begin
    result := 0;
    de2 := de;
    ate2 := ate;
    if (de2 <= 0) or (de2 > length(str)) then
        de2 := 1;
    if (ate2 <= 0) or (ate2 > length(str)) then
        ate2 := length(str);
    if (de2 > ate2) then
        de2 := ate2;
    for i := de2 to ate2 do
        result := result + Byte(str[i]);
end;

// Converte um inteiro de até 16 bits em dois bytes com a parte alta
// e a parte baixa do inteiro
procedure IntToBytes2(n: Integer; var aBytes: TDinArrayBytes);
var
    bH, bL: Byte;
begin
    SetLength(aBytes, 2);
    bH := (n shr 8) and $FF;
    bL := n and $FF;
    aBytes[0] := bH;
    aBytes[1] := bL;
end;

// Junta dois bytes da parte alta e da parte baixa de um inteiro para compor um
// inteiro de 16bits
function Bytes2ToInt(var aBytes: TDinArrayBytes): Integer;
var
    bH, bL: Integer;
begin
    result := 0;
    if (Low(aBytes) = 0) and (High(aBytes) = 1) then
    begin
        bH := aBytes[0];
        bL := aBytes[1];
        result := (bH shl 8) + bL;
    end;
end;

function GetIpList(): TStringList;
type
    TaPInAddr = array[0..10] of PInAddr;
    PaPInAddr = ^TaPInAddr;
var
    phe: PHostEnt;
    pptr: PaPInAddr;
    Buffer: array[0..63] of Char;
    I: Integer;
    GInitData: TWSAData;
begin
    WSAStartup($101, GInitData);
    Result := TstringList.Create;
    Result.Clear;
    GetHostName(Buffer, SizeOf(Buffer));
    phe := GetHostByName(buffer);
    if phe = nil then
        Exit;
    pPtr := PaPInAddr(phe^.h_addr_list);
    I := 0;
    while pPtr^[I] <> nil do
    begin
        Result.Add(inet_ntoa(pptr^[I]^));
        Inc(I);
    end;
    WSACleanup;
end;

function GetFileSize(path: string) : Int64;
var
    f: file of Byte;
begin
    Result := -1;
    AssignFile(f, path);
    try
        Reset(f);
        Result := FileSize(f);
    finally
        CloseFile(f);
    end;
end;

function TextToHex(txt: String): String;
var
    i: Integer;
begin
    result := '';
    for i := 1 to length(txt) do
        try
            result := result + IntToHex(Byte(txt[i]), 2);
        except
        end;
end;

function HexToText(hex: String): String;
var
    i, len: Integer;
    bb: String;

begin
    result := '';
    len := length(hex) div 2;
    for i := 0 to len-1 do
    begin
        try
            bb := '' + hex[(i*2)+1] + hex[(i*2)+2];
            result := result + Char(HexToInt(bb));
        except
        end;
    end;
end;

// Inicializa o arquivo de configuração
procedure ClearCriptoConfig(const fileName: String = FILE_CONFIG_SECURE);
var
    f: file of Byte;
begin
    AssignFile(f, fileName);
    Rewrite(f);
    CloseFile(f);
end;

// Lê uma configuração criptografada
function ReadCriptoConfig(name: String; default: String; const fileName: String = FILE_CONFIG_SECURE): String;
var
    l: TStringList;
    s: String;
    a: TDinArrayBytes;
begin
    result := '';
    s := ReadFileSecure(fileName);
    l := TStringList.Create();
    l.Text := s;
    if  l.IndexOfName(name) > -1 then
    begin
        result := l.Values[name];
    end
    else
        result := default;
    l.Free();
end;

// Escreve uma configuração criptografada
procedure WriteCriptoConfig(name: String; value: String; const fileName: String = FILE_CONFIG_SECURE);
var
    l: TStringList;
    s: String;
begin
    // ler do arquivo
    s := ReadFileSecure(fileName);

    // aplicar para o conteúdo do arquivo a configuração
    l := TStringList.Create();
    l.Text := s;
    l.Values[name] := value;
    s := Trim(l.Text);
    l.Free();
    // salvar

    WriteFileSecure(s, fileName);
end;

// escreve uma arquivo de texto de forma criptografada
function ReadFileSecure(fileName: String; const KEY: String = KEY_CONFIG_SECURE): String;
var
    a: TDinArrayBytes;
begin
    result := AByteToStr(ReadFromFileBin(fileName));
    result := CriptoStr255(result, KEY);
    result := HexToText(result);
end;

// lê uma arquivo de texto criptografado
procedure WriteFileSecure(txt, fileName: String; const KEY: String = KEY_CONFIG_SECURE);
var
    a: TDinArrayBytes;
begin
    txt := TextToHex(txt);
    txt := CriptoStr255(txt, KEY);
    StrToAByte(txt, a);
    WriteToFileBin(a, fileName);
end;


procedure ComPort_ExibirConfiguracao();
begin
    ComPort.ShowSetupDialog();
end;


procedure ComPort_Configurar(porta: Integer; baud_rate: Integer; const flow_control: String = '');
var
    b: CPort.TBaudRate;
    f: CPort.TFlowControl;
begin

    if flow_control = '' then
        f := fcNone
    else if flow_control = 'hardware' then
        f := fcHardware
    else if flow_control = 'software' then
        f := fcSoftware
    else
        f := fcNone;

    case baud_rate of
        110    : b := br110;
        300    : b := br300;
        600    : b := br600;
        1200   : b := br1200;
        2400   : b := br2400;
        4800   : b := br4800;
        9600   : b := br9600;
        14400  : b := br14400;
        19200  : b := br19200;
        38400  : b := br38400;
        57600  : b := br57600;
        115200 : b := br115200;
        128000 : b := br128000;
        256000 : b := br256000;
    else
        begin
            b := br9600;
            MessageDlg('O valor "' + IntToStr(baud_rate) + '" não é um Baud Rate válido. Foi aplicado o valor de "9600".', mtInformation, [mbOk], 0);
        end
    end;

    if porta > 0 then
        ComPort.Port := 'COM' + IntToStr(porta);
    ComPort.BaudRate := b;
    ComPort.FlowControl.FlowControl := f;
end;

function ComPort_AbrirPorta(const porta: integer = 0): boolean;
begin
    result := false;
    if ComPort.Connected then
        ComPort.Close;
    if porta > 0 then
        ComPort.Port := 'COM' + IntToStr(porta);

    try
        ComPort.Open();
    except
    end;

    Application.ProcessMessages();
    if ComPort.Connected then
    begin
        result := true;
    end;
end;

procedure ComPort_FecharPorta();
begin
    if ComPort.Connected then
        ComPort.Close();
end;

function ComPort_TxtDoBuffer(): String;
var
    len: Integer;
begin
    result := '';
    if not ComPort.Connected then
        Exit;
    ComPort.ReadStr(result, ComPort.InputCount);
end;

function ComPort_Enviar_e_Receber(porta: Integer; txt: String; aguardar: Integer): String;
begin
    result := '';
    if not ComPort_AbrirPorta(porta) then
        Exit;
    ComPort.WriteStr(txt);
    sleep(aguardar);
    result := ComPort_TxtDoBuffer();
    ComPort_FecharPorta();
end;

function ComPort_Enviar_e_Receber(porta: Integer; txtEnviar: String; var bytesRecebidos: TDinArrayBytes; const aguardar: integer = 0): boolean;
var
    len: Integer;
    b: Byte;
begin
    result := false;
    AByteInit(bytesRecebidos);
    if not ComPort_AbrirPorta(porta) then
        Exit;
    result := true;
    ComPort.WriteStr(txtEnviar);
    sleep(aguardar);
    while ComPort.InputCount > 0 do
    begin
        ComPort.Read(b, 1);
        AByteAdd(bytesRecebidos, b);
    end;
    ComPort_FecharPorta();
end;

function ComPort_Enviar_e_Receber(porta: Integer; txtEnviar: String; var txtRecebido: String; const aguardar: integer = 0): boolean;
var
    bytesRecebidos: TDinArrayBytes;
begin
    result := ComPort_Enviar_e_Receber(porta, txtEnviar, bytesRecebidos, aguardar);
    txtRecebido := AByteToStr(bytesRecebidos);
end;


function VersaoExe(ArquivoExe : string): String;
type
     PFFI = ^vs_FixedFileInfo;
var
    F: PFFI;
    Handle: Dword;
    Len: Longint;
    Data: Pchar;
    Buffer: Pointer;
    Tamanho: Dword;
    Parquivo: Pchar;
    Arquivo: String;
begin
    Arquivo := ArquivoExe;
    Parquivo := StrAlloc(Length(Arquivo) + 1);
    StrPcopy(Parquivo, Arquivo);
    Len := GetFileVersionInfoSize(Parquivo, Handle);
    Result := '';
    if Len > 0 then
    begin
        Data := StrAlloc(Len + 1);
        if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
        begin
            VerQueryValue(Data, '', Buffer, Tamanho);
            F := PFFI(Buffer);
            Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord
            (F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs), LoWord
            (F^.dwFileVersionLs)]);
        end;
        StrDispose(Data);
    end;
    StrDispose(Parquivo);
end;

// retorna verdadeiro se o diretório já existe ou foi criado
function MakeSubDirs(dir: String): boolean;
begin
    result := false;
    try
        if not DirectoryExists(dir) then
            SysUtils.ForceDirectories(dir);
        if DirectoryExists(dir) then
            result := true;
    except
    end;
end;

{Retorna a data/hora de criação de um arquivo}
function FileDateTime(path: String): TDateTime;
var
    d: Integer;
begin
    result := -1;
    if FileExists(path) then
    begin
        try
            d := SysUtils.FileAge(path);
            if d > -1 then
            begin
                result := FileDateToDateTime(d);
            end;
        except
        end;
    end;
end;

// retorna o número de bytes do arquivo ou -1 caso não encontre o arquivo
function FileSizeInBytes(fileName : wideString) : Int64;
var
    sr : TSearchRec;
begin
    if SysUtils.FindFirst(fileName, faAnyFile, sr ) = 0 then
    begin
        result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow);
    end
    else
    begin
        result := -1;
    end;
    SysUtils.FindClose(sr) ;
end;

// obtém o prefixo do arquivo sem a extensão
function FilePrefix(path: String): String;
var
    i: Integer;
begin
    result := '';
    if CharIndex(path, '\') > 0 then
        path := ExtractFileName(path);
    if (CharIndex(path, '.') > 1) then
        result := Copy(path, 1, CharIndex(path, '.') - 1);
end;

// obtém o sufixo ou extensão do arquivo
function FileSufix(path: String): String;
var
    i: Integer;
begin
    result := '';
    if CharIndex(path, '\') > 0 then
        path := ExtractFileName(path);
    if (CharIndex(path, '.') > 0) and (CharIndex(path, '.') < length(path)) then
        result := Copy(path, CharIndex(path, '.') + 1, length(path));
end;

{Nesta função você passa uma string contendo um array de parcelas
a pagar.  A função irá simplesmente ordenar as parcelas}
function parcelasOrdenar(strParcelas: String): String;
var
    s: TStringList;
    i, sizeA, sizeB: Integer;
    str: String;
    a, b: array of integer;
    n1, n2: Integer;
begin
    result := '';
    s := funcoes2.SplitStr(strParcelas, ',');
    for i := s.Count downto 1 do
    begin
        str := Trim(s.Strings[i-1]);
        if Trim(str) = '' then
            s.Delete(i-1)
        else
        begin
            while length(str) < 6 do
                str := '0' + str;
            s.Strings[i-1] := str;
        end;

    end;
    s.Sort;
    for i := 1 to s.Count do
        s.Strings[i-1] := IntToStr(StrToInt(s.Strings[i-1]));
    s.Text := Trim(s.Text);
    SizeA := 0;
    SetLength(a, 0);
    for i := 1 to s.Count do
    begin
        str := Trim(s.Strings[i-1]);
        if (str <> '') then
        begin
            try
                n1 := StrToInt(str);
                inc(SizeA);
                SetLength(a, SizeA);
                a[SizeA-1] := n1;
            except
            end;
        end;
    end;

    s.Text := '';
    str := '';
    for i := 1 to length(a) do
    begin
        if i > 1 then
            str := str + ',';
        str := str + IntToStr(a[i-1]);
    end;
    result := str;
end;


{Nesta função você passa uma string contendo um array de parcelas
a pagar.  A função irá ordenar as parcelas e retornará as lacunas
que faltam no meio da parcelas + uma parcela incrementando a última
parcela.
Ex.:
var
    p: String;
...
    p :=  parcelasQueFaltam('2,3,4,6,7,9');
    writeLn(p);
...
resultará em:
1,5,8,10
- 1,5,8 são as lacunas que faltam no meio das parcelas
- 10 é uma parcela incrementando a última}
function parcelasQueFaltam(strParcelas: String): String;
var
    s: TStringList;
    i, sizeA, sizeB: Integer;
    str: String;
    a, b: array of integer;
    n1, n2: Integer;
begin
    result := '';
    s := funcoes2.SplitStr(strParcelas, ',');
    for i := s.Count downto 1 do
    begin
        str := Trim(s.Strings[i-1]);
        if Trim(str) = '' then
            s.Delete(i-1)
        else
        begin
            while length(str) < 6 do
                str := '0' + str;
            s.Strings[i-1] := str;
        end;

    end;
    s.Sort;
    for i := 1 to s.Count do
        s.Strings[i-1] := IntToStr(StrToInt(s.Strings[i-1]));
    s.Text := Trim(s.Text);
    SizeA := 0;
    SetLength(a, 0);
    for i := 1 to s.Count do
    begin
        str := Trim(s.Strings[i-1]);
        if (str <> '') then
        begin
            inc(SizeA);
            SetLength(a, SizeA);
            a[SizeA-1] := StrToInt(str);
        end;
    end;
    SizeB := 0;
    SetLength(b, 0);
    for i := 1 to length(a) do
    begin
        if i < length(a) then
        begin
            n1 := a[i-1];
            n2 := a[i];
            while (n2 > n1+1) do
            begin
                n1 := n1 + 1;
                inc(SizeB);
                SetLength(b, SizeB);
                b[SizeB-1] := n1
            end;
        end;
    end;
    if (sizeA > 0) then
    begin
        inc(sizeB);
        SetLength(b, sizeB);
        b[sizeB-1] := a[sizeA-1] + 1;
    end;
    s.Text := '';
    str := '';
    for i := 1 to length(b) do
    begin
        if i > 1 then
            str := str + ',';
        str := str + IntToStr(b[i-1]);
    end;
    result := str;
end;


function FormatDateTimeSQL(data: TDateTime): String;
begin
    result := '' + #39 + FormatDateTime('yyyymmdd hh:nn:ss.zzz', data) + #39;
end;

function FormatDateSQL(data: TDateTime): String;
begin
    result := '''' + FormatDateTime('yyyymmdd', data) + '''';
end;

function FormatTimeSQL(data: TDateTime): String;
begin
    result := '''' + FormatDateTime('hh:nn:ss.zzz', data) + '''';
end;

function FormatStringSQL(s: String): String;
begin
    result := '' + #39 + Replace(s, #39, #39#39) + #39;
end;


// converte um valor para o formato YYYYMMDD HHNNSS.ZZZ
function GetDateTimeSQL(campo: String): String;
begin
    result := '(CONVERT(VARCHAR(30), (' + campo + '), 112) + '#39' '#39' + CONVERT(VARCHAR(30), (' + campo + '), 114))';
end;

// converte um valor para o formato YYYYMMDD HHNNSS.ZZZ
function GetDateSQL(campo: String): String;
begin
    result := '(CONVERT(VARCHAR(30), (' + campo + '), 112) + '#39' 00:00:00.000'#39')';
end;

// converte um valor para o formato YYYYMMDD HHNNSS.ZZZ
function GetTimeSQL(campo: String): String;
begin
    result := '(CONVERT(VARCHAR(30), CAST('''' AS DATETIME), 112) + '#39' '#39' + CONVERT(VARCHAR(30), (' + campo + '), 114))';
end;

function IsDateTimeSQL(dateTime: String): boolean;
var
    i: Integer;
begin
    result := false;
    if
        ((((Length(dateTime) = 23) and (dateTime[5] = '-') and (dateTime[8] = '-') and (dateTime[11] = ' ') and (dateTime[14] = ':') and (dateTime[17] = ':') and (dateTime[20] = '.'))
        or ((Length(dateTime) = 21) and (dateTime[9] = ' ') and (dateTime[12] = ':') and (dateTime[15] = ':') and (dateTime[18] = '.')))) then

    begin
        result := True;
        if (Length(dateTime) = 23) then
            dateTime := Copy(dateTime, 1, 4) + Copy(dateTime, 6, 2) + Copy(dateTime, 9, length(dateTime));

        dateTime[09] := '0';
        dateTime[12] := '0';
        dateTime[15] := '0';
        dateTime[18] := '0';

        for i := 1 to Length(dateTime) do
        begin
            if not (dateTime[i] in ['0'..'9']) then
            begin
                result := false;
                break;
            end;
        end;
    end;

    // avalia se a data/hora é uma data/hora válida
    if result = true then
    begin
        result :=
            DateUtils.IsValidDateTime(
                StrToInt(Copy(dateTime,1,4)), // yyyy
                StrToInt(Copy(dateTime,5,2)), // mm
                StrToInt(Copy(dateTime,7,2)), // dd
                StrToInt(Copy(dateTime,10,2)), // hh
                StrToInt(Copy(dateTime,13,2)), // nn
                StrToInt(Copy(dateTime,16,2)), // ss
                StrToInt(Copy(dateTime,19,3))  // ms
            );
    end;
end;


function StrInArray(str: String; strArray: Array of String; const caseSensitive: boolean = false): boolean;
var
    i: Integer;
begin
    result := false;
    if not caseSensitive then
    begin
        str := LowerCase(str);
        for i := Low(strArray) to High(strArray) do
        begin
            strArray[i] := LowerCase(strArray[i]);
        end;
    end;

    for i := Low(strArray) to High(strArray) do
    begin
        if str = strArray[i] then
        begin
            result := true;
            break;
        end;
    end;
end;

{Base64 é um método para codificação de dados para transferência na
Internet (Content Transfer Enconding).
É constituido por 64 caracteres ([A-Z-a-z 0-9], "/" e "+") que deram
origem ao seu nome. Também é utilizada para "guardar" textos "criptografados".}

function EncodeBase64(S: string): string;
const
    Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
var
    i: Integer;
    a: Integer;
    x: Integer;
    b: Integer;
begin
    Result := '';
    a := 0;
    b := 0;
    for i := 1 to Length(s) do
    begin
        x := Ord(s[i]);
        b := b * 256 + x;
        a := a + 8;
        while a >= 6 do
        begin
            a := a - 6;
            x := b div (1 shl a);
            b := b mod (1 shl a);
            Result := Result + Codes64[x + 1];
        end;
    end;
    if a > 0 then
    begin
        x := b shl (6 - a);
        Result := Result + Codes64[x + 1];
    end;
end;

{Base64 é um método para codificação de dados para transferência na
Internet (Content Transfer Enconding).
É constituido por 64 caracteres ([A-Z-a-z 0-9], "/" e "+") que deram
origem ao seu nome. Também é utilizada para "guardar" textos "criptografados".}

function DecodeBase64(S: string): string;
const
    Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
var
    i: Integer;
    a: Integer;
    x: Integer;
    b: Integer;
begin
    Result := '';
    a := 0;
    b := 0;
    for i := 1 to Length(s) do
    begin
        x := Pos(s[i], codes64) - 1;
        if x >= 0 then
        begin
            b := b * 64 + x;
            a := a + 6;
            if a >= 8 then
            begin
                a := a - 8;
                x := b shr a;
                b := b mod (1 shl a);
                x := x mod 256;
                Result := Result + chr(x);
            end;
        end
    else
        Exit;
    end;
end;


function StringIsInteger(str: String): boolean;
var
    i: Integer;
begin
    result := true;
    if str = '' then
        result := false
    else
        for i := 1 to length(str) do
            if not(str[i] in ['0'..'9']) then
            begin
                result := false;
                break;
            end;
end;

function StrIsDate(str: String): boolean;
var
    i: Integer;
    d: TDateTime;
begin
    result := false;
    try
        d := StrToDate(str);
        if d <> 0 then
            result := true;
    except
        result := False;
    end;
end;


function StrIsDateTime(str: String): boolean;
var
    i: Integer;
    d: TDateTime;
begin
    result := false;
    try
        d := StrToDateTime(str);
        if d <> 0 then
            result := true;
    except
        result := False;
    end;
end;

// retorna msg de vazia se deu tudo certo
function ExecSQLBatch(conn: TAdoConnection; sql: String; const continueOnError: boolean = false): String;
var
    l: TStringList;
    cmd: String;
    continuar: boolean;
    qtd: integer;
    i: Integer;
begin
    qtd := 0;
    continuar := true;
    result := '';
    cmd := '';
    l := TStringList.Create();

    try
        if FileExists(Trim(sql)) then
        begin
            l.LoadFromFile(Trim(sql));
        end
        else
        begin
            l.Text := sql;
        end;
    except
        l.Text := sql;
    end;
    sql := '';

    try
        for i := 1 to l.Count do
        begin
            if (UpperCase(Trim(l.Strings[i-1])) = 'GO') OR (i = l.Count) then
            begin
                try
                    if not (UpperCase(Trim(l.Strings[i-1])) = 'GO') then
                        cmd := cmd + l.Strings[i-1] + #13#10;
                    conn.Execute(cmd);
                    cmd := '';
                    inc(qtd);
                except
                    on e: Exception do
                    begin
                        continuar := continueOnError;
                        result := 'Erro SQL Batch (funcoes2.ExecSQLBatch): '#13#10 + e.Message;
                    end;
                end;
                if not continuar then
                    break;
            end
            else
            begin
                cmd := cmd + l.Strings[i-1] + #13#10;
            end;
        end;
    finally
        l.Free();
    end;
end;


function NumIntZeros(num: Integer; digitos: Integer): String;
begin
    result := IntToStr(num);
    while (length(result) < digitos) do
        result := '0' + result;
end;


{

Função para trabalhar com seções dentro de um texto.
Muito útil para trabalhar com multiplos scripts e textos dentro de um único arquivo.

Ex. de arquivo:

--- texto - início ---

@#Secao004#
Up All Night é o álbum de estreia da boy band
anglo-irlandesa One Direction, lançado em 18 de
novembro de 2011 na Irlanda e no Reino Unido,
prosseguindo com uma distribuição global no ano
seguinte.

@#Secao001#
Depois de terminar em terceiro lugar na sétima
temporada do The X Factor em dezembro de 2010,
a banda assinou com a Syco Music e começou a
gravar o disco na Suécia, no Reino Unido e nos
Estados Unidos, trabalhando com diversos
compositores e produtores.

@#Secao002#
O projeto deriva principalmente do estilo musical
pop e também direciona para o pop rock, dance-pop,
teen pop e power pop.

@#Secao001#
Seu conteúdo lírico é constituído em maioria por
frases sobre ser jovem, relacionamentos, mágoa e
empoderamento.

@#Secao005#
Em apoio ao produto, os integrantes apresentaram
as canções de Up All Night em programas
televisivos, prêmios musicais e durante a Up All
Night Tour.

--- texto - fim ---

Exeplos:
A) Listar seções contidas no texto:
> Lista := TextoListarSecoes(texto, '@#', '#');

O resultado da função aplicado ao texto mencionado é:
    'Secao001'#13#10+
    'Secao002'#13#10+
    'Secao003'#13#10+
    'Secao004'#13#10+
    'Secao005'#13#10

B) Obter uma seção:
> Secao := TextoLerSecao(texto, 'secao001', '@#', '#');

O resultado da função aplicado ao texto mencionado é:
    'Depois de terminar em terceiro lugar na sétima'#13#10+
    'temporada do The X Factor em dezembro de 2010,'#13#10+
    'a banda assinou com a Syco Music e começou a'#13#10+
    'gravar o disco na Suécia, no Reino Unido e nos'#13#10+
    'Estados Unidos, trabalhando com diversos'#13#10+
    'compositores e produtores.'#13#10+
    ''#13#10+
    'Seu conteúdo lírico é constituído em maioria por
    'frases sobre ser jovem, relacionamentos, mágoa e'#13#10+
    'empoderamento.'#13#10
}

function TextoListarSecoes(txt: String; const beginString: String = '@{'; const endString: String = '}'): String;
var
    s, secoes: TStringList;
    l, secao: String;
    i: Integer;
begin
    result := '';
    s := TStringList.Create();
    s.Text := '';
    secoes := TStringList.Create();
    secoes.Text := '';
    s.Text := txt;
    for i := 1 to s.Count do
    begin
        l := Trim(s.Strings[i-1]);
        if (length(l) > (length(beginString) + length(endString))) and (Copy(l,1,length(beginString)) = beginString) and (l[length(l)] = endString) then
        begin
            secao := Copy(l, length(beginString) + 1, ((length(l) - (length(beginString) + length(endString)))));
            if Secoes.IndexOf(secao) < 0 then
                Secoes.Add(secao);
        end;
    end;
    Secoes.Text := funcoes2.SortLines(Secoes.Text);
    result := Secoes.Text;
end;

function TextoLerSecao(txt, secao: String; const beginString: String = '@{'; const endString: String = '}'): String;
var
    s: TStringList;
    l, secaoItem: String;
    i: Integer;
    dentro: boolean;
begin
    result := '';
    s := TStringList.Create();
    s.Text := txt;
    dentro := false;
    for i := 1 to s.Count do
    begin
        l := Trim(s.Strings[i-1]);
        if (length(l) > (length(beginString) + length(endString))) and (Copy(l,1,length(beginString)) = beginString) and (l[length(l)] = endString) then
        begin
            secaoItem := Copy(l, length(beginString) + 1, ((length(l) - (length(beginString) + length(endString)))));
            if Trim(LowerCase(secao)) = Trim(LowerCase(secaoItem)) then
            begin
                dentro := True;
            end
            else
            begin
                dentro := False;
            end;
        end
        else
        begin
            if dentro then
                result := result + s.Strings[i-1] + #13#10;
        end;
    end;
end;


function Info(msg: String; const YesNo: boolean =  false): boolean;
begin
    result := false;
    if YesNo then
        result := MessageDlg(msg, mtInformation, [mbYes, mbNo], 0) = mrYes
    else
        MessageDlg(msg, mtInformation, [mbOk], 0);
end;

function Warning(msg: String; const YesNo: boolean =  false): boolean;
begin
    result := false;
    if YesNo then
        result := MessageDlg(msg, mtWarning, [mbYes, mbNo], 0) = mrYes
    else
        MessageDlg(msg, mtWarning, [mbOk], 0);
end;

function Confirm(msg: String; const YesNo: boolean =  false): boolean;
begin
    result := false;
    if YesNo then
        result := MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes
    else
        MessageDlg(msg, mtConfirmation, [mbOk], 0);
end;

function Error(msg: String; const YesNo: boolean =  false): boolean;
begin
    result := false;
    if YesNo then
        result := MessageDlg(msg, mtError, [mbYes, mbNo], 0) = mrYes
    else
        MessageDlg(msg, mtError, [mbOk], 0);
end;

// libera memória do aplicativo
procedure TrimAppMemorySize();
var
    MainHandle : THandle;
begin
    try
        MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
        SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
        CloseHandle(MainHandle) ;
    except
    end;
    Application.ProcessMessages;
end;


initialization

    CoInitialize(nil);
    AppInfo.TempDir := '';
    AppInfo.ADOConnection := nil;
	Appinfo.User.ID   := -1;
	Appinfo.User.Name := '';
	FQueryIndexCEP := -1;
	SHORTMONTHLIST :=
		ShortMonthNames[01] + CHR_LF +
		ShortMonthNames[02] + CHR_LF +
		ShortMonthNames[03] + CHR_LF +
		ShortMonthNames[04] + CHR_LF +
		ShortMonthNames[05] + CHR_LF +
		ShortMonthNames[06] + CHR_LF +
		ShortMonthNames[07] + CHR_LF +
		ShortMonthNames[08] + CHR_LF +
		ShortMonthNames[09] + CHR_LF +
		ShortMonthNames[10] + CHR_LF +
		ShortMonthNames[11] + CHR_LF +
		ShortMonthNames[12];

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

    ComPort := TComPort.Create(Application);



finalization


end.
