program Project2;

uses
  Vcl.Forms,
  UI.ListBox.SelectedEditor in 'UI.ListBox.SelectedEditor.pas' {ListSelectedEditor};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := true;
  Application.CreateForm(TListSelectedEditor, ListSelectedEditor);
  Application.Run;

end.
