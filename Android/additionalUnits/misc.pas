{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit misc;

interface

uses AESObj, SPECKObj, FMX.Objects, IdHash, IdHashSHA, IdSSLOpenSSL, languages,
  System.Hash, MiscOBJ,
  System.SysUtils, System.IOUtils, HashObj, System.Types, System.UITypes,
  System.DateUtils, System.Generics.Collections,
  System.Classes,
  System.Variants, Math,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Styles, System.ImageList, FMX.ImgList, FMX.Ani,
  FMX.Layouts, FMX.ExtCtrls, Velthuis.BigIntegers, FMX.ScrollBox, FMX.Memo,
  FMX.Platform,
  FMX.TabControl, System.Sensors, System.Sensors.Components, FMX.Edit, JSON,
  JSON.Builders, JSON.Readers, DelphiZXingQRCode,

  System.Net.HttpClientComponent, System.Net.HttpClient, keccak_n, tokenData,
  cryptoCurrencyData, WalletStructureData, AccountData

{$IFDEF ANDROID},

  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Webkit,
  Androidapi.JNIBridge
{$ELSE}
    , ShellApi

{$ENDIF};

{$IFDEF ANDROID}

const
  StrStartIteration = 0;

type
  AnsiString = string;

type
  WideString = string;

type
  AnsiChar = Char;
{$ELSE}

const
  StrStartIteration = 1;
{$ENDIF}

type
  popupWindow = class(TPopup)
  public

    messageLabel: TLabel;

    procedure _onEnd(sender: TObject);

    constructor Create(mess: AnsiString);

  end;

type
  popupWindowOK = class(TPopup)
  private

    _ImageLayout: TLayout;
    _Image: TImage;

    _OKbutton: TButton;
    _lblMessage: TLabel;

    _onOKButtonPress: TProc;

    procedure _OKButtonpress(sender: TObject);
    procedure _onEnd(sender: TObject);

  public
    constructor Create(OK: TProc; mess: AnsiString;
      ButtonText: AnsiString = 'OK'; icon: integer = 1);

  end;

type
  popupWindowYesNo = class(TPopup)
  private
    _lblMessage: TLabel;

    _ImageLayout: TLayout;
    _Image: TImage;

    _ButtonLayout: TLayout;
    _YesButton: TButton;
    _NoButton: TButton;

    _onYesPress: TProc;
    _onNoPress: TProc;

    procedure _onYesClick(sender: TObject);
    procedure _onNoClick(sender: TObject);
    procedure _OnExit(sender: TObject);

  public
    constructor Create(Yes, No: TProc; mess: AnsiString;
      YesText: AnsiString = 'Yes'; NoText: AnsiString = 'No';
      icon: integer = 2);
  end;

type
  TKeccakMaxDigest = packed array [0 .. 63] of System.UInt8;
  { Keccak-512 digest }
{$IFDEF ANDROID}

type
  JFileProvider = interface;

  JFileProviderClass = interface(JContentProviderClass)
    ['{33A87969-5731-4791-90F6-3AD22F2BB822}']
    { class } function getUriForFile(context: JContext; authority: JString;
      _file: JFile): Jnet_Uri; cdecl;
    { class } function init: JFileProvider; cdecl;
  end;

  [JavaSignature('android/support/v4/content/FileProvider')]
  JFileProvider = interface(JContentProvider)
    ['{12F5DD38-A3CE-4D2E-9F68-24933C9D221B}']
    procedure attachInfo(context: JContext; info: JProviderInfo); cdecl;
    function delete(uri: Jnet_Uri; selection: JString;
      selectionArgs: TJavaObjectArray<JString>): integer; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    function onCreate: Boolean; cdecl;
    function openFile(uri: Jnet_Uri; mode: JString)
      : JParcelFileDescriptor; cdecl;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>;
      selection: JString; selectionArgs: TJavaObjectArray<JString>;
      sortOrder: JString): JCursor; cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString;
      selectionArgs: TJavaObjectArray<JString>): integer; cdecl;
  end;

  TJFileProvider = class(TJavaGenericImport<JFileProviderClass, JFileProvider>)
  end;
{$ENDIF}

function isP2PKH(netbyte: AnsiString; coinid: integer): Boolean;
function isSegwitAddress(address: AnsiString): Boolean;
function decodeAddressInfo(address: AnsiString; coinid: integer): TAddressInfo;
function getHighestBlockNumber(T: Token): System.uint64;
function toMnemonic(hex: AnsiString): AnsiString;
function BIntTo256Hex(data: BigInteger; Padding: integer): AnsiString;
function isEthereum(): Boolean;
procedure refreshWalletDat();
function inttoeth(data: System.uint64): AnsiString; overload;
function inttoeth(data: BigInteger): AnsiString; overload;
function speckEncrypt(tcaKey, data: AnsiString): AnsiString;
function speckDecrypt(tcaKey, data: AnsiString): AnsiString;
function hexatotbytes(H: AnsiString): Tbytes;

function getUTXO(wallet: TWalletInfo): TUTXOS;
function getDataOverHTTP(aURL: String): AnsiString;
function parseUTXO(utxos: AnsiString): TUTXOS;
function IntToTX(data: System.uint64; Padding: integer): AnsiString; overload;
function IntToTX(data: BigInteger; Padding: integer): AnsiString; overload;
function randomHexStream(size: integer): AnsiString;
procedure wipeWalletDat;
function AES256CBCDecrypt(tcaKey, data: AnsiString): AnsiString;
function GetSHA256FromHex(H: AnsiString): AnsiString;
function HexToStream(H: AnsiString): TStream;
procedure parseWalletFile;
procedure createWalletDat();
procedure GenetareCoinsData(seed, password: AnsiString; ac: Account);
function seedToHumanReadable(seed: AnsiString): AnsiString;
function GetStrHashSHA256(Str: AnsiString): AnsiString;
function hash160FromHex(H: AnsiString): AnsiString;
function TCA(dane: AnsiString): AnsiString;
function AES256CBCEncrypt(tcaKey, data: AnsiString): AnsiString;
function isWalletDatExists: Boolean;
procedure wipeAnsiString(var toWipe: AnsiString);
function reverseHexOrder(s: AnsiString): AnsiString;
function priv256forHD(coin, x, y: integer; MasterSeed: AnsiString): AnsiString;

procedure repaintWalletList;
function satToBtc(sat: AnsiString; decimals: integer): AnsiString; overload;
function satToBtc(num: BigInteger; decimals: integer): AnsiString; overload;
function getStringFromImage(img: TBitmap): AnsiString;
function findAddress(Str: AnsiString): AnsiString;
function SplitString(Str: AnsiString; separator: AnsiChar = ' '): TStringList;
function IsHex(s: string): Boolean;
function keccak256String(s: AnsiString): AnsiString;
function keccak256Hex(s: AnsiString): AnsiString;
procedure createAddWalletView();
function cutEveryNChar(n: integer; Str: AnsiString; sep: AnsiChar = ' ')
  : AnsiString;
function removeSpace(Str: AnsiString): AnsiString;
function generateIcon(hex: AnsiString): TBitmap;
procedure wipeTokenDat();
procedure clearVertScrollBox(VSB: TVertScrollBox);
procedure showMsg(backView: TTabItem; message: AnsiString;
  warningImage: TBitmap = nil);
function BigIntegerToFloatStr(const num: BigInteger; decimals: integer;
  precision: integer = -1): AnsiString;
function StrFloatToBigInteger(Str: AnsiString; decimals: integer): BigInteger;
function BigIntegerBeautifulStr(num: BigInteger; decimals: integer): AnsiString;
function getConfirmedAsString(wi: TWalletInfo): AnsiString;
function fromMnemonic(input: AnsiString): integer; overload;
function fromMnemonic(input: TStringList): AnsiString; overload;
function BitmapDataToScaledBitmap(data: TBitmapData; scale: integer): TBitmap;
function parseQRCode(Str: AnsiString): TStringList;
function isBech32Address(Str: AnsiString): Boolean;
procedure createHistoryList(wallet: cryptoCurrency);
procedure RefreshGlobalFiat();
procedure Vibrate(ms: int64);
procedure refreshOrderInDashBrd();
procedure loadDictionary(langData: WideString);
procedure refreshComponentText();
procedure refreshCurrencyValue();
procedure updateBalanceLabels();

Function StrToQRBitmap(Str: AnsiString; pixelSize: integer = 6): TBitmap;
procedure shareFile(path: AnsiString);
procedure synchronizeCurrencyValue();
procedure LoadCurrencyFiatFromFile();
function bitcoinCashAddressToCashAddress(address: AnsiString): AnsiString;
function BCHCashAddrToLegacyAddr(address: AnsiString): AnsiString;
function CreateNewAccount(name, pass, seed: AnsiString): Account;
procedure AddAccountToFile(ac: Account);

Procedure CreateNewAccountAndSave(name, pass, seed: AnsiString;
  userSaveSeed: Boolean);

procedure CreatePanel(crypto: cryptoCurrency);

procedure creatImportPrivKeyCoinList();
function getETHValidAddress(address: AnsiString): AnsiString;
function isValidETHAddress(address: AnsiString): Boolean;
procedure searchTokens(InAddress: AnsiString);
function inputType(input: TBitcoinOutput): integer;
// procedure refresh

const
  HODLER_URL = 'https://hodler1.nq.pl/';
  HODLER_ETH = 'https://hodler2.nq.pl/';
  API_PUB = '';
  API_PRIV = '';

var
  TCAIterations: integer;
  userSavedSeed: Boolean;
  saveSeedInfoShowed: Boolean = false;
  test: AnsiString;
  globalFiat: single;
  lastChose: integer;
  lastView: TTabItem;
  isTokenDataInUse: Boolean = false;

  i: integer;

implementation

uses Bitcoin, uHome, base58, bech32, Ethereum, coinData, strutils, secp256k1
{$IFDEF ANDROID}
{$ELSE}
{$ENDIF};

var
  bitmapData: TBitmapData;

  /// ////////////////////////////////////////////////////////////////
procedure searchTokens(InAddress: AnsiString);
var
  data: AnsiString;
  JsonValue: TJsonvalue;
  JsonTokens: TJsonArray;
  JsonIt: TJsonvalue;
  T: Token;
  address, name, decimals, symbol: AnsiString;
  i: integer;
  createToken: boolean;
  createFromList: boolean;
  CreateFromListIndex: integer;
