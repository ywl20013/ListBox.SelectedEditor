object ListSelectedEditor: TListSelectedEditor
  Left = 0
  Top = 0
  Caption = 'ListSelectedEditor'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object lstLeft: TListBox
    Left = 8
    Top = 13
    Width = 305
    Height = 228
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnDblClick = lstLeftDblClick
  end
  object lstRight: TListBox
    Left = 331
    Top = 13
    Width = 291
    Height = 228
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnClick = lstRightClick
    OnDblClick = lstRightDblClick
  end
  object btnToLeft: TButton
    Left = 319
    Top = 91
    Width = 75
    Height = 25
    Action = actToLeft
    TabOrder = 2
  end
  object btnToRight: TButton
    Left = 319
    Top = 60
    Width = 75
    Height = 25
    Action = actToRight
    TabOrder = 3
  end
  object btnAllToLeft: TButton
    Left = 319
    Top = 152
    Width = 75
    Height = 25
    Action = actAllToLeft
    TabOrder = 4
  end
  object btnAllToRight: TButton
    Left = 319
    Top = 122
    Width = 75
    Height = 25
    Action = actAllToRight
    TabOrder = 5
  end
  object btnOK: TButton
    Left = 448
    Top = 264
    Width = 75
    Height = 25
    Caption = 'btnOK'
    TabOrder = 6
  end
  object btnCancel: TButton
    Left = 547
    Top = 264
    Width = 75
    Height = 25
    Caption = 'btnCancel'
    TabOrder = 7
  end
  object ActionList1: TActionList
    Left = 312
    Top = 240
    object actToRight: TAction
      Caption = 'actToRight'
      OnExecute = actToRightExecute
      OnUpdate = actToRightUpdate
    end
    object actToLeft: TAction
      Caption = 'actToLeft'
      OnExecute = actToLeftExecute
      OnUpdate = actToLeftUpdate
    end
    object actAllToRight: TAction
      Caption = 'actAllToRight'
      OnExecute = actAllToRightExecute
      OnUpdate = actAllToRightUpdate
    end
    object actAllToLeft: TAction
      Caption = 'actAllToLeft'
      OnExecute = actAllToLeftExecute
      OnUpdate = actAllToLeftUpdate
    end
  end
end
