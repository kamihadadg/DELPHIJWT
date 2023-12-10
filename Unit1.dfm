object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JSON API JWT'
  ClientHeight = 600
  ClientWidth = 999
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    999
    600)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 902
    Height = 82
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 8
    Top = 96
    Width = 902
    Height = 105
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    HideSelection = False
    TabOrder = 1
  end
  object Memo3: TMemo
    Left = 8
    Top = 207
    Width = 902
    Height = 101
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object cxGroupBox1: TcxGroupBox
    Left = 916
    Top = 0
    Align = alRight
    Caption = 'cxGroupBox1'
    TabOrder = 3
    Height = 600
    Width = 83
    object Button1: TButton
      Left = 3
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Login'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 3
      Top = 197
      Width = 75
      Height = 25
      Caption = 'GetTestData'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 3
      Top = 112
      Width = 75
      Height = 25
      Caption = 'ParsJson'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 3
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Show To Grid'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 314
    Width = 902
    Height = 286
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object cxGrid1DBTableView1RecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object cxGrid1DBTableView1DailyWorkDate: TcxGridDBColumn
        DataBinding.FieldName = 'DailyWorkDate'
        Width = 162
      end
      object cxGrid1DBTableView1TarafName: TcxGridDBColumn
        DataBinding.FieldName = 'TarafName'
      end
      object cxGrid1DBTableView1DailyWorkProfitAll: TcxGridDBColumn
        DataBinding.FieldName = 'DailyWorkProfitAll'
        Width = 217
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dxMemData1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 112
    Top = 392
    object dxMemData1DailyWorkDate: TIntegerField
      FieldName = 'DailyWorkDate'
    end
    object dxMemData1TarafName: TStringField
      FieldName = 'TarafName'
    end
    object dxMemData1DailyWorkProfitAll: TFloatField
      FieldName = 'DailyWorkProfitAll'
    end
  end
  object DataSource1: TDataSource
    DataSet = dxMemData1
    Left = 200
    Top = 400
  end
end