begin
  data := getDataOverHTTP('https://api.ethplorer.io/getAddressInfo/' +
    InAddress + '?apiKey=freekey');
  JsonValue := TJSONObject.ParseJSONValue(data);

  if JsonValue is TJSONObject then
  begin
    if JsonValue.tryGetValue<TJsonArray>('tokens', JsonTokens) then
      for JsonIt in JsonTokens do
      begin

        address := JsonIt.GetValue<string>('tokenInfo.address');
        decimals := JsonIt.GetValue<string>('tokenInfo.decimals');

        try
          name := JsonIt.GetValue<string>('tokenInfo.name');
        except
          on E: Exception do
          begin
            name := '';
            showmessage('Load Token Name Error ' + E.Message);
          end;
        end;

        try
          symbol := JsonIt.GetValue<string>('tokenInfo.symbol');
        except
          on E: Exception do
          begin
            symbol := '';
            showmessage('Load Token Symbol Error ' + E.Message);
          end;
        end;

        createToken := true;
        for i := 0 to Length(CurrentAccount.myTokens) - 1 do
        begin
          if (AnsiLowerCase(CurrentAccount.myTokens[i].addr) = AnsiLowerCase(InAddress)) and
            (AnsiLowerCase(CurrentAccount.myTokens[i]._contractAddress) = AnsiLowerCase(address)) then
          begin
            createToken := false;
            break;
          end;
        end;

        if createToken then
        begin

          createFromList := false;
          for i := 0 to Length(Token.availableToken) - 1 do
          begin
            if AnsiLowerCase(Token.availableToken[i].address) = AnsiLowerCase(address) then
            begin
              createFromList := true;
              CreateFromListIndex := i;
              break;

            end;

          end;

          if createFromList then
          begin
            T := Token.Create(CreateFromListIndex, InAddress);
          end
          else
          begin
            T := Token.CreateCustom(address, name, symbol, strToInt(decimals),
              InAddress);
          end;

          T.idInWallet := Length(CurrentAccount.myTokens) + 10000;

          CurrentAccount.addToken(T);
          CurrentAccount.SaveFiles();
          CreatePanel(T);
        end;

      end;

  end;

end;
function isValidETHAddress(address: AnsiString): Boolean;
begin
  result := address = getETHValidAddress(address);
end;

function getETHValidAddress(address: AnsiString): AnsiString;
var
  hex: AnsiString;
  ans: AnsiString;
  addr: AnsiString;
begin

  addr := Rightstr(address, length(address) - 2); // '0x'
  hex := keccak256String(lowercase(addr));
  ans := '0x';

  for i := low(addr) to high(addr) do
  begin

    if strToInt('$' + hex[i]) > 7 then
      ans := ans + UpperCase(addr[i])
    else
      ans := ans + lowercase(addr[i]);

  end;
  result := ans;
end;

procedure AddAccountToFile(ac: Account);
begin

  ac.SaveFiles();

  SetLength(AccountsNames, length(AccountsNames) + 1);
  AccountsNames[length(AccountsNames) - 1] := ac.name;
  refreshWalletDat;

end;

Procedure CreateNewAccountAndSave(name, pass, seed: AnsiString;
  userSaveSeed: Boolean);
var
  thr: TThread;
begin
  thr := TThread.CreateAnonymousThread(
    procedure
    var
      ac: Account;
    begin
      ac := CreateNewAccount(name, pass, seed);
      ac.userSaveSeed := userSaveSeed;
      AddAccountToFile(ac);
      ac.free;

      TThread.Synchronize(nil,
        procedure
        begin
          frmHome.FormShow(nil);
        end);

    end);

  thr.Start;
end;

function CreateNewAccount(name, pass, seed: AnsiString): Account;
var
  ac: Account;
begin
  ac := Account.Create(name);

  ac.TCAIterations := TCAIterations;
  ac.EncryptedMasterSeed := speckEncrypt((TCA(pass)), seed);
  ac.userSaveSeed := false;

  GenetareCoinsData(seed, pass, ac);
  result := ac;
end;

procedure CreatePanel(crypto: cryptoCurrency);
var
  Panel: Tpanel;
  coinName: TLabel;
  balLabel: TLabel;
  adrLabel: TLabel;
  coinIMG: TImage;
begin
  with frmHome.WalletList do
  begin

    Panel := Tpanel.Create(frmHome.WalletList);
    Panel.Align := Panel.Align.alTop;
    Panel.Height := 48;
    Panel.Visible := true;
    Panel.Parent := frmHome.WalletList;

    Panel.TagObject := crypto;

    Panel.Position.y := crypto.orderInWallet;

    Panel.Touch.InteractiveGestures := [TInteractiveGesture.LongTap];
    Panel.OnGesture := frmHome.SwitchViewToOrganize;
{$IFDEF ANDROID}
    Panel.OnTap := frmHome.OpenWalletView;
{$ELSE}
    Panel.OnClick := frmHome.OpenWalletView;
{$ENDIF}
    adrLabel := TLabel.Create(frmHome.WalletList);
    adrLabel.StyledSettings := adrLabel.StyledSettings - [TStyledSetting.size];
    adrLabel.TextSettings.Font.size := dashBoardFontSize;
    adrLabel.Parent := Panel;

    if crypto.description = '' then
    begin
      adrLabel.text := crypto.name + ' (' + crypto.shortcut + ')';
    end
    else
      adrLabel.text := crypto.description;
    adrLabel.AutoSize := false;
    adrLabel.Visible := true;
    adrLabel.TextSettings.WordWrap := false;
    adrLabel.Width := 150;
    adrLabel.Height := 48;
    adrLabel.Position.x := 52;
    adrLabel.Position.y := 0;
    adrLabel.AutoSize := false;
    adrLabel.Visible := true;
    adrLabel.TextSettings.WordWrap := false;
    adrLabel.TagString := 'name';
    balLabel := TLabel.Create(frmHome.WalletList);
    balLabel.StyledSettings := balLabel.StyledSettings - [TStyledSetting.size];
    balLabel.TextSettings.Font.size := dashBoardFontSize;
    balLabel.Parent := Panel;
    balLabel.text := BigIntegerBeautifulStr(crypto.confirmed, crypto.decimals) +
      '    ' + floatToStrF(crypto.getFiat, ffFixed, 15, 2) + ' ' +
      CurrencyConverter.symbol;
    balLabel.TextSettings.HorzAlign := TTextAlign.Trailing;
    balLabel.Visible := true;
    balLabel.Width := 200;
    balLabel.Height := 48;
    balLabel.Align := TAlignLayout.FitRight;
    balLabel.TextSettings.Font.size := adrLabel.TextSettings.Font.size - 3;
    balLabel.Margins.Right := 15;
    balLabel.TagString := 'balance';
    coinIMG := TImage.Create(frmHome.WalletList);
    coinIMG.Parent := Panel;
    if crypto is TWalletInfo then
      coinIMG.Bitmap := getCoinIcon(TWalletInfo(crypto).coin)
    else
      coinIMG.Bitmap := Token(crypto).Image;
    coinIMG.Height := 32.0;
    coinIMG.Width := 50;
    coinIMG.Position.x := 4;
    coinIMG.Position.y := 8;
  end;
end;

function inputType(input: TBitcoinOutput): integer;
begin
  if lowercase(Copy(input.ScriptPubKey, 0, 6)) = '76a914' then
    result := 0;
  if lowercase(Copy(input.ScriptPubKey, 0, 4)) = 'a914' then
    result := 1;
  if lowercase(Copy(input.ScriptPubKey, 0, 4)) = '0014' then
    result := 2;
  if lowercase(Copy(input.ScriptPubKey, 0, 4)) = '0020' then
    result := 3;
end;

function BCHCashAddrToLegacyAddr(address: AnsiString): AnsiString;
var
  bech: Bech32Data;
  intarr: TIntegerArray;
  hex, netbyte, r, s: AnsiString;
  tempInt: integer;
begin

  if leftstr(address, 12) <> 'bitcoincash:' then
  begin
    address := 'bitcoincash:' + address;
  end;

  bech := decodeBCH(address);
  if bech.hrp='FAIL' then
  raise Exception.Create('BECH FAILRE');
  intarr := Copy(bech.values, 1, length(bech.values) - 1);

  intarr := Change(bech.values, 5, 8);

  hex := '';
  for i := 0 to length(intarr) - 7 do
  begin
    tempInt := intarr[i];
    hex := hex + IntToHex(byte(tempInt));
  end;
  if Copy(hex, 0, 2) = '08' then
    netbyte := '05'
  else
    netbyte := '00';
{$IFDEF ANDROID}
  delete(hex, 0, 2);
{$ELSE}
  delete(hex, 1, 2);
{$ENDIF}
  s := netbyte + hex;
  r := GetSHA256FromHex(s);
  r := GetSHA256FromHex(r);
{$IFDEF ANDROID}
  s := s + Copy(r, 0, 8);
{$ELSE}
  s := s + Copy(r, 1, 8);
{$ENDIF}
  result := Encode58(s);

end;

function bitcoinCashAddressToCashAddress(address: AnsiString): AnsiString;
var
  intarr: TIntegerArray;
  checksum: TIntegerArray;
  temparr: TIntegerArray;
  payload: TCharArray;
  c: AnsiChar;
  i: integer;
  adrInfo: TAddressInfo;
  tempStr: AnsiString;
begin

  adrInfo := decodeAddressInfo(address, 3);
  case adrInfo.scriptType of
    0:
      tempStr := '00' + adrInfo.Hash;
    1:
      tempStr := '08' + adrInfo.Hash;
  end;

  SetLength(intarr, length(tempStr));
  i := 0;

  for c in tempStr do
  begin

    intarr[i] := strToInt('$' + c);
    inc(i);

  end;

  intarr := Change(intarr, 4, 5);
  checksum := CreateChecksum8('bitcoincash', intarr);

  temparr := concat(intarr, checksum);
  result := 'bitcoincash:' + bech32.rawencode(temparr);

end;

procedure synchronizeCurrencyValue();
var
  data: AnsiString;
  ts: TStringList;
  line: AnsiString;
  pair: TStringList;
  symbol: AnsiString;
