unit uChekAnka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    btnTitleFromClipboard: TButton;
    btnGenTitle: TButton;
    mmoDscr: TMemo;
    btnDscrFromClipboard: TButton;
    mmoKlumba: TMemo;
    mmoKidSt: TMemo;
    mmoVK: TMemo;
    edtURL: TEdit;
    btnVKToClpbrd: TButton;
    btnNotVKToClpbrd: TButton;
    btnSEOToClpbrd: TButton;
    lblLenMainTitle: TLabel;
    btnMainToClpbrd: TButton;
    btnDscrToClpbrd: TButton;
    lblLenNotVK: TLabel;
    lblLenAukro: TLabel;
    btnAukroToClpb: TButton;
    mmoTemp: TMemo;
    btnGenDscr: TButton;
    edtNumDscr: TEdit;
    btnDscrKlumbaToClpb: TButton;
    btnDscrKidStToClpbrd: TButton;
    btnDscrVKToClpbrd: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtNumStrAdd: TEdit;
    lbl5: TLabel;
    btnURLFromClipboard: TButton;
    edtTitleAukro: TEdit;
    edtTitleNotVK: TEdit;
    edtTitleVK: TEdit;
    edtTitleSEO: TEdit;
    edtTitleOrig: TEdit;
    edtTitleKidSt: TEdit;
    btnKidStToClpbrd: TButton;
    lblLenKidSt: TLabel;
    btnDscrFullFromClipboard: TButton;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    bvl1: TBevel;
    lbl10: TLabel;
    bvl2: TBevel;
    bvl3: TBevel;
    bvl4: TBevel;
    bvl5: TBevel;
    bvl6: TBevel;
    lbl11: TLabel;
    edtBrand: TEdit;
    btnBrandToClpbrd: TButton;
    bvl7: TBevel;
    mmoAukro: TMemo;
    lbl12: TLabel;
    edtNumBrand: TEdit;
    procedure btnTitleFromClipboardClick(Sender: TObject);
    procedure btnGenTitleClick(Sender: TObject);
    procedure btnDscrFromClipboardClick(Sender: TObject);
    procedure btnVKToClpbrdClick(Sender: TObject);
    procedure btnNotVKToClpbrdClick(Sender: TObject);
    procedure btnSEOToClpbrdClick(Sender: TObject);
    procedure btnMainToClpbrdClick(Sender: TObject);
    procedure btnDscrToClpbrdClick(Sender: TObject);
    procedure btnAukroToClpbClick(Sender: TObject);
    procedure btnGenDscrClick(Sender: TObject);
    procedure btnDscrKlumbaToClpbClick(Sender: TObject);
    procedure btnDscrKidStToClpbrdClick(Sender: TObject);
    procedure btnDscrVKToClpbrdClick(Sender: TObject);
    procedure btnURLFromClipboardClick(Sender: TObject);
    procedure edtTitleAukroChange(Sender: TObject);
    procedure edtTitleNotVKChange(Sender: TObject);
    procedure edtTitleOrigChange(Sender: TObject);
    procedure edtTitleKidStChange(Sender: TObject);
    procedure btnKidStToClpbrdClick(Sender: TObject);
    procedure btnDscrFullFromClipboardClick(Sender: TObject);
    procedure btnBrandToClpbrdClick(Sender: TObject);
    procedure lbl7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

    function nameCut(name:string; n:Integer):string; // ����� ��������
    function lenHtmlStr(s:String):Integer; // ���������� ����� �������� (� ������ ������������)
    procedure textFromClipboard(witchName:Boolean); // ���� ����� �������� ��� ��������+�������� (witchName=true) �� ������
    procedure genTitle;
    procedure genDescription;
    procedure findMaterial(s:string); // ���� ������ � ��������


var
  MainForm: TMainForm;


implementation

{$R *.dfm}

// ���� ������ � ��������
procedure findMaterial(s:string);
var
  position : Integer;
