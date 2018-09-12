unit UI.ListBox.SelectedEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList;

type
  TListSelectedEditor = class(TForm)
    lstLeft: TListBox;
    lstRight: TListBox;
    btnToLeft: TButton;
    btnToRight: TButton;
    btnAllToLeft: TButton;
    btnAllToRight: TButton;
    ActionList1: TActionList;
    actToRight: TAction;
    actToLeft: TAction;
    actAllToRight: TAction;
    actAllToLeft: TAction;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actToRightUpdate(Sender: TObject);
    procedure actToLeftUpdate(Sender: TObject);
    procedure actAllToRightUpdate(Sender: TObject);
    procedure actAllToLeftUpdate(Sender: TObject);
    procedure actToRightExecute(Sender: TObject);
    procedure actToLeftExecute(Sender: TObject);
    procedure actAllToRightExecute(Sender: TObject);
    procedure actAllToLeftExecute(Sender: TObject);
    procedure lstLeftDblClick(Sender: TObject);
    procedure lstRightDblClick(Sender: TObject);
    procedure lstRightClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
{$IFDEF DEBUG}
    procedure btnOKClick(Sender: TObject);
{$ENDIF}
  private
    FButtonWidth: Integer;
    FItems: TStrings;
    FSelectedItems: TStrings;
    function GetSelectedItems: TStrings;
    procedure SetSelectedItems(const Value: TStrings);
    procedure SetItems(const Value: TStrings);
  public
    property Items: TStrings read FItems write SetItems;
    property SelectedItems: TStrings read GetSelectedItems
      write SetSelectedItems;
  end;

var
  ListSelectedEditor: TListSelectedEditor;

implementation

{$R *.dfm}

const
  FORM_PADDING: Integer = 30;

procedure TListSelectedEditor.actAllToLeftExecute(Sender: TObject);
begin
  lstLeft.Items.Assign(lstRight.Items);
  lstRight.Clear;
end;

procedure TListSelectedEditor.actAllToLeftUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := lstRight.Count > 0;
end;

procedure TListSelectedEditor.actAllToRightExecute(Sender: TObject);
begin
  lstRight.Items.Assign(lstLeft.Items);
  lstLeft.Clear;
end;

procedure TListSelectedEditor.actAllToRightUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := lstLeft.Count > 0;
end;

procedure TListSelectedEditor.actToLeftExecute(Sender: TObject);
var
  item: string;
  itemObj: TObject;
begin
  item := lstRight.Items[lstRight.ItemIndex];
  itemObj := lstRight.Items.Objects[lstRight.ItemIndex];
  lstLeft.AddItem(item, itemObj);

  lstRight.Items.Delete(lstRight.ItemIndex);
end;

procedure TListSelectedEditor.actToLeftUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := lstRight.ItemIndex <> -1;
end;

procedure TListSelectedEditor.actToRightExecute(Sender: TObject);
var
  item: string;
  itemObj: TObject;
begin
  item := lstLeft.Items[lstLeft.ItemIndex];
  itemObj := lstLeft.Items.Objects[lstLeft.ItemIndex];
  lstRight.AddItem(item, itemObj);

  lstLeft.Items.Delete(lstLeft.ItemIndex);
end;

procedure TListSelectedEditor.actToRightUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := lstLeft.ItemIndex <> -1;
end;
{$IFDEF DEBUG}

procedure TListSelectedEditor.btnOKClick(Sender: TObject);
begin
  ShowMessage(SelectedItems.Text);
end;
{$ENDIF}

procedure TListSelectedEditor.FormCreate(Sender: TObject);
{$IFDEF DEBUG}
var
  btn: TButton;
  testItems: TStrings;
{$ENDIF}
begin
  self.ShowHint := true;
  self.Height := 500;
  self.Padding.Left := FORM_PADDING;
  self.Padding.Top := FORM_PADDING;
  self.Padding.Right := FORM_PADDING;
  self.Padding.Bottom := FORM_PADDING;
  FButtonWidth := 80;

  btnOK.Default := true;
  btnOK.ModalResult := mrOk;
  btnCancel.Cancel := true;
  btnCancel.ModalResult := mrCancel;

  actToLeft.Caption := '<';
  actToRight.Caption := '>';
  actAllToLeft.Caption := '<<';
  actAllToRight.Caption := '>>';

  actToLeft.Hint := 'SelectedToLeft';
  actToRight.Hint := 'SelectedToRight';
  actAllToLeft.Hint := 'AllToLeft';
  actAllToRight.Hint := 'AllToRight';