begin
  data := getDataOverHTTP(HODLER_URL + 'fiat.php');

  ts := TStringList.Create();
  try
    ts.text := data;

    for line in ts do
    begin
      pair := SplitString(line);
      CurrencyConverter.updateCurrencyRatio(pair[1], strToFloat(pair[0]));
      pair.free;
    end;

  Except
    on E: Exception do
      showmessage('Currency converter Error');

  end;
  ts.free;

  frmHome.CurrencyBox.Items.Clear;
  for symbol in CurrencyConverter.availableCurrency.Keys do
  begin
    frmHome.CurrencyBox.Items.Add(symbol);
  end;
  frmHome.CurrencyBox.ItemIndex := frmHome.CurrencyBox.Items.IndexOf
    (CurrencyConverter.symbol);

  ts := TStringList.Create();

  for symbol in CurrencyConverter.availableCurrency.Keys do
  begin
    data := floattoStr(CurrencyConverter.availableCurrency[symbol]);
    data := data + ' ' + symbol;
    ts.Add(data);
  end;

  ts.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.fiat.dat'));

  ts.free;

end;

procedure LoadCurrencyFiatFromFile();
var
  pair, ts: TStringList;
  line: AnsiString;
begin
  ts := TStringList.Create();
  try

    ts.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.fiat.dat'));

    for line in ts do
    begin
      pair := SplitString(line);
      CurrencyConverter.updateCurrencyRatio(pair[1], strToFloat(pair[0]));
      pair.free;
    end;

  Except
    on E: Exception do
      showmessage('Currency converter Error');

  end;
  ts.free;
end;

function isP2PKH(netbyte: AnsiString; coinid: integer): Boolean;
begin
  result := availablecoin[coinid].p2pk = netbyte;

end;

function isSegwitAddress(address: AnsiString): Boolean;
begin
  result := ((AnsiLeftStr(address, 3) = 'bc1') or
    (AnsiLeftStr(address, 3) = 'ltc1')) and (length(address) > 39);
end;

function decodeAddressInfo(address: AnsiString; coinid: integer): TAddressInfo;
var
  addrHash: AnsiString;
  netbyte: AnsiString;
begin
  result.scriptType := -1;
  if coinid = 4 then
    exit; // Ethereum doesnt need this
  if isSegwitAddress(address) = false then
  begin
    addrHash := Copy(decode58(address), 0, 42);
    netbyte := Copy(addrHash, 0, 2);
    delete(addrHash, 1, 2);
    result.Hash := addrHash;
    if isP2PKH(netbyte, coinid) then
      result.scriptType := 0
    else
      result.scriptType := 1;
  end
  else
  begin
    result := segwit_addr_decode(address);
    if length(result.Hash) = 40 then
      result.scriptType := 2;
    if length(result.Hash) = 64 then
      result.scriptType := 3;

  end;

  case result.scriptType of
    0:
      result.outputScript := '76a914' + addrHash + '88ac';
    1:
      result.outputScript := 'a914' + addrHash + '87';
    2:
      result.outputScript := IntToHex(result.witver, 2) + '14' + result.Hash;
    3:
      result.outputScript := IntToHex(result.witver, 2) + '20' + result.Hash;
  end;
  result.scriptHash := reverseHexOrder(GetSHA256FromHex((result.outputScript)));
end;

procedure shareFile(path: AnsiString);
var
  i: integer;
{$IFDEF ANDROID}
  intent: JIntent;
  mimetypeStr: JString;
  fileUri: JParcelable;
  javafile: JFile;
{$ELSE}
  saveDialog: TSaveDialog;
{$ENDIF}
begin
{$IFDEF ANDROID}
  mimetypeStr := TJMimeTypeMap.JavaClass.getSingleton.getMimeTypeFromExtension
    (StringToJString(StringReplace(TPath.GetExtension(path), '.', '', [])));
  javafile := TJFile.JavaClass.init(StringToJString(path));
  intent := TJIntent.Create();

  intent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
  intent.SetAction(TJIntent.JavaClass.ACTION_SEND);
  intent.setType(mimetypeStr);
  fileUri := JParcelable(TJFileProvider.JavaClass.getUriForFile
    (TAndroidHelper.context, StringToJString('tech.hodler.core.fileProvider'),
    javafile));
  intent.putExtra(TJIntent.JavaClass.EXTRA_STREAM, fileUri);

  SharedActivity.startActivity(TJIntent.JavaClass.createChooser(intent,
    StrToJcharSequence('Share with')));
{$ELSE}
  saveDialog := TSaveDialog.Create(frmHome);
  saveDialog.Title := 'Save your text or word file';
  saveDialog.FileName := ExtractFileName(path);

  saveDialog.InitialDir := GetCurrentDir;

  saveDialog.Filter := 'Zip File|*.zip';

  saveDialog.DefaultExt := 'zip';

  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
  begin
    TFile.Copy(path, saveDialog.FileName);
    DeleteFile(path);

  end;
  saveDialog.free;

{$ENDIF}
end;

Function StrToQRBitmap(Str: AnsiString; pixelSize: integer = 6): TBitmap;
var
  Local_Row: integer;
  Local_Column: integer;
  vPixelB: integer;
  vPixelW: integer;
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmapData;
  Row: integer;
  bmp: FMX.Graphics.TBitmap;
  Column: integer;
  ms: TMemoryStream;
  bmp2: FMX.Graphics.TBitmap;
  DestW: int64;
  DestH: int64;
  pixW: int64;
  pixH: int64;
  j: integer;
  currentRow: int64;
  k: int64;
  currentCol: int64;
  x, y: integer;
  // rsrc, rDest: TRectF;
  s: AnsiString;

begin
  // result := TBitmap.Create();

  vPixelB := TAlphaColorRec.Black;
  // determine colour to use
  vPixelW := TAlphaColorRec.white;
  // determine colour to use
  QRCode := TDelphiZXingQRCode.Create();

  try

    QRCode.Encoding := TQRCodeEncoding(qrAuto);
    QRCode.QuietZone := 6;
    QRCode.data := {$IFDEF ANDROID}'  ' + {$ENDIF}Str;
    bmp := FMX.Graphics.TBitmap.Create();
    bmp.SetSize(QRCode.Rows, QRCode.Columns);

    if bmp.Map(TMapAccess.maReadWrite, QRCodeBitmap) then
    begin

      for y := 0 to QRCode.Rows - 1 do
      begin
        for x := 0 to QRCode.Columns - 1 do
        begin

          if (QRCode.IsBlack[y, x]) then
          begin
            QRCodeBitmap.SetPixel(y, x, vPixelB);
          end
          else
          begin
            QRCodeBitmap.SetPixel(y, x, vPixelW);
          end;

        end;
      end;

      bmp.free;
      bmp := BitmapDataToScaledBitmap(QRCodeBitmap, pixelSize);
      bmp.Unmap(QRCodeBitmap);
    end;
  finally
    QRCode.free;
  end;

  result := TBitmap.Create();
  result.Assign(bmp);

  try
    if bmp <> nil then
      bmp.free;
  except

  end;

end;

procedure refreshCurrencyValue();
var
  T: Token;
  w: TWalletInfo;
begin
  frmHome.lblReceiveRealCurrency.text := CurrencyConverter.symbol;
  frmHome.lblCoinFiat.text := CurrencyConverter.symbol;

  TLabel(frmHome.FindComponent('globalBalance')).text :=
    floatToStrF(CurrencyConverter.calculate(globalFiat), ffFixed, 9, 2);
  TLabel(frmHome.FindComponent('globalCurrency')).text := '         ' +
    CurrencyConverter.symbol;

  updateBalanceLabels();
end;

procedure refreshComponentText();
var
  it: System.Generics.Collections.TDictionary<AnsiString, WideString>.
    TPairEnumerator;
  component: TComponent;
begin

  try

    with frmHome do
    begin
      it := dictionary.GetEnumerator();
      While (it.MoveNext) do
      begin

        component := frmHome.FindComponent(it.Current.Key);
        if component <> nil then
        begin
          if component is TPresentedTextControl then
            TPresentedTextControl(component).text := it.Current.Value
          else if component is TTextControl then
            TTextControl(component).text := it.Current.Value
          else
            showmessage('Forgotten component ' + component.ToString);
        end;
      end;
    end;

  except
    on E: Exception do
    begin
      showmessage(E.ToString);
    end
  end;

end;

procedure loadDictionary(langData: WideString);
var
  data: AnsiString;
  StringReader: TStringReader;
  JSONTextReader: TJSONTextReader;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  it: TJSONIterator;
  ts: TStringList;

begin

  if frmHome.dictionary = nil then
    frmHome.dictionary := TObjectDictionary<AnsiString, WideString>.Create();

  StringReader := TStringReader.Create(langData);
  JSONTextReader := TJSONTextReader.Create(StringReader);

  it := TJSONIterator.Create(JSONTextReader);

  it.Recurse;
  while (it.Next()) do
  begin
    frmHome.dictionary.AddOrSetValue(it.Key, it.AsString);
  end;

end;

