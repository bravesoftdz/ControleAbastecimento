object _rptAbastecimentosPorPeriodo: T_rptAbastecimentosPorPeriodo
  Left = 0
  Top = 0
  Caption = 'Abastecimentos por Per'#237'odo'
  ClientHeight = 407
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = -4
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 96
      BandType = btHeader
      Color = 15263976
      ParentColor = False
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 3
        Top = 23
        Width = 275
        Height = 22
        Caption = 'LISTA DE ABASTECIMENTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 57
        Top = 74
        Width = 67
        Height = 16
        Caption = 'Data/Hora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 222
        Top = 74
        Width = 82
        Height = 16
        Caption = 'Combust'#237'vel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 342
        Top = 74
        Width = 49
        Height = 16
        Caption = 'Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 405
        Top = 74
        Width = 39
        Height = 16
        Caption = 'Litros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 549
        Top = 74
        Width = 60
        Height = 16
        Caption = 'Impostos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 668
        Top = 74
        Width = 36
        Height = 16
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object lbDe: TRLLabel
        Left = 342
        Top = 29
        Width = 67
        Height = 16
        HelpType = htKeyword
        Caption = 'Data/Hora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 435
        Top = 29
        Width = 12
        Height = 16
        Caption = 'a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
      object lbAte: TRLLabel
        Left = 453
        Top = 29
        Width = 67
        Height = 16
        Caption = 'Data/Hora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 163
      Width = 718
      Height = 87
      BandType = btFooter
      Color = 15263976
      ParentColor = False
      Transparent = False
      object RLSystemInfo1: TRLSystemInfo
        Left = 12
        Top = 56
        Width = 39
        Height = 16
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 342
        Top = 54
        Width = 87
        Height = 16
        Info = itPageNumber
        Transparent = False
      end
      object RLDBResult1: TRLDBResult
        Left = 150
        Top = 25
        Width = 140
        Height = 16
        DataField = 'VALORTOTAL2'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 14
        Top = 25
        Width = 130
        Height = 16
        Caption = 'TOTAL VENDIDO R$:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 134
      Width = 718
      Height = 29
      object RLSystemInfo3: TRLSystemInfo
        Left = 0
        Top = 6
        Width = 51
        Height = 16
        Info = itRecNo
        Transparent = False
      end
      object RLDBText1: TRLDBText
        Left = 57
        Top = 6
        Width = 159
        Height = 16
        DataField = 'DATAHORA'
        DataSource = DataSource1
      end
      object RLDBText2: TRLDBText
        Left = 222
        Top = 6
        Width = 114
        Height = 16
        DataField = 'NOME'
        DataSource = DataSource1
      end
      object C: TRLDBText
        Left = 342
        Top = 6
        Width = 52
        Height = 16
        DataField = 'BOMBA'
        DataSource = DataSource1
      end
      object RLDBText3: TRLDBText
        Left = 405
        Top = 6
        Width = 115
        Height = 16
        DataField = 'LITROS'
        DataSource = DataSource1
        DisplayMask = '###,##0.00'
      end
      object RLDBText4: TRLDBText
        Left = 530
        Top = 6
        Width = 79
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALORIMPOSTO'
        DataSource = DataSource1
      end
      object RLDBText5: TRLDBText
        Left = 615
        Top = 6
        Width = 88
        Height = 16
        Alignment = taRightJustify
        DataField = 'VALORTOTAL'
        DataSource = DataSource1
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = qrAbastecimento
    Left = 143
    Top = 344
  end
  object qrAbastecimento: TIBQuery
    Database = _dm.IBDataBase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT'
      '      a.DataHora,'
      '      b.Numero AS Bomba,'
      '     cast( a.Litros  AS Decimal(10,3)) AS Litros,'
      '      tp.Nome,'
      '      a.ValorPorLitro,'
      '      a.ValorParcial,'
      '      a.PercentualImposto,'
      '      cast( a.ValorImposto AS Decimal(10,3)) AS ValorImposto,'
      '      cast( a.ValorTotal AS Decimal(10,3)) AS ValorTotal,'
      
        '      cast(cast( a.ValorTotal AS Decimal(10,3)) AS Float) AS Val' +
        'orTotal2'
      'FROM ABASTECIMENTO AS a'
      '     LEFT JOIN BOMBA AS b ON a.Bomba_ID = b.ID'
      '     LEFT JOIN TANQUE AS t ON b.Tanque_ID = t.id'
      
        '     LEFT JOIN TIPOCOMBUSTIVEL AS tp ON t.TipoCombustivel_ID = t' +
        'p.id'
      'WHERE'
      '     a.DataHora BETWEEN :de AND :ate'
      'ORDER BY a.DataHora DESC')
    Left = 141
    Top = 310
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'de'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ate'
        ParamType = ptUnknown
      end>
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = _dm.IBDataBase1
    Left = 174
    Top = 312
  end
end