{$IFDEF DEBUG}
  btnOK.ModalResult := mrNone;
  btnOK.OnClick := self.btnOKClick;

  testItems := TStringList.Create;

  btn := TButton.Create(self);
  btn.Caption := 'Item 01';
  testItems.AddObject(btn.Caption, btn);

  btn := TButton.Create(self);
  btn.Caption := 'Item 02';
  testItems.AddObject(btn.Caption, btn);

  btn := TButton.Create(self);
  btn.Caption := 'Item 03';
  testItems.AddObject(btn.Caption, btn);

  btn := TButton.Create(self);
  btn.Caption := 'Item 04';

  testItems.AddObject(btn.Caption, btn);

  self.Items := testItems;

  testItems.Free;
{$ENDIF}
end;

procedure TListSelectedEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(self.FItems) then
    self.FItems.Free;
  if Assigned(self.FSelectedItems) then
    self.FSelectedItems.Free;
end;

procedure TListSelectedEditor.FormResize(Sender: TObject);
var
  listWidth, listHeight: Integer;
begin
  btnCancel.Left := self.ClientWidth - self.Padding.Right - btnCancel.Width;
  btnCancel.Top := self.ClientHeight - self.Padding.Bottom - btnCancel.Height;

  btnOK.Left := btnCancel.Left - btnCancel.Width - 8;
  btnOK.Top := btnCancel.Top;

  listWidth := (self.ClientWidth - self.Padding.Left - self.Padding.Right -
    FButtonWidth) div 2;

  listHeight := self.ClientHeight - self.Padding.Top - self.Padding.Bottom * 2 -
    btnCancel.Height;

  lstLeft.Height := listHeight;
  lstRight.Height := listHeight;

  lstLeft.Left := self.Padding.Left;
  lstLeft.Top := self.Padding.Top;
  lstLeft.Width := listWidth;

  lstRight.Left := self.Padding.Left + listWidth + FButtonWidth;
  lstRight.Top := self.Padding.Top;
  lstRight.Width := listWidth;

  btnToRight.Left := self.Padding.Left + listWidth + 8;
  btnToRight.Width := FButtonWidth - 16;
  btnToRight.Top := lstLeft.Top;

  btnToLeft.Left := btnToRight.Left;
  btnToLeft.Width := btnToRight.Width;
  btnToLeft.Top := btnToRight.Top + btnToRight.Height + 8;

  btnAllToRight.Left := btnToRight.Left;
  btnAllToRight.Width := btnToRight.Width;
  btnAllToRight.Top := btnToLeft.Top + btnToLeft.Height + 8;

  btnAllToLeft.Left := btnToRight.Left;
  btnAllToLeft.Width := btnToRight.Width;
  btnAllToLeft.Top := btnAllToRight.Top + btnAllToRight.Height + 8;

end;

function TListSelectedEditor.GetSelectedItems: TStrings;
begin
  if self.FSelectedItems = nil then
    self.FSelectedItems := TStringList.Create;

  self.FSelectedItems.Clear;
  self.FSelectedItems.Assign(lstRight.Items);

  Result := self.FSelectedItems;
end;

procedure TListSelectedEditor.lstLeftDblClick(Sender: TObject);
begin
  actToRight.Execute;
end;

procedure TListSelectedEditor.lstRightClick(Sender: TObject);
var
  btn: TButton;
begin
  if lstRight.ItemIndex = -1 then
    exit;
  btn := lstRight.Items.Objects[lstRight.ItemIndex] as TButton;
  self.Caption := btn.Caption;
end;

procedure TListSelectedEditor.lstRightDblClick(Sender: TObject);
begin
  actToLeft.Execute;
end;

procedure TListSelectedEditor.SetItems(const Value: TStrings);
begin
  if (FItems = nil) then
    FItems := TStringList.Create;
  FItems.Assign(Value);

  lstLeft.Items.Assign(FItems);
end;

procedure TListSelectedEditor.SetSelectedItems(const Value: TStrings);
begin
  if self.FItems.Count = 0 then
    exit;
end;

end.