procedure Vibrate(ms: int64);
{$IFDEF ANDROID}
var

  Vibrator: JVibrator;
{$ENDIF}
begin
{$IFDEF ANDROID}
  Vibrator := TJvibrator.Wrap
    ((SharedActivityContext.getSystemService
    (TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID());
  Vibrator.Vibrate(200);
{$ENDIF}
end;

procedure RefreshGlobalFiat();
var
  ccrc: cryptoCurrency;
begin
  globalFiat := 0;
  for ccrc in CurrentAccount.myCoins do
  begin
    globalFiat := globalFiat + ccrc.confirmed.AsDouble * ccrc.rate /
      Math.Power(10, ccrc.decimals);
  end;

  for ccrc in CurrentAccount.myTokens do
  begin
    globalFiat := globalFiat + ccrc.confirmed.AsDouble * ccrc.rate /
      Math.Power(10, ccrc.decimals);
  end;

end;

procedure refreshOrderInDashBrd();
var
  fmxObj: TFmxObject;
begin;

  if frmHome.WalletList.Content.ChildrenCount = 0 then
    exit;

  for fmxObj in frmHome.WalletList.Content.Children do
  begin

    Tpanel(fmxObj).Position.y := cryptoCurrency(fmxObj.TagObject)
      .orderInWallet - 1;

  end;
  frmHome.WalletList.Repaint;

end;

procedure createHistoryList(wallet: cryptoCurrency);
var
  Panel: Tpanel;
  Image: TImage;
  lbl: TLabel;
  addrLbl: TLabel;
  datalbl: TLabel;
  fmxObj: TFmxObject;
  i: integer;
begin

  clearVertScrollBox(frmHome.txHistory);

  for i := length(wallet.history) - 1 downto 0 do
  begin

    Panel := Tpanel.Create(frmHome.txHistory);
    Panel.Align := TAlignLayout.Top;
    Panel.Height := 36;
    Panel.Visible := true;
    Panel.Tag := i;
    Panel.Parent := frmHome.txHistory;
    Panel.Position.y := -strToIntdef(wallet.history[i].data, 0);
{$IFDEF ANDROID}
    Panel.OnTap := frmHome.ShowHistoryDetails;
{$ELSE}
    Panel.OnClick := frmHome.ShowHistoryDetails;
{$ENDIF}
    // Panel.Tag:= wallet.history[i];

    addrLbl := TLabel.Create(Panel);
    addrLbl.Visible := true;
    addrLbl.Parent := Panel;
    addrLbl.Width := 400;
    addrLbl.Height := 18;
    addrLbl.Position.x := 36;
    addrLbl.Position.y := 0;
    addrLbl.text := wallet.history[i].addresses[0];
    addrLbl.TextSettings.HorzAlign := TTextAlign.Leading;

    datalbl := TLabel.Create(Panel);
    datalbl.Visible := true;
    datalbl.Parent := Panel;
    datalbl.Width := 400;
    datalbl.Height := 18;
    datalbl.Position.x := 36;

    datalbl.Position.y := 18;
    datalbl.text := FormatDateTime('dd mmm yyyy hh:mm',
      UnixToDateTime(strToIntdef(wallet.history[i].data, 0)));
    datalbl.TextSettings.HorzAlign := TTextAlign.Leading;

    Image := TImage.Create(Panel);
    Image.Width := 18;
    Image.Height := 18;
    Image.Position.x := 9;
    Image.Position.y := 9;
    Image.Visible := true;
    Image.Parent := Panel;
    if wallet.history[i].typ = 'OUT' then
      Image.Bitmap := frmHome.sendImage.Bitmap;
    if wallet.history[i].typ = 'IN' then
      Image.Bitmap := frmHome.receiveImage.Bitmap;

    lbl := TLabel.Create(Panel);
    lbl.Align := TAlignLayout.Bottom;
    lbl.Height := 18;
    lbl.TextSettings.HorzAlign := TTextAlign.taTrailing;
    lbl.Visible := true;
    lbl.Parent := Panel;
    lbl.text := BigIntegerBeautifulStr(wallet.history[i].CountValues,
      wallet.decimals);

  end;
  i := 0;
  if frmHome.txHistory.Content.ChildrenCount <> 0 then
    for fmxObj in frmHome.txHistory.Content.Children do
    begin
      Tpanel(fmxObj).Position.y := -strToIntdef(wallet.history[i].data, 0);
      inc(i);
    end;

end;

function isBech32Address(Str: AnsiString): Boolean;
var
  prefix: AnsiString;
  i: integer;
begin
  prefix := 'bc1';
  result := true;

  for i := Low(prefix) to High(prefix) do
  begin
    if prefix[i] <> Str[i] then
      result := false;
  end;

end;

function parseQRCode(Str: AnsiString): TStringList;
begin

  Str := StringReplace(Str, '?', #13#10, [rfReplaceAll]);
  Str := StringReplace(Str, ':', #13#10, []);
  Str := StringReplace(Str, '&', #13#10, [rfReplaceAll]);
  Str := StringReplace(Str, '=', #13#10, [rfReplaceAll]);
  result := TStringList.Create;
  result.text := Str;

end;

function BitmapDataToScaledBitmap(data: TBitmapData; scale: integer): TBitmap;
var
  x, y, i, j: integer;
  temp: TBitmapData;

begin
  result := TBitmap.Create(data.Width * scale, data.Height * scale);

  if result.Map(TMapAccess.maReadWrite, temp) then
  begin
    for y := 0 to data.Height - 1 do
    begin
      for x := 0 to data.Width - 1 do
      begin

        for i := 0 to scale - 1 do
        begin
          for j := 0 to scale - 1 do
          begin
            temp.SetPixel(y * scale + i, x * scale + j, data.GetPixel(y, x));
          end;
        end;

      end;
    end;

    result.Unmap(temp);
  end;

end;

constructor popupWindowYesNo.Create(Yes: TProc; No: TProc; mess: AnsiString;
YesText: AnsiString = 'Yes'; NoText: AnsiString = 'No'; icon: integer = 2);
var
  Panel, Panel2: Tpanel;
  i: integer;
begin
  inherited Create(frmHome.PageControl);

  _onYesPress := Yes;
  _onNoPress := No;

  Parent := frmHome.PageControl;
  Height := 300;
  Width := 350;
  Placement := TPlacement.Center;

  Visible := true;
  PlacementRectangle := TBounds.Create(RectF(0, 0, 0, 0));

  Panel := Tpanel.Create(self);
  Panel.Align := TAlignLayout.Client;
  Panel.Height := 48;
  Panel.Visible := true;
  Panel.Tag := i;
  Panel.Parent := self;

  Panel2 := Panel; // tak wiem     to glupie
  for i := 0 to 5 do
  begin
    Panel := Tpanel.Create(Panel);
    Panel.Align := TAlignLayout.Client;
    Panel.Visible := true;
    Panel.Tag := i;
    Panel.Parent := Panel2;
    Panel2 := Panel;
  end;

  _ImageLayout := TLayout.Create(Panel);
  _ImageLayout.Visible := true;
  _ImageLayout.Align := TAlignLayout.MostTop;
  _ImageLayout.Parent := Panel;
  _ImageLayout.Height := 96;

  _Image := TImage.Create(_ImageLayout);
  _Image.Align := TAlignLayout.Center;
  _Image.Width := 64;
  _Image.Height := 64;
  _Image.Visible := true;
  _Image.Parent := _ImageLayout;
  case icon of
    0:
      _Image.Bitmap := frmHome.OKImage.Bitmap;
    1:
      _Image.Bitmap := frmHome.InfoImage.Bitmap;
    2:
      _Image.Bitmap := frmHome.warningImage.Bitmap;
    3:
      _Image.Bitmap := frmHome.ErrorImage.Bitmap;
  end;

  _lblMessage := TLabel.Create(Panel);
  _lblMessage.Align := TAlignLayout.Client;
  _lblMessage.Visible := true;
  _lblMessage.Parent := Panel;
  _lblMessage.text := mess;
  _lblMessage.TextSettings.HorzAlign := TTextAlign.Center;

  _ButtonLayout := TLayout.Create(Panel);
  _ButtonLayout.Visible := true;
  _ButtonLayout.Align := TAlignLayout.MostBottom;
  _ButtonLayout.Parent := Panel;
  _ButtonLayout.Height := 48;

  _YesButton := TButton.Create(_ButtonLayout);
  _YesButton.Align := TAlignLayout.Right;
  _YesButton.Width := _ButtonLayout.Width / 2;
  _YesButton.Visible := true;
  _YesButton.Parent := _ButtonLayout;
  _YesButton.text := YesText;
  _YesButton.OnClick := _onYesClick;

  _NoButton := TButton.Create(_ButtonLayout);
  _NoButton.Align := TAlignLayout.Left;
  _NoButton.Width := _ButtonLayout.Width / 2;
  _NoButton.Visible := true;
  _NoButton.Parent := _ButtonLayout;
  _NoButton.text := NoText;
  _NoButton.OnClick := _onNoClick;

  Popup();

  OnClosePopup := _OnExit;

end;

procedure popupWindowYesNo._OnExit(sender: TObject);
begin

  Parent := nil;
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          disposeOf();
        end);
    end).Start;

end;

procedure popupWindowYesNo._onYesClick;
begin
  IsOpen := false;
  _onYesPress();

  ClosePopup();
  // Release;

end;

procedure popupWindowYesNo._onNoClick;
begin
  IsOpen := false;

  _onNoPress();

  ClosePopup();
  // Release;

end;

constructor popupWindowOK.Create(OK: TProc; mess: AnsiString;
ButtonText: AnsiString = 'OK'; icon: integer = 1);
var
  Panel, Panel2: Tpanel;
  i: integer;
begin
  inherited Create(frmHome.PageControl);
  Parent := frmHome.PageControl;
  Height := 200;
  Width := 300;
  Placement := TPlacement.Center;

  Visible := true;
  PlacementRectangle := TBounds.Create(RectF(0, 0, 0, 0));

  Panel := Tpanel.Create(self);
  Panel.Align := TAlignLayout.Client;
  Panel.Height := 48;
  Panel.Visible := true;
  Panel.Tag := i;
  Panel.Parent := self;

  Panel2 := Panel;
  for i := 0 to 5 do
  begin
    Panel := Tpanel.Create(Panel);
    Panel.Align := TAlignLayout.Client;
    Panel.Visible := true;
    Panel.Tag := i;
    Panel.Parent := Panel2;
    Panel2 := Panel;
  end;

  _ImageLayout := TLayout.Create(Panel);
  _ImageLayout.Visible := true;
  _ImageLayout.Align := TAlignLayout.MostTop;
  _ImageLayout.Parent := Panel;
  _ImageLayout.Height := 96;

  _Image := TImage.Create(_ImageLayout);
  _Image.Align := TAlignLayout.Center;
  _Image.Width := 64;
  _Image.Height := 64;
  _Image.Visible := true;
  _Image.Parent := _ImageLayout;
  case icon of
    0:
      _Image.Bitmap := frmHome.OKImage.Bitmap;
    1:
      _Image.Bitmap := frmHome.InfoImage.Bitmap;
    2:
      _Image.Bitmap := frmHome.warningImage.Bitmap;
    3:
      _Image.Bitmap := frmHome.ErrorImage.Bitmap;
  end;

  _lblMessage := TLabel.Create(Panel);
  _lblMessage.Align := TAlignLayout.Client;
  _lblMessage.Visible := true;
  _lblMessage.Parent := Panel;
  _lblMessage.text := mess;
  _lblMessage.TextSettings.HorzAlign := TTextAlign.Center;

  _OKbutton := TButton.Create(Panel);
  _OKbutton.Align := TAlignLayout.Bottom;
  _OKbutton.Height := 48;
  _OKbutton.Visible := true;
  _OKbutton.Parent := Panel;
  _OKbutton.OnClick := _OKButtonpress;
  _OKbutton.text := ButtonText;

  _onOKButtonPress := OK;

  self.OnClosePopup := _onEnd;

  Popup();
end;

procedure popupWindowOK._OKButtonpress(sender: TObject);
begin
  IsOpen := false;
  _onOKButtonPress();

  ClosePopup();

end;

procedure popupWindowOK._onEnd(sender: TObject);
begin

  Parent := nil;
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          disposeOf();
        end);
    end).Start;
end;

constructor popupWindow.Create(mess: AnsiString);
var
  Panel, Panel2: Tpanel;
  i: integer;
begin
  inherited Create(frmHome.PageControl);

  Parent := frmHome.PageControl;
  Height := 100;
  Width := 300;
  Placement := TPlacement.Center;

  Visible := true;
  PlacementRectangle := TBounds.Create(RectF(0, 0, 0, 0));

  Panel := Tpanel.Create(self);
  Panel.Align := TAlignLayout.Client;
  Panel.Visible := true;
  Panel.Tag := i;
  Panel.Parent := self;

  Panel2 := Panel; // tak wiem     to glupie
  for i := 0 to 5 do
  begin
    Panel := Tpanel.Create(Panel);
    Panel.Align := TAlignLayout.Client;
    Panel.Visible := true;
    Panel.Tag := i;
    Panel.Parent := Panel2;
    Panel2 := Panel;
  end;

  messageLabel := TLabel.Create(Panel);
  messageLabel.Align := TAlignLayout.Client;
  messageLabel.Visible := true;
  messageLabel.Parent := Panel;
  messageLabel.text := mess;
  messageLabel.TextSettings.HorzAlign := TTextAlign.Center;

  self.OnClosePopup := _onEnd;

  Popup();
end;

procedure popupWindow._onEnd(sender: TObject);
begin

  IsOpen := false;

  Parent := nil;
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          disposeOf();
        end);
    end).Start;

