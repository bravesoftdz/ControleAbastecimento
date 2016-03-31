object _fmBombasList: T_fmBombasList
  Left = 0
  Top = 0
  Caption = 'Lista de Bombas'
  ClientHeight = 353
  ClientWidth = 555
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
    Width = 555
    Height = 101
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -108
    ExplicitWidth = 563
  end
  object sgLista: TStringGrid
    Left = 0
    Top = 101
    Width = 555
    Height = 211
    Align = alClient
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving]
    TabOrder = 1
    ExplicitLeft = -108
    ExplicitTop = 10
    ExplicitWidth = 563
    ExplicitHeight = 203
    ColWidths = (
      64
      115
      117
      164)
  end
  object Panel2: TPanel
    Left = 0
    Top = 312
    Width = 555
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = -108
    ExplicitTop = 172
    ExplicitWidth = 563
  end
end