begin
  position := AnsiPos('������', LowerCase(s));
  if position = 0
  then ShowMessage('''������'' �� ������� � �����������')
  else ShowMessage('''������'' ���� ������� ������� � ������� '+IntToStr(position));
end;

procedure textFromClipboard(witchName:Boolean); // ���� ����� �������� ��� ��������+�������� (witchName=true) �� ������
var i, shift:Integer;
  s:string;
  prBlank, blank:Boolean;
  numBrand:Integer;
begin
with MainForm do
begin

  mmoTemp.Clear;
  mmoTemp.PasteFromClipboard;
  mmoDscr.Clear;
  blank:=False;
  prBlank:=False;

  if witchName then
    begin
      shift:=1;
      s:=StringReplace(mmoTemp.Lines[0],'?','-',[rfReplaceAll, rfIgnoreCase]);
      edtTitleOrig.Text:=s;
      genTitle;
    end
  else shift:=0;

  for i:=0+shift to mmoTemp.Lines.Count-1 do
  begin
    s:=StringReplace(mmoTemp.Lines[i],'?','-',[rfReplaceAll, rfIgnoreCase]);
    if (Length(s)>1) then
    begin
      blank:=False;
      //s:=s+IntTostr(Length(s));
      mmoDscr.Lines.Add(s);
    end else
    begin
      blank:=True;
      if blank and not prBlank then mmoDscr.Lines.Add('');
    end;
    prBlank:=blank;
  end;
  numBrand:=StrToInt(edtNumBrand.Text);
  edtBrand.Text:=mmoDscr.Lines[numBrand];
  genDescription;


end;
end;

function nameCut(name:string; n:Integer):string; // ����� ��������
var s:String;
begin
  s:=name;
  if (lenHtmlStr(s)>n) then
    begin
      s:=StringReplace(name,' �����','',[rfReplaceAll, rfIgnoreCase]);
    end;
  if (lenHtmlStr(s)>n) then
    begin
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
      s:=StringReplace(s,' �������','',[rfReplaceAll, rfIgnoreCase]);
    end;
    nameCut:=s;
end;

function lenHtmlStr(s:String):Integer; // ���������� ����� �������� (� ������ ������������)
var
  n:Integer;
  sTemp:string;
begin
  // ���� ��� ��������� �� �������
  // ��. http://www.ascii.cl/htmlcodes.htm
  // & = &amp;
  // " = &quot;
  n:=Length(s);
  lenHtmlStr:=n;
end;  

procedure genTitle;
 var s, mainTxt, titleSEO, titleNotVk, titleKidSt, titleAukro, titleVK, idArticle, sBar:string;
 l, lenID:integer;
begin
  sBar:=' ';
  //������� ������� �������� �������� ����� ����� Atmosphere �.52 3761
  s:=MainForm.edtTitleOrig.Text ;
  s:=StringReplace(s,'  ',' ',[rfreplaceall]) ;
  s:=StringReplace(s,'  ',' ',[rfreplaceall]) ;
  s:=Trim(s);
  l:=Length(s);
  if ((s[l]='a') or (s[l]='A') or (s[l]='�') or (s[l]='�')) 
    then lenID:=5
    else lenID:=4;
// ���� ����� ������
  idArticle:=Copy(s,l-lenID+1,l);
  //idArticle:=StringReplace(idArticle,' ','',[rfreplaceall]);
// �������� �������� ����� � ��������� ��������
  mainTxt:=Copy(s,1,l-lenID-1);
  titleNotVk:=mainTxt+' �'+idArticle;
  titleKidSt:=nameCut(titleNotVk, 70);
  titleVk:=idArticle;
  titleVK:=titleVK+' '+mainTxt;
  titleAukro:=nameCut(mainTxt+' '+idArticle, 50);

//  titleAukro:=StringReplace(mainTxt,' �����','',[rfReplaceAll, rfIgnoreCase])+' '+idArticle;
//  if (Length(titleAukro)>50) then
//    begin
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//      titleAukro:=StringReplace(titleAukro,' �������','',[rfReplaceAll, rfIgnoreCase]);
//    end;

  MainForm.edtTitleNotVK.Text:=titleNotVk;
  MainForm.edtTitleKidSt.Text:=titleKidSt;
  MainForm.edtTitleVK.Text:=titleVK;
  MainForm.edtTitleAukro.Text:=titleAukro;

// ������� SEO keywords
  titleSEO:=StringReplace(mainTxt,' �����','',[rfReplaceAll, rfIgnoreCase]) ;
  titleSEO:=StringReplace(titleSEO,'����� ','',[rfReplaceAll, rfIgnoreCase]) ;
  titleSEO:=StringReplace(titleSEO,'�����','',[rfReplaceAll, rfIgnoreCase]) ;
  titleSEO:=StringReplace(titleSEO,' ',', ',[rfreplaceall]) ;
  titleSEO:=StringReplace(titleSEO,', ,',',',[rfreplaceall]) ;
  if (titleSEO[Length(titleSEO)-1]=',')
  then titleSEO:=Copy(titleSEO,1,Length(titleSEO)-2);

  MainForm.edtTitleSEO.Text:=titleSEO;
end;

procedure genDescription;
 var s, mainTxt, titleSEO, titleNotVk, titleVK, idArticle, sBar:string;
 i:integer;
 numDscr, numStrAdd:Integer;
begin
  with MainForm do
  begin
    mmoKlumba.Clear;
    mmoKidSt.Clear;
    mmoVK.Clear;
    mmoAukro.Clear;

(* ������ �����
    for i:=0 to mmoDscr.Lines.Count-1 do
    begin
      s:=StringReplace(mmoDscr.Lines[i],'?','-',[rfReplaceAll, rfIgnoreCase]) ;
      if (i<>1) then
      begin
        if ((Length(s)>1) or (i=3)) then
        mmoAukro.Lines.Add(s);
      end;
    end;
*)
// ����� �����
    for i:=0 to mmoDscr.Lines.Count-1 do
    begin
      s:=StringReplace(mmoDscr.Lines[i],'?','-',[rfReplaceAll, rfIgnoreCase]) ;
      mmoAukro.Lines.Add(s);
    end;

    numDscr:=StrToInt(edtNumDscr.Text);
    numStrAdd:=StrToInt(edtNumStrAdd.Text);

    for i:=numDscr to mmoDscr.Lines.Count-1 do
    begin
      s:=StringReplace(mmoDscr.Lines[i],'?','-',[rfReplaceAll, rfIgnoreCase]) ;
      mmoKlumba.Lines.Add(s);
      mmoKidSt.Lines.Add(s);
      mmoVK.Lines.Add(s);
    end;

    for i:=1 to numStrAdd do
    begin
      mmoKlumba.Lines.Add('');
      mmoKidSt.Lines.Add('');
      mmoVK.Lines.Add('');
    end;

    mmoKlumba.Lines.Add('����� �� �������� �������, ������� ����� �������� ����� �������� �������. ����� ��� ���������, ��� ���� �������, �� � ������� ����� �� � �� ������...');
    mmoKlumba.Lines.Add('');
    mmoKlumba.Lines.Add('� ���� ��������� ����� 800 ��������� �������, ����� ��� � ��������� ���������, �� ����� ������������� �����, � ����� 1500 ������ ��������� ������. ���� ��������� - ��������, ����� ��������.');

    mmoKidSt.Lines.Add('�� ������ ���������� ��� ����, � ����� ����� 800 ������ ���������� ������� � 1500 ������ ��������� ����� �� ����� ������������� ����� �� ���� �����, ��������-����������� Chek-Anka.com.ua:');
    mmoKidSt.Lines.Add('http://chek-anka.com.ua');
    mmoKidSt.Lines.Add('');
    mmoKidSt.Lines.Add('�� ����� ��������� ����� ������ �����������, ��� ������ � �������, ���� ���������, ���� ����������� ���������� �� �������� � �������.');
    mmoKidSt.Lines.Add('��������� �������� ���������:');
    mmoKidSt.Lines.Add('https://vk.com/chek_anka_com_ua');
    mmoKidSt.Lines.Add('�������������� �� ����������, ������� ��������� ������ ������ ))');

    mmoVK.Lines.Add('�� ������ ���������� ��� ����, � ����� ����� 800 ������ ���������� ������� � 1500 ������ ��������� ����� �� ����� ������������� ����� �� ���� �����, ��������-����������� Chek-Anka.com.ua:');
    mmoVK.Lines.Add('');
    mmoVK.Lines.Add('http://chek-anka.com.ua');
    mmoVK.Lines.Add('');
    mmoVK.Lines.Add('� ������ �� ���� ���� � ��������:');
    mmoVK.Lines.Add(edtURL.Text);
    mmoVK.Lines.Add('');
    mmoVK.Lines.Add('�� ����� ��������� ����� ������ �����������, ��� ������ � �������, ���� ���������, ���� ����������� ���������� �� �������� � �������.');
    mmoVK.Lines.Add('');
    mmoVK.Lines.Add('�������������� �� ����������, ������� ��������� ������ ������ ))');
    mmoVK.Lines.Add('');
    mmoVK.Lines.Add('�����! ����� �� �������� �������, ������� ����� �������� ����� �������� �������. ����� ��� ���������, ��� ���� �������, �� � ������� ����� �� � �� ������...');
  end;
end;

procedure TMainForm.btnTitleFromClipboardClick(Sender: TObject);
begin
  edtTitleOrig.Clear;
  edtTitleOrig.PasteFromClipboard;
  genTitle;
end;

procedure TMainForm.btnGenTitleClick(Sender: TObject);
begin
  genTitle;
end;

procedure TMainForm.btnDscrFromClipboardClick(Sender: TObject);
begin
  textFromClipboard(False);
end;
{
procedure TMainForm.btnDscrFromClipboardClick(Sender: TObject);
var i:Integer;
  s:string;
  prBlank, blank:Boolean;
begin
  mmoTemp.Clear;
  mmoTemp.PasteFromClipboard;
  mmoDscr.Clear;
  blank:=False;
  prBlank:=False;

  for i:=0 to mmoTemp.Lines.Count-1 do
  begin
    s:=StringReplace(mmoTemp.Lines[i],'?','-',[rfReplaceAll, rfIgnoreCase]);
    if (Length(s)>1) then
    begin
      blank:=False;
      //s:=s+IntTostr(Length(s));
      mmoDscr.Lines.Add(s);
    end else
    begin
      blank:=True;
      if blank and not prBlank then mmoDscr.Lines.Add('');
    end;
    prBlank:=blank;
  end;

  genDescription;
end;
}
procedure TMainForm.btnVKToClpbrdClick(Sender: TObject);
begin
  edtTitleVK.SelectAll;
  edtTitleVK.CopyToClipboard;
end;

procedure TMainForm.btnNotVKToClpbrdClick(Sender: TObject);
begin
  edtTitleNotVK.SelectAll;
  edtTitleNotVK.CopyToClipboard;
end;

procedure TMainForm.btnSEOToClpbrdClick(Sender: TObject);
begin
  edtTitleSEO.SelectAll;
  edtTitleSEO.CopyToClipboard;
end;

procedure TMainForm.btnMainToClpbrdClick(Sender: TObject);
begin
  edtTitleOrig.SelectAll;
  edtTitleOrig.CopyToClipboard;

end;

procedure TMainForm.btnDscrToClpbrdClick(Sender: TObject);
begin
  mmoAukro.SelectAll;
  mmoAukro.CopyToClipboard;
end;

procedure TMainForm.btnAukroToClpbClick(Sender: TObject);
begin
  edtTitleAukro.SelectAll;
  edtTitleAukro.CopyToClipboard;
end;

procedure TMainForm.btnGenDscrClick(Sender: TObject);
begin
  genDescription;
end;

procedure TMainForm.btnDscrKlumbaToClpbClick(Sender: TObject);
begin
  mmoKlumba.SelectAll;
  mmoKlumba.CopyToClipboard;
end;

procedure TMainForm.btnDscrKidStToClpbrdClick(Sender: TObject);
begin
  mmoKidSt.SelectAll;
  mmoKidSt.CopyToClipboard;
end;

procedure TMainForm.btnDscrVKToClpbrdClick(Sender: TObject);
begin
  mmoVK.SelectAll;
  mmoVK.CopyToClipboard;
end;

procedure TMainForm.btnURLFromClipboardClick(Sender: TObject);
begin
  edtURL.Clear;
  edtURL.PasteFromClipboard;
  btnDscrFullFromClipboard.Enabled:=True;
end;

procedure TMainForm.edtTitleAukroChange(Sender: TObject);
  var n:Integer;
  s:string;
begin
  n:=Length(edtTitleAukro.Text);
  lblLenAukro.Caption:=IntToStr(n);
  if n>50 then lblLenAukro.Color:=clRed
  else lblLenAukro.Color:=clBtnFace;
end;

procedure TMainForm.edtTitleNotVKChange(Sender: TObject);
  var n:Integer;
  s:string;
begin
  n:=Length(edtTitleNotVK.Text);
  lblLenNotVK.Caption:=IntToStr(n);
//  if n>70 then lblLenNotVK.Color:=clRed
//  else lblLenNotVK.Color:=clBtnFace;
end;

procedure TMainForm.edtTitleOrigChange(Sender: TObject);
begin
  lblLenMainTitle.Caption:=IntToStr(Length(edtTitleOrig.Text));
end;

procedure TMainForm.edtTitleKidStChange(Sender: TObject);
  var n:Integer;
  s:string;
begin
  n:=Length(edtTitleKidSt.Text);
  lblLenKidSt.Caption:=IntToStr(n);
  if n>70 then lblLenKidSt.Color:=clRed
  else lblLenKidSt.Color:=clBtnFace;
end;

procedure TMainForm.btnKidStToClpbrdClick(Sender: TObject);
begin
  edtTitleKidSt.SelectAll;
  edtTitleKidSt.CopyToClipboard;
end;

procedure TMainForm.btnDscrFullFromClipboardClick(Sender: TObject);
begin
  textFromClipboard(True);
  edtTitleAukro.SelectAll;
  edtTitleAukro.CopyToClipboard;
  btnDscrFullFromClipboard.Enabled:=False;
end;

procedure TMainForm.btnBrandToClpbrdClick(Sender: TObject);
begin
  edtBrand.SelectAll;
  edtBrand.CopyToClipboard;
end;


procedure TMainForm.lbl7Click(Sender: TObject);
begin
  btnDscrFullFromClipboard.Enabled:=True;
end;

end.