end;

function fromMnemonic(input: AnsiString): integer;
var
  i: integer;
  temp: AnsiString;
begin
  result := -1;
  for i := 0 to frmHome.wordList.Lines.Count - 1 do
  begin
    if input = frmHome.wordList.Lines.Strings[i] then
    begin
      result := i;
      exit;
    end;
  end;
end;

function fromMnemonic(input: TStringList): AnsiString;
var
  i: integer;
  bi: BigInteger;
  temp: integer;
begin
  bi := BigInteger.Zero;

  for i := input.Count - 1 downto 0 do
  begin
    bi := bi * 2048;
    temp := fromMnemonic(input[i]);
    if (temp < 0) or (temp > 2047) then
    begin
      result := '';
      popupWindow.Create(input[i] + ' ' + frmHome.dictionary
        ['NotExistInWorldlist']);
      exit;
    end;
    bi := bi + fromMnemonic(input[i]);
  end;

  result := bi.tohexString();

  result := bi.tohexString();
  while length(result) < 64 do
    result := '0' + result;

end;

function toMnemonic(hex: AnsiString): AnsiString;
var
  tmp: AnsiString;
  part: integer;
  IntSeed: BigInteger;
begin
  part := 0;
  if (not IsHex(hex)) then
    result := ''
  else
  begin

    BigInteger.TryParse(hex, 16, IntSeed);

    while IntSeed > 0 do
    begin
      result := result + (frmHome.wordList.Lines.Strings[(IntSeed mod 2048)
        .asInteger]) + ' ';
      IntSeed := IntSeed div 2048;
    end;

  end;

end;

function getConfirmedAsString(wi: TWalletInfo): AnsiString;
begin
  result := BigIntegerToFloatStr(wi.confirmed, availablecoin[wi.coin].decimals);
end;

function isEthereum: Boolean;
begin

  result := CurrentCoin.coin = 4;

end;

function BigIntegerBeautifulStr(num: BigInteger; decimals: integer): AnsiString;
var
  c: array [-4 .. 5] of Char;
  Str: AnsiString;
  temp, i: integer;
  zeroCounter: integer;
begin

  if num < 0 then
  begin
    result := '0.00';
    exit;
  end;

  zeroCounter := 0;

  Str := num.ToDecimalString;
  temp := (length(Str) - decimals);
  if temp > 8 then
  begin
    SetLength(Str, length(Str) - decimals);
    result := Str;
  end
  else
  begin

    Str := BigIntegerToFloatStr(num, decimals);
    SetLength(Str, min(9, decimals));

    for i := high(Str) downto Low(Str) do
    begin
      if Str[i] = '0' then
      begin
        zeroCounter := zeroCounter + 1;
      end
      else
        break;
    end;
    SetLength(Str, length(Str) - max(0, zeroCounter - 2));
    result := Str;
  end;

end;

function StrFloatToBigInteger(Str: AnsiString; decimals: integer): BigInteger;
var
  // temp : AnsiString;
  i: integer;
  separator: Char;
  flag: Boolean;
  counter: integer;
begin
  flag := false;
  counter := 0;

  separator := FormatSettings.DecimalSeparator;
  result := BigInteger.Create(0);
  for i := Low(Str) to High(Str) do
  begin

    if flag then
      inc(counter);

    if Char(Str[i]) <> separator then
    begin

      result := result * 10;
      result := result + integer(Str[i]) - integer('0');

    end
    else
    begin
      flag := true;
    end;

  end;

  while (counter < decimals) do
  begin
    result := result * 10;
    inc(counter);
  end;

end;

function BigIntegerToFloatStr(const num: BigInteger; decimals: integer;
precision: integer = -1): AnsiString;
var
  i: integer;
  // len : integer;
  temp: BigInteger;
  Str: AnsiString;
  minus: Boolean;
begin
  if precision = -1 then
    precision := decimals;

  // temp := BigInteger.Create(num);
  Str := num.ToDecimalString;

  result := '';

  for i := 0 to decimals do
  begin
    result := result + '0';
  end;

  if length(Str) >= length(result) then
  begin
    result := Str;
  end
  else
  begin
    for i := High(Str) downto Low(Str) do
    begin
      result[High(result) - (high(Str) - i)] := Str[i];
    end;

  end;

  insert(FormatSettings.DecimalSeparator, result, High(result) - decimals +
    1{$IFDEF ANDROID} + 1{$ENDIF});

  SetLength(result, length(result) - (decimals - precision));
  minus := Pos('-', result) > 1;
  if minus then
  begin
    result := StringReplace(result, '-', '0', [rfReplaceAll]);
    result := '-' + result;

  end;
  if AnsiContainsText(result, '-.') then
    result := StringReplace(result, '-.', '-0.', [rfReplaceAll]);
end;

// return index of array where  is wallet with given address

// show message window
procedure showMsg(backView: TTabItem; message: AnsiString;
warningImage: TBitmap = nil);
begin

  frmHome.btnSMVNo.Visible := true;
  frmHome.btnSMVYes.Visible := true;
  frmHome.btnSMVYes.text := 'Yes';
  frmHome.btnSMVNo.text := 'No';
  frmHome.btnSMVYes.Align := frmHome.btnSMVYes.Align.alRight;
  frmHome.btnSMVNo.Align := frmHome.btnSMVNo.Align.alLeft;
  if not(warningImage = nil) then
  begin
    frmHome.imageSMV.Bitmap := warningImage;
  end;
  lastView := backView;
  frmHome.lblmessageText.text := message;
  switchTab(frmHome.PageControl, frmHome.showMsgView);

end;

// delete all panels from given TVertScrollBox
procedure clearVertScrollBox(VSB: TVertScrollBox);
var
  i: integer;
begin
  i := VSB.ComponentCount - 1;
  while i >= 0 do
  begin
    if VSB.Components[i].ClassType = Tpanel then
    begin
      VSB.Components[i].disposeOf;
      i := VSB.ComponentCount - 1
    end
    else
      dec(i);
  end;

  i := VSB.ComponentCount - 1;
  while i >= 0 do
  begin
    if VSB.Components[i].ClassType = TButton then
    begin
      VSB.Components[i].disposeOf;
      i := VSB.ComponentCount - 1
    end
    else
      dec(i);
  end;

end;

procedure wipeTokenDat();
begin
  DeleteFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.erc20.dat'));
end;

// generate icon based on hex
function generateIcon(hex: AnsiString): TBitmap;
var
  bitmapData: TBitmapData;
  y: integer;
  x: integer;
  color: TAlphaColor;
  i: integer;
  i_max: integer;
  bb: Tbytes;
  colors: array [0 .. 5] of TAlphaColor;
  j: integer;
begin

  if not IsHex(hex) then
  begin

    if (hex[Low(hex)] = '0') and ((hex[Low(hex) + 1] = 'x')) then
    begin
      hex := StringReplace(hex, '0x', '', [rfReplaceAll]);
    end
    else
      hex := '0123456789ABCDEF0123456789ABCDEF012345FF';
  end;

  // convert str to array of colors
  bb := hexatotbytes(hex);
  for i := 1 to 5 do
  begin

    colors[i] := TAlphaColorF.Create(bb[3 * i], bb[3 * i + 1], bb[3 * i + 2])
      .ToAlphaColor;

  end;

  result := TBitmap.Create();
  result.SetSize(32, 32);

  if result.Map(TMapAccess.maReadWrite, bitmapData) then
  begin
    // bitmap "8x8" coloring
    for y := 0 to 7 do
    begin
      for x := 0 to 7 do
      begin

        // fill small square
        for i := 0 to 3 do
          for j := 0 to 3 do
          begin
            bitmapData.SetPixel(4 * y + i, 4 * x + j,
              TAlphaColor(colors[(x + 8 * y) mod 6]));
          end;

      end;
    end;
  end;

  if bb[18] > $7F then // symmertic Y axis
  begin
    for x := 0 to 15 do
    begin
      for y := 0 to 31 do
      begin
        color := bitmapData.GetPixel(x, y);
        bitmapData.SetPixel(31 - x, y, color);
      end;
    end;
  end;

  if bb[19] > $7F then // symmetric X axis
  begin
    for x := 0 to 31 do
    begin
      for y := 0 to 15 do
      begin
        color := bitmapData.GetPixel(x, y);
        bitmapData.SetPixel(x, 31 - y, color);
      end;
    end;
  end;

  // rounding icon
  for i := 0 to 31 do
    for j := 0 to 31 do
    begin
      // if pixel is outside circle set as alpha
      if (((i) - 15.5) * ((i) - 15.5) + ((j) - 15.5) * ((j) - 15.5)) > 16 * 16
      then
      begin
        bitmapData.SetPixel(i, j, TAlphaColor(0));
      end;

    end;

  result.Unmap(bitmapData);

