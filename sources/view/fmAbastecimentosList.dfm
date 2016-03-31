object _fmAbastecimentosList: T_fmAbastecimentosList
  Left = 0
  Top = 0
  Caption = 'Abastecimentos'
  ClientHeight = 302
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sgLista: TStringGrid
    Left = 0
    Top = 67
    Width = 589
    Height = 194
    Align = alClient
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving]
    TabOrder = 1
    ColWidths = (
      64
      108
      77
      64
      64)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 67
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 13
      Height = 13
      Caption = 'De'
    end
    object Label2: TLabel
      Left = 142
      Top = 8
      Width = 17
      Height = 13
      Caption = 'At'#233
    end
    object dtpDe: TDateTimePicker
      Left = 8
      Top = 22
      Width = 128
      Height = 21
      Date = 42459.980942245370000000
      Time = 42459.980942245370000000
      TabOrder = 1
    end
    object dtpAte: TDateTimePicker
      Left = 142
      Top = 22
      Width = 128
      Height = 21
      Date = 42459.980942245370000000
      Time = 42459.980942245370000000
      TabOrder = 2
    end
    object btnListar: TButton
      Left = 276
      Top = 18
      Width = 75
      Height = 25
      Caption = 'Listar'
      TabOrder = 0
      OnClick = btnListarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 261
    Width = 589
    Height = 41
    Align = alBottom
    TabOrder = 2
    object lbTotais: TLabel
      Left = 8
      Top = 14
      Width = 6
      Height = 13
      Caption = '*'
    end
  end
end
