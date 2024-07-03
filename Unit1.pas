//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections;

type
  //------------Composição----------
  TEngine = class
  private
    FPower: Integer;
  public
    constructor Create(APower: Integer);
    property Power: Integer read FPower write FPower;
  end;

  TCar = class
  private
    FEngine: TEngine;
  public
    constructor Create(APower: Integer);
    destructor Destroy; override;
    procedure Drive;
    property Engine: TEngine read FEngine;
  end;
  //------------Composição----------


  //------------Agregação----------
  TProgrammer = class
  private
    FName: string;
  public
    constructor Create(AName: string);
    property Name: string read FName write FName;
  end;

  TDevelopmentTeam = class
  private
    FProgrammers: TList<TProgrammer>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddProgrammer(AProgrammer: TProgrammer);
    procedure ShowTeam;
  end;
  //------------Agregação----------

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


{ TEngine }

constructor TEngine.Create(APower: Integer);
begin
  FPower := APower;
end;

{ TCar }

constructor TCar.Create(APower: Integer);
begin
  FEngine := TEngine.Create(APower); // Composição: motor é parte integral do carro
end;

destructor TCar.Destroy;
begin
  FEngine.Free; // Libera a memória ocupada pelo motor
  inherited;
end;

procedure TCar.Drive;
begin
  ShowMessage('Driving with '+ IntToStr(FEngine.Power)+ ' horsepower');
end;

{ TDevelopmentTeam }

constructor TDevelopmentTeam.Create;
begin
  FProgrammers := TList<TProgrammer>.Create; // Cria a lista de programadores
end;

destructor TDevelopmentTeam.Destroy;
begin
  FProgrammers.Free; // Libera a memória ocupada pela lista de programadores
  inherited;
end;

procedure TDevelopmentTeam.AddProgrammer(AProgrammer: TProgrammer);
begin
  FProgrammers.Add(AProgrammer); // Adiciona um programador à equipe
end;

procedure TDevelopmentTeam.ShowTeam;
var
  Programmer: TProgrammer;

begin
  for Programmer in FProgrammers do
    ShowMessage('Programmer: '+ Programmer.Name);
end;

{ TProgrammer }

constructor TProgrammer.Create(AName: string);
begin
  FName := AName;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  Car: TCar;

begin
    Car := TCar.Create(150); // Cria um carro com um motor de 150 cavalos de potência
    try
      Car.Drive; // Simula a condução do carro
    finally
      Car.Free; // Libera a memória ocupada pelo carro
    end;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  Team: TDevelopmentTeam;
  Programmer1, Programmer2: TProgrammer;

begin
  try
    Team := TDevelopmentTeam.Create; // Cria uma nova equipe de desenvolvimento
    try
      Programmer1 := TProgrammer.Create('Alice');
      Programmer2 := TProgrammer.Create('Bob');

      Team.AddProgrammer(Programmer1); // Adiciona Alice à equipe
      Team.AddProgrammer(Programmer2); // Adiciona Bob à equipe

      Team.ShowTeam; // Exibe os membros da equipe
    finally
      Team.Free; // Libera a memória ocupada pela equipe
      Programmer1.Free;//Libera a memória ocupada pelo programador 1
      Programmer2.Free;//Libera a memória ocupada pelo programador 2
    end;
  except
    on E: Exception do
      ShowMessage(E.ClassName+ ': '+ E.Message);
  end;

end;

end.