end;

// add SEP every N char in STR
function cutEveryNChar(n: integer; Str: AnsiString; sep: AnsiChar = ' ')
  : AnsiString;
var
  i, j: integer;
begin
  inc(n);
  result := Str;

  for i := n to length(Str) + (length(Str) - 1) div (n - 1) do

  begin
    if i mod n = 0 then

      insert(sep, result, i);

  end;

end;

function removeSpace(Str: AnsiString): AnsiString;
begin
  result := Str;
  result := StringReplace(result, ' ', '', [rfReplaceAll]);
end;

// return number of wallets of chosen coin     for example countWalletBy(0) return number of out BTC wallet

// create view with all supported coins
procedure createAddWalletView();
var
  Panel: Tpanel;
  coinName: TLabel;
  balLabel: TLabel;
  coinIMG: TImage;
begin
  // if already generated then exit
  if frmHome.SelectNewCoinBox.ComponentCount > 1 then
    exit;

  for i := 0 to length(coinData.availablecoin) - 1 do
  begin

    with frmHome.SelectNewCoinBox do
    begin
      Panel := Tpanel.Create(frmHome.SelectNewCoinBox);
      Panel.Align := Panel.Align.alTop;
      Panel.Height := 48;
      Panel.Visible := true;
      Panel.Tag := i;
      Panel.Parent := frmHome.SelectNewCoinBox;
      Panel.OnClick := frmHome.addNewWalletPanelClick;

      coinName := TLabel.Create(frmHome.SelectNewCoinBox);
      coinName.Parent := Panel;
      coinName.text := availablecoin[i].name;
      coinName.Visible := true;
      coinName.Width := 500;
      coinName.Position.x := 52;
      coinName.Position.y := 16;
      coinName.Tag := i;
      coinName.OnClick := frmHome.addNewWalletPanelClick;

      coinIMG := TImage.Create(frmHome.SelectNewCoinBox);
      coinIMG.Parent := Panel;
      coinIMG.Bitmap := frmHome.ImageList1.Source[i].MultiResBitmap[0].Bitmap;
      coinIMG.Height := 32.0;
      coinIMG.Width := 50;
      coinIMG.Position.x := 4;
      coinIMG.Position.y := 8;
      coinIMG.OnClick := frmHome.addNewWalletPanelClick;
      coinIMG.Tag := i;

    end;
  end;
end;

procedure creatImportPrivKeyCoinList();
var
  Panel: Tpanel;
  coinName: TLabel;
  balLabel: TLabel;
  coinIMG: TImage;
begin
  // if already generated then exit
  if frmHome.ImportprivKeyCoinListVertScrollBox.ComponentCount > 1 then
    exit;

  for i := 0 to length(coinData.availablecoin) - 1 do
  begin

    with frmHome.ImportprivKeyCoinListVertScrollBox do
    begin
      Panel := Tpanel.Create(frmHome.ImportprivKeyCoinListVertScrollBox);
      Panel.Align := Panel.Align.alTop;
      Panel.Height := 48;
      Panel.Visible := true;
      Panel.Tag := i;
      Panel.Parent := frmHome.ImportprivKeyCoinListVertScrollBox;
      Panel.OnClick := frmHome.importPrivCoinListPanelClick;

      coinName := TLabel.Create(Panel);
      coinName.Parent := Panel;
      coinName.text := availablecoin[i].displayName;
      coinName.Visible := true;
      coinName.Width := 500;
      coinName.Position.x := 52;
      coinName.Position.y := 16;
      coinName.Tag := i;
      coinName.OnClick := frmHome.addNewWalletPanelClick;

      coinIMG := TImage.Create(Panel);
      coinIMG.Parent := Panel;
      coinIMG.Bitmap := frmHome.ImageList1.Source[i].MultiResBitmap[0].Bitmap;
      coinIMG.Height := 32.0;
      coinIMG.Width := 50;
      coinIMG.Position.x := 4;
      coinIMG.Position.y := 8;
      coinIMG.OnClick := frmHome.addNewWalletPanelClick;
      coinIMG.Tag := i;

    end;
  end;
end;

function TStateToHEX(bb: TKeccakMaxDigest): AnsiString;
var
  i: integer;
begin
  result := '';
  for i := 0 to 31 do // keccack-256 digest
    result := result + IntToHex(bb[i], 2);
end;

function IsHex(s: string): Boolean;
var
  i: integer;
begin
  s := UpperCase(s);
  result := true;
  for i := StrStartIteration to length(s){$IFDEF ANDROID} - 1{$ENDIF} do
    if not(Char(s[i]) in ['0' .. '9']) and not(Char(s[i]) in ['A' .. 'F']) then
    begin
      result := false;
      exit;
    end;
end;

function keccak256String(s: AnsiString): AnsiString;
var
  buf: array of System.UInt8;

var
  K224State: THashState;
  K256State: THashState;
  K384State: THashState;
  K512State: THashState;
  K224Dig: TKeccakMaxDigest;
  K256Dig: TKeccakMaxDigest;
  K384Dig: TKeccakMaxDigest;
  K512Dig: TKeccakMaxDigest;
  i: integer;

begin

  SetLength(buf, length(s));
  for i := 0 to length(s) - 1 do
    buf[i] := System.UInt8(ord(s[i{$IFNDEF ANDROID} + 1{$ENDIF}]));

  init(K256State, 256);

  update(K256State, buf, (length(s)) * 8);
  Final(K256State, @K256Dig);
  result := TStateToHEX(K256Dig);

end;

function keccak256Hex(s: AnsiString): AnsiString;
var
  buf: array of System.UInt8;

var
  K224State: THashState;
  K256State: THashState;
  K384State: THashState;
  K512State: THashState;
  K224Dig: TKeccakMaxDigest;
  K256Dig: TKeccakMaxDigest;
  K384Dig: TKeccakMaxDigest;
  K512Dig: TKeccakMaxDigest;
  i: integer;
  bb: Tbytes;
begin
  bb := hexatotbytes(s);
  SetLength(buf, length(bb));
  for i := 0 to length(bb) - 1 do
    buf[i] := bb[i];

  init(K256State, 256);

  update(K256State, buf, (length(bb)) * 8);
  Final(K256State, @K256Dig);
  result := TStateToHEX(K256Dig);

end;

function SplitString(Str: AnsiString; separator: AnsiChar = ' '): TStringList;
var
  ts: TStringList;
  i: integer;
