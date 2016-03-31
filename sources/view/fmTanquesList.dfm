object _fmTanquesList: T_fmTanquesList
  Left = 0
  Top = 0
  Caption = 'Lista de Tanques'
  ClientHeight = 345
  ClientWidth = 563
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 563
    Height = 101
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 19
      Width = 97
      Height = 23
      Caption = 'Capacidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 211
      Top = 19
      Width = 97
      Height = 23
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnSalvar: TButton
      Left = 407
      Top = 48
      Width = 89
      Height = 31
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSalvarClick
    end
    object edCapacidade: TEdit
      Left = 17
      Top = 48
      Width = 150
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edQuantidade: TEdit
      Left = 211
      Top = 48
      Width = 150
      Height = 31
      Color = 13882323
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object sgLista: TStringGrid
    Left = 0
    Top = 101
    Width = 563
    Height = 203
    Align = alClient
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving]
    TabOrder = 1
    OnSelectCell = sgListaSelectCell
    ColWidths = (
      64
      108
      77
      123)
  end
  object Panel2: TPanel
    Left = 0
    Top = 304
    Width = 563
    Height = 41
    Align = alBottom
    TabOrder = 2
  end
end
