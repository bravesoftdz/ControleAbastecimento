object _dm: T_dm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 383
  Width = 648
  object IBDataBase1: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=UTF-8')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    AllowStreamedConnected = False
    Left = 48
    Top = 24
  end
  object qrAbastecimento: TIBQuery
    Database = IBDataBase1
    Transaction = IBTransaction1
    Left = 48
    Top = 80
  end
  object dsAbastecimento: TDataSource
    DataSet = qrAbastecimento
    Left = 144
    Top = 80
  end
  object qrBomba: TIBQuery
    Database = IBDataBase1
    Transaction = IBTransaction1
    Left = 48
    Top = 128
  end
  object qrConfiguracao: TIBQuery
    Database = IBDataBase1
    Transaction = IBTransaction1
    Left = 48
    Top = 184
  end
  object qrEntrada: TIBQuery
    Database = IBDataBase1
    Transaction = IBTransaction1
    Left = 48
    Top = 240
  end
  object qrTanque: TIBQuery
    Database = IBDataBase1
    Transaction = IBTransaction1
    Left = 48
    Top = 296
  end
  object dsBomba: TDataSource
    DataSet = qrBomba
    Left = 144
    Top = 128
  end
  object dsConfiguracao: TDataSource
    DataSet = qrConfiguracao
    Left = 144
    Top = 184
  end
  object dsEntrada: TDataSource
    DataSet = qrEntrada
    Left = 144
    Top = 240
  end
  object dsTanque: TDataSource
    DataSet = qrTanque
    Left = 144
    Top = 296
  end
  object IBTransaction1: TIBTransaction
    Left = 144
    Top = 24
  end
end