begin
  Str := StringReplace(Str, separator, #13#10, [rfReplaceAll]);
  ts := TStringList.Create;
  ts.text := Str;
  result := ts;

end;

function getStringFromImage(img: TBitmap): AnsiString;
begin

end;

function OCRFix(Str: AnsiString): AnsiString;
begin
  result := Str;
  result := StringReplace(result, 'O', 'o', [rfReplaceAll]);
  result := StringReplace(result, '0', 'o', [rfReplaceAll]);
  result := StringReplace(result, 'I', 'J', [rfReplaceAll]);
  result := StringReplace(result, 'l', 'J', [rfReplaceAll]);
end;

// try find wallet address in text and return it
function findAddress(Str: AnsiString): AnsiString;
var
  strArray: TStringList;
begin
  strArray := SplitString(Str);
  result := 'Not found';
  for i := 0 to strArray.Count - 1 do
  begin

    if base58.ValidateBitcoinAddress(Trim(OCRFix(strArray[i]))) = true then
    begin
      result := strArray[i];
      strArray.free;
      exit;
    end;

  end;

  for i := 0 to strArray.Count - 1 do
  begin

    if ((length(strArray[i]) >= 25) and (length(strArray[i]) <= 43)) then
    begin
      result := strArray[i];
      strArray.free;
      exit;
    end;

  end;

  strArray.free;
end;

function satToBtc(sat: AnsiString; decimals: integer): AnsiString;
begin
  result := floatToStrF((strToIntdef(sat, 0) / Power(10, decimals)), ffFixed,
    15, decimals);
end;

function satToBtc(num: BigInteger; decimals: integer): AnsiString;
begin
  result := BigIntegerToFloatStr(num, decimals);

end;

function inttoeth(data: System.uint64): AnsiString;
var
  ll: integer;
begin
  ll := ceil(length(IntToHex(data, 0)) / 2);
  result := IntToHex(data, ll * 2);
end;

function inttoeth(data: BigInteger): AnsiString;
var
  ll: integer;
begin
  result := data.tohexString;
  if length(result) mod 2 = 1 then
    result := '0' + result;

end;

function IntToTX(data: System.uint64; Padding: integer): AnsiString;
Begin
  // Keep padding!
  result := Copy(reverseHexOrder(IntToHex(data, Padding)), 0, Padding);
End;

function BIntTo256Hex(data: BigInteger; Padding: integer): AnsiString;
Begin
  result := data.tohexString;
  while length(result) < Padding do
  begin
    result := '0' + result;
  end;
  // Keep padding!
  result := Copy((result), 0, Padding);
End;

function IntToTX(data: BigInteger; Padding: integer): AnsiString;
Begin
  result := data.tohexString;
  while length(result) < Padding do
  begin
    result := '0' + result;
  end;
  // Keep padding!
  result := Copy(reverseHexOrder(result), 0, Padding);
End;

function buildAuth(aURL: String): AnsiString;
var
  nonce: string;
  Hash: string;
begin
  if ((Pos(HODLER_URL, aURL) > 0) or (Pos(HODLER_ETH, aURL) > 0)) then
  begin
    randomize;
    nonce := IntToStr(10000000 + random(900000000)); // Get some random number
    Hash := lowercase(GetStrHashSHA256(API_PRIV));
    Hash := GetStrHashSHA256(nonce + Hash);
    result := lowercase('&pub=' + API_PUB + '&nonce=' + nonce +
      '&hash=' + Hash);
    if Pos('?', aURL) = 0 then
      result := '?' + result;
  end
  else
    result := '';
end;

function getDataOverHTTP(aURL: String): AnsiString;
var
  req: THTTPClient;
  LResponse: IHTTPResponse;
begin

  try
    req := THTTPClient.Create();
    aURL := aURL + buildAuth(aURL);
    LResponse := req.get(aURL);
    result := LResponse.ContentAsString();
  except
    on E: Exception do
      result := '';
  end;

  // showmessage(result);
  req.free;
end;

function hash160FromHex(H: AnsiString): AnsiString;
var
  ripemd160: TRIPEMD160Hash;
  i: integer;
  b: byte;
  memstr: TMemoryStream;
begin
  memstr := TMemoryStream.Create;
  memstr.SetSize((length(H) div 2));
  memstr.Seek(0, soFromBeginning);
{$IFDEF ANDROID}
  for i := 0 to (length(H) div 2) - 1 do
  begin
    b := byte(strToInt('$' + Copy(H, ((i) * 2) + 1, 2)));
    memstr.Write(b, 1);
  end;
{$ELSE}
  for i := 1 to (length(H) div 2) do
  begin
    b := byte(strToInt('$' + Copy(H, ((i - 1) * 2) + 1, 2)));
    memstr.Write(b, 1);
  end;

{$ENDIF}
  ripemd160 := TRIPEMD160Hash.Create;
  try
    ripemd160.OutputFormat := hexa;
    ripemd160.Unicode := noUni;
    result := ripemd160.HashStream(memstr);
  finally
    ripemd160.free;
    memstr.free;
  end;
end;

function isWalletDatExists: Boolean;
var
  WDPath: AnsiString;
begin
  WDPath := TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat');
  result := FileExists(WDPath);
end;
{$IFDEF ANDROID}

function HexToStream(H: AnsiString): TStream;
var
  i: integer;
  b: System.UInt8;
  memstr: TMemoryStream;
begin
  memstr := TMemoryStream.Create;
  memstr.SetSize((length(H) div 2) - 1);
  memstr.Seek(0, soFromBeginning);

  for i := 0 to (length(H) div 2) - 1 do
  begin
    b := System.UInt8(strToInt('$' + Copy(H, (i) * 2, 2)));
    memstr.Write(b, 1);
  end;
end;
{$ELSE}

function HexToStream(H: AnsiString): TStream;
var
  i: integer;
  b: byte;
  memstr: TMemoryStream;
begin
  memstr := TMemoryStream.Create;
  memstr.SetSize((length(H) div 2));
  memstr.Seek(0, soFromBeginning);
  for i := 1 to (length(H) div 2) do
  begin
    b := byte(strToInt('$' + Copy(H, (i - 1) * 2 + 1, 2)));
    memstr.Write(b, 1);
  end;
end;
{$ENDIF}

// convert hex string to array of 8-bit number
function hexatotbytes(H: AnsiString): Tbytes;
var
  i: integer;
  b: System.UInt8;
  bb: Tbytes;
begin
  SetLength(bb, (length(H) div 2));
{$IFDEF ANDROID}
  for i := 0 to (length(H) div 2) - 1 do
  begin
    b := System.UInt8(strToInt('$' + Copy(H, ((i) * 2) + 1, 2)));
    bb[i] := b;
  end;
{$ELSE}
  for i := 1 to (length(H) div 2) do
  begin
    b := System.UInt8(strToInt('$' + Copy(H, ((i - 1) * 2) + 1, 2)));
    bb[i - 1] := b;
  end;

{$ENDIF}
  result := bb;
end;

function GetSHA256FromHex(H: AnsiString): AnsiString;
var
  HashSHA: THashSHA2;
  sha2: TSHA2Hash;
  i: integer;
  b: System.UInt8;
  bb: Tbytes;
begin
  bb := hexatotbytes(H);
  HashSHA := THashSHA2.Create;
  HashSHA.Reset;
  HashSHA.update(bb, (length(H) div 2));
  result := HashSHA.HashAsString;

end;

function GetStrHashSHA256(Str: AnsiString): AnsiString;
var
  sha2: TSHA2Hash;

begin
  sha2 := TSHA2Hash.Create;
  sha2.HashSizeBits := 256;
  sha2.OutputFormat := hexa;
  sha2.Unicode := noUni;
  result := sha2.Hash(Str);
  sha2.free;

end;

function GetStrHashSHA512(Str: AnsiString): AnsiString;
var
  HashSHA: THashSHA2;
begin
  HashSHA := THashSHA2.Create;
  HashSHA.GetHashString(Str);
  result := HashSHA.GetHashString(Str, SHA512);
end;

function GetStrHashBobJenkins(Str: AnsiString): AnsiString;
var
  Hash: THashBobJenkins;
begin
  Hash := THashBobJenkins.Create;
  Hash.GetHashString(Str);
  result := Hash.GetHashString(Str);
end;

function GetStrHashSHA512_256(Str: AnsiString): AnsiString;
var
  HashSHA: THashSHA2;
begin
  HashSHA := THashSHA2.Create;
  HashSHA.GetHashString(Str);
  result := HashSHA.GetHashString(Str, SHA512_256);
end;

function GetStrHashSHA512_224(Str: AnsiString): AnsiString;
var
  HashSHA: THashSHA2;
begin
  HashSHA := THashSHA2.Create;
  HashSHA.GetHashString(Str);
  result := HashSHA.GetHashString(Str, SHA512_224);
end;

function TCA(dane: AnsiString): AnsiString;
var
  i: integer;
  s: AnsiString;

begin
  s := dane;

  for i := 0 to TCAIterations do
    s := GetStrHashSHA256
      (GetStrHashSHA256(GetStrHashSHA256(GetStrHashBobJenkins(s))));
  result := s;
end;

function TBytesToString(bb: Tbytes): AnsiString;
var
  conv: TConvert;
begin
  conv := TConvert.Create(raw);
  result := conv.TBytesToString(bb);
  conv.free;

end;

function speckEncrypt(tcaKey, data: AnsiString): AnsiString;
var
  speck: TSPECKEncryption;
  cipher: string;
begin
  speck := TSPECKEncryption.Create;
  speck.AType := stOFB;
  speck.WordSizeBits := TSPECKWordSizeBits.wsb64;
  speck.KeySizeWords := TSPECKKeySizeWords.ksw4;
  speck.Key := TBytesToString(hexatotbytes(tcaKey));
  speck.OutputFormat := hexa;
  speck.Unicode := noUni;
  speck.PaddingMode := TSPECKPaddingMode.nopadding;
  speck.IVMode := TSPECKIVMode.userdefined;
  speck.IV := '0123456789abcdef';
  cipher := speck.Encrypt(data);
  speck.free;
  result := cipher;
end;

function speckDecrypt(tcaKey, data: AnsiString): AnsiString;
var
  speck: TSPECKEncryption;
  cipher: string;
begin
  speck := TSPECKEncryption.Create;
  speck.AType := stOFB;
  speck.WordSizeBits := TSPECKWordSizeBits.wsb64;
  speck.KeySizeWords := TSPECKKeySizeWords.ksw4;
  speck.Key := TBytesToString(hexatotbytes(tcaKey));;
  speck.OutputFormat := hexa;
  speck.Unicode := noUni;
  speck.PaddingMode := TSPECKPaddingMode.nopadding;
  speck.IVMode := TSPECKIVMode.userdefined;
  speck.IV := '0123456789abcdef';
  cipher := Trim(speck.Decrypt(data));
  speck.free;
  result := cipher;
end;

function AES256CBCEncrypt(tcaKey, data: AnsiString): AnsiString;
var
  aes: TAESEncryption;
  cipher: string;
  i: integer;
  b: System.UInt8;
  bb: Tbytes;
begin
  bb := hexatotbytes(tcaKey);
  aes := TAESEncryption.Create;
  aes.AType := atCBC;
  aes.KeyLength := kl256;
  aes.Unicode := noUni;
  aes.Key := String(bb);
  aes.OutputFormat := hexa;
  aes.PaddingMode := TpaddingMode.PKCS7;
  aes.IVMode := TIVMode.rand;
  cipher := aes.Encrypt(data);
  aes.free;
  result := cipher;
end;

function randomHexStream(size: integer): AnsiString;
var
  i: integer;
begin

  for i := 0 to size - 1 do
    result := result + IntToHex(random($FF), 2);

end;

function AES256CBCDecrypt(tcaKey, data: AnsiString): AnsiString;
var
  aes: TAESEncryption;
  cipher: string;
  i: integer;
  b: System.UInt8;
  bb, bb2: Tbytes;
  conv: TConvert;

begin
  SetLength(bb, (length(tcaKey) div 2));
  SetLength(bb2, (length(data) div 2));
{$IFDEF ANDROID}
  for i := 0 to (length(tcaKey) div 2) - 1 do
  begin
    b := System.UInt8(strToInt('$' + Copy(tcaKey, ((i) * 2) + 1, 2)));
    bb[i] := b;
  end;
{$ELSE}
  for i := 1 to (length(tcaKey) div 2) do
  begin
    b := System.UInt8(strToInt('$' + Copy(tcaKey, ((i - 1) * 2) + 1, 2)));
    bb[i - 1] := b;
  end;
{$ENDIF}
  aes := TAESEncryption.Create;
  aes.AType := atCBC;
  aes.KeyLength := kl256;
  aes.Unicode := noUni;
  conv := TConvert.Create;
  aes.Key := conv.TBytesToString(bb);
  aes.OutputFormat := hexa;
  aes.PaddingMode := TpaddingMode.PKCS7;
  aes.IVMode := TIVMode.rand;
  cipher := aes.Decrypt(data);
  aes.free;
  conv.free;
  result := cipher;
end;

{$IFDEF ANDROID}

procedure wipeAnsiString(var toWipe: AnsiString);
var
  i: integer;
begin
  for i := 0 to length(toWipe) - 1 do
    toWipe[i] := #0;
  toWipe := '';
end;
{$ELSE}

procedure wipeAnsiString(var toWipe: AnsiString);
var
  i: integer;
begin
  for i := 1 to length(toWipe) do
    toWipe[i] := #0;
  toWipe := '';
end;
{$ENDIF}

function reverseHexOrder(s: AnsiString): AnsiString;
var
  v: AnsiString;
begin
  s := StringReplace(s, '$', '', [rfReplaceAll]);
  result := '';
  repeat
    if length(s) >= 2 then
    begin
      v := Copy(s, 0, 2);
      delete(s, 1, 2);
      result := v + result;
    end
    else
      break;
  until 1 = 0;
end;

function priv256forHD(coin, x, y: integer; MasterSeed: AnsiString): AnsiString;
var
  bi: BigInteger;
begin
  result := GetSHA256FromHex(IntToHex(x, 32) + GetSHA256FromHex(IntToHex(coin,
    8) + GetSHA256FromHex(IntToHex(coin, 8) + IntToHex(x, 32) + MasterSeed +
    IntToHex(y, 32))) + IntToHex(y, 32));
  BigInteger.TryParse(result, 16, bi);
  if bi > secp256k1.getN then
    result := priv256forHD(coin, x, y, GetStrHashSHA256(result));

  wipeAnsiString(MasterSeed);
end;

function seedToHumanReadable(seed: AnsiString): AnsiString;
var
  i: integer;
begin
  result := '* ::: ';
  for i := StrStartIteration to length(seed) do
  begin
    result := result + seed[i];
{$IFDEF ANDROID}
    if i mod 1 = 0 then
      result := result + ' ';
    if i mod 7 = 0 then
{$ELSE}
    if i mod 2 = 0 then
      result := result + ' ';
    if i mod 8 = 0 then
{$ENDIF}
      result := result + ' :::  ';

  end;
  result := result + '*';
  wipeAnsiString(seed);
end;

procedure refreshWalletDat();
var
  wd: TWalletInfo;
  ts, oldFile: TStringList;
  i: integer;
begin
  if not FileExists(TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat'))
  then
  begin
    exit;
  end;

  ts := TStringList.Create;
  oldFile := TStringList.Create;
  oldFile.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath,
    'hodler.wallet.dat'));

  ts.Add(IntToStr(frmHome.LanguageBox.ItemIndex));
  ts.Add(CurrencyConverter.symbol);

  if CurrentAccount <> nil then
    ts.Add(CurrentAccount.name)
  else
    ts.Add('');

  ts.Add(IntToStr(length(AccountsNames)));
  for i := 0 to length(AccountsNames) - 1 do
    ts.Add(AccountsNames[i]);

  ts.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat'));
  ts.free;

  oldFile.free; // ?

