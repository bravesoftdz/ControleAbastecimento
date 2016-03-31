object _fmFiltroPeriodo: T_fmFiltroPeriodo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Periodo'
  ClientHeight = 107
  ClientWidth = 253
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
  object Label1: TLabel
    Left = 20
    Top = 10
    Width = 17
    Height = 13
    Caption = 'De:'
  end
  object Label2: TLabel
    Left = 130
    Top = 10
    Width = 21
    Height = 13
    Caption = 'At'#233':'
  end
  object dtpDe: TDateTimePicker
    Left = 20
    Top = 29
    Width = 104
    Height = 21
    Date = 42460.462235023150000000
    Time = 42460.462235023150000000
    TabOrder = 0
    OnChange = dtpDeChange
  end
  object dtpAte: TDateTimePicker
    Left = 130
    Top = 29
    Width = 104
    Height = 21
    Date = 42460.462235023150000000
    Time = 42460.462235023150000000
    TabOrder = 1
    OnChange = dtpAteChange
  end
  object btnConfirma: TBitBtn
    Left = 49
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Confirma'
    TabOrder = 2
    Kind = bkOK
  end
  object btnCancela: TBitBtn
    Left = 130
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancela'
    TabOrder = 3
    Kind = bkCancel
  end
end
