unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient,System.JSON, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxGroupBox, Data.DB, Datasnap.DBClient,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Response.Adapter, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, dxDateRanges, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, dxmdaset ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    cxGroupBox1: TcxGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    dxMemData1: TdxMemData;
    dxMemData1DailyWorkDate: TIntegerField;
    dxMemData1TarafName: TStringField;
    dxMemData1DailyWorkProfitAll: TFloatField;
    DataSource1: TDataSource;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1DailyWorkDate: TcxGridDBColumn;
    cxGrid1DBTableView1TarafName: TcxGridDBColumn;
    cxGrid1DBTableView1DailyWorkProfitAll: TcxGridDBColumn;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    FToken:string ;
    procedure LoadJSONData ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  RequestData: TStringStream;
  Response: string;
begin

IdHTTP := TIdHTTP.Create(nil);
  RequestData := TStringStream.Create('{"email": "kamihadad@gmail.com", "pass_": "K@mran123"}', TEncoding.UTF8);

  try
    IdHTTP.Request.ContentType := 'application/json';

    // Replace the URL with your actual API endpoint
    Response := IdHTTP.Post('http://178.252.171.198:8000/api/authenticate', RequestData);

    // Display the response or handle it as needed
    Memo1.Text:=Response;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;

  IdHTTP.Free;
  RequestData.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  URL: string;
  Response: string;

begin








  IdHTTP := TIdHTTP.Create(nil);
  try
    // Replace the URL with your actual API endpoint
    URL := 'http://178.252.171.198:8000/api/custrepAll/1';
//    URL := 'http://178.252.171.198:8000/api/Tarefe';


    // Set up authorization header with your JWT token
    IdHTTP.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' +FToken);

    // Perform the GET request
    Response := IdHTTP.Get(URL);

    // Display the response in Memo1 or handle it as needed
    Memo3.Lines.Text := Copy(Response,2,Length(Response)-2);

  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
  IdHTTP.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  JSONValue: TJSONValue;
  JSONObject: TJSONObject;
  Uid: Integer;
  Email, UserName: string;
begin
    // Your JSON string

  try
    JSONValue := TJSONObject.ParseJSONValue(Memo1.Text);
    if JSONValue <> nil then
    begin
      try
        JSONObject := JSONValue as TJSONObject;

        // Extracting values from the JSON object
        Uid := JSONObject.GetValue('Uid').Value.ToInteger;
        Email := JSONObject.GetValue('email').Value;
        UserName := JSONObject.GetValue('UserName').Value;
        FToken := JSONObject.GetValue('Token').Value;

        Memo2.Lines.Add(IntToStr(Uid)) ;
        Memo2.Lines.Add(Email) ;
        Memo2.Lines.Add(UserName) ;
        Memo2.Lines.Add(FToken) ;
        // Displaying the extracted values
//        ShowMessage(Format('Uid: %d'#13#10'Email: %s'#13#10'UserName: %s'#13#10'Token: %s',
//          [Uid, Email, UserName, Token]));

      finally
        JSONValue.Free;
      end;
    end;
  except
    on E: Exception do
      ShowMessage('Error parsing JSON: ' + E.Message);
  end;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
LoadJSONData  ;
end;

procedure TForm1.LoadJSONData;
//const
//  JsonString = '[{"DailyWorkDate":305,"TarafName":"kamihadad@gmail.com","DailyWorkProfitAll":0.6208715},{"DailyWorkDate":400,"TarafName":"Alou@gmail.com","DailyWorkProfitAll":0.8984555}]';
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
begin
  try
    dxMemData1.Open;

    // Parse the JSON string
    JSONValue := TJSONObject.ParseJSONValue(Memo3.Text);

    if Assigned(JSONValue) and (JSONValue is TJSONArray) then
    begin
      JSONArray := JSONValue as TJSONArray;

      try
        // Iterate through the JSON array
        for JSONValue in JSONArray do
        begin
          if JSONValue is TJSONObject then
          begin
            JSONObject := JSONValue as TJSONObject;

            // Append a new record to dxMemData1
            dxMemData1.Append;

            // Set the values of fields based on the keys in the JSON object
            dxMemData1.FieldByName('DailyWorkDate').AsString := JSONObject.GetValue('DailyWorkDate').Value;
            dxMemData1.FieldByName('TarafName').AsString := JSONObject.GetValue('TarafName').Value;
            dxMemData1.FieldByName('DailyWorkProfitAll').AsFloat := JSONObject.GetValue('DailyWorkProfitAll').Value.ToDouble;

            // Post the changes to the dataset
            dxMemData1.Post;
          end;
        end;

        // Display data in the cxGrid

      finally
        JSONArray.Free;
      end;
    end;
  finally
    // Ensure dxMemData1 is closed after the entire process

  end;
end;

end.