end;

procedure createWalletDat();
var
  ts: TStringList;
  genThr: TThread;
begin

  ts := TStringList.Create;

  // ts.Add(inttostr(TCAIterations));
  // ts.Add(speckEncrypt((TCA(password)), seed));
  // ts.Add(booltoStr(userSavedSeed));
  ts.Add(IntToStr(frmHome.LanguageBox.ItemIndex));
  ts.Add(CurrencyConverter.symbol);
  ts.Add(''); // last open
  ts.Add('0'); // account quantity
  // ts.Add('default');

  ts.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat'));

  ts.free;

end;

procedure GenetareCoinsData(seed, password: AnsiString; ac: Account);
var
  genThr: TThread;
  wd: TWalletInfo;
var

  T: Token;
  EthAddress: AnsiString;
  Position: integer;
begin
  Position := 0;

  if ac = nil then
    raise Exception.Create('GenerateCoinsData() nullptr Exception');

  frmHome.PageControl.ActiveTab := frmHome.WaitWalletGenerate;

  // genThr := TThread.CreateAnonymousThread(
  // procedure

  // begin

  TThread.Synchronize(nil,
    procedure
    begin
      frmHome.WaitForGenerationProgressBar.Value := 0;
      frmHome.WaitForGenerationLabel.text := 'Generating BTC Wallet';
    end);

  // Put first addresses (0,0) of 4 coins
  wd := Bitcoin_createHD(0, 0, 0, seed);
  wd.orderInWallet := Position;
  inc(Position, 48);
  ac.AddCoin(wd);

  TThread.Synchronize(nil,
    procedure
    begin

      frmHome.WaitForGenerationProgressBar.Value := 20;
      frmHome.WaitForGenerationLabel.text := 'Generating LTC Wallet';
    end);

  wd := Bitcoin_createHD(1, 0, 0, seed);
  wd.orderInWallet := Position;
  inc(Position, 48);
  ac.AddCoin(wd);

  TThread.Synchronize(nil,
    procedure
    begin

      frmHome.WaitForGenerationProgressBar.Value := 40;
      frmHome.WaitForGenerationLabel.text := 'Generating DASH Wallet';
    end);

  wd := Bitcoin_createHD(2, 0, 0, seed);
  wd.orderInWallet := Position;
  inc(Position, 48);
  ac.AddCoin(wd);

  TThread.Synchronize(nil,
    procedure
    begin
      frmHome.WaitForGenerationProgressBar.Value := 60;
      frmHome.WaitForGenerationLabel.text := 'Generating BCH Wallet';
    end);

  wd := Bitcoin_createHD(3, 0, 0, seed);
  wd.orderInWallet := Position;
  inc(Position, 48);
  ac.AddCoin(wd);

  TThread.Synchronize(nil,
    procedure
    begin
      frmHome.WaitForGenerationProgressBar.Value := 80;
      frmHome.WaitForGenerationLabel.text := 'Generating ETH Wallet';
    end);

  wd := Ethereum_createHD(4, 0, 0, seed);
  wd.orderInWallet := Position;
  inc(Position, 48);
  ac.AddCoin(wd);
  EthAddress := wd.addr;

  TThread.Synchronize(nil,
    procedure
    var

      ti: TokenInfo;
    begin
      frmHome.WaitForGenerationProgressBar.Value := 100;

      for ti in Token.availableToken do
      begin
        T := Token.Create(ti.id - 10000, EthAddress);
        T.orderInWallet := Position;
        inc(Position, 48);

        T.idInWallet := length(ac.myTokens) + 10000;
        ac.AddToken(T);

      end;

    end);

  wipeAnsiString(seed);


  // end);

  // genThr.OnTerminate :=
  // frmHome.FormShow(nil);

  // genThr.Start;

end;

procedure wipeWalletDat;
var
  ts: TStringList;
  acname: AnsiString;
  tempAccount: Account;
  filePath: AnsiString;
begin
  try
    for acname in AccountsNames do
    begin
      tempAccount := Account.Create(acname);
      try
        for filePath in tempAccount.paths do
        begin
          ts := TStringList.Create;
          ts.LoadFromFile(filePath);
          ts.text := StringofChar('@', length(ts.text));
          ts.SaveToFile(filePath);
          ts.free;
          DeleteFile(filePath);
        end;

        RemoveDir(tempAccount.DirPath);
      except
        on E: Exception do
        begin
        end;
      end;

      tempAccount.free;
    end;
  finally
    DeleteFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat'));
    DeleteFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.fiat.dat'));
  end;
end;

procedure parseWalletFile;
var
  ts: TStringList;
  i, j: integer;
  wd: TWalletInfo;
begin
  ts := TStringList.Create;
  ts.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'hodler.wallet.dat'));

  frmHome.LanguageBox.ItemIndex := strToInt(ts[0]);
  CurrencyConverter.setCurrency(ts[1]);

  lastClosedAccount := ts[2];

  SetLength(AccountsNames, strToInt(ts[3]));
  for i := 0 to strToInt(ts[3]) - 1 do
  begin
    AccountsNames[i] := ts[4 + i];
  end;

  ts.free;

end;

procedure updateBalanceLabels();
var
  i: integer;
  component: TLabel;
  fmxObj: TFmxObject;
  Panel: Tpanel;
  cc: cryptoCurrency;
begin

  for i := 0 to frmHome.WalletList.Content.ChildrenCount - 1 do
  begin
    Panel := Tpanel(frmHome.WalletList.Content.Children[i]);
    cc := cryptoCurrency(Panel.TagObject);
    for fmxObj in Panel.Children do
    begin

      if fmxObj.TagString = 'balance' then
      begin
        TLabel(fmxObj).text := BigIntegerBeautifulStr(cc.confirmed, cc.decimals)
          + '    ' + floatToStrF(cc.getFiat, ffFixed, 15, 2) + ' ' +
          CurrencyConverter.symbol;
      end;

    end;

  end;

end;

procedure updateNameLabels();
var
  i: integer;
  component: TLabel;
  fmxObj: TFmxObject;
  Panel: Tpanel;
  cc: cryptoCurrency;
begin

  for i := 0 to frmHome.WalletList.Content.ChildrenCount - 1 do
  begin
    Panel := Tpanel(frmHome.WalletList.Content.Children[i]);
    cc := cryptoCurrency(Panel.TagObject);
    for fmxObj in Panel.Children do
    begin

      if fmxObj.TagString = 'name' then
      begin
        if cc.description = '' then
        begin
          TLabel(fmxObj).text := cc.name + ' (' + cc.shortcut + ')';
        end
        else
          TLabel(fmxObj).text := cc.description;
      end;

    end;

  end;

end;

procedure repaintWalletList;
var
  i: integer;
  T: Token;
begin

  updateBalanceLabels();
  updateNameLabels();

end;

function getHighestBlockNumber(T: Token): System.uint64;
var
  i, l: integer;
begin
  result := 0;
  l := length(T.history);
  if l = 0 then
    exit;

  for i := 0 to l - 1 do
    if T.history[i].lastBlock > result then
      result := T.history[i].lastBlock;

end;

function getUTXO(wallet: TWalletInfo): TUTXOS;
begin
  result := wallet.UTXO;
end;

function parseUTXO(utxos: AnsiString): TUTXOS;
var
  ts: TStringList;
  i: integer;
  utxoCount: integer;
begin
  ts := TStringList.Create;
  ts.text := utxos;
  utxoCount := ts.Count div 4;
  SetLength(result, utxoCount);
  for i := 0 to utxoCount - 1 do
  begin
    result[i].txid := ts.Strings[(i * 4) + 0];
    result[i].n := strToInt(ts.Strings[(i * 4) + 1]);
    result[i].ScriptPubKey := ts.Strings[(i * 4) + 2];
    result[i].Amount := StrToInt64(ts.Strings[(i * 4) + 3])

  end;

  ts.free;
end;

end.