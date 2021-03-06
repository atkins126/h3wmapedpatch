unit RSButton;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ This file is a subject to any one of these licenses at your choice:     }
{ BSD License, MIT License, Apache License, Mozilla Public License.       }
{                                                                         }
{ *********************************************************************** }
{$I RSPak.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, RSCommon;

{$I RSWinControlImport.inc}

type
  TRSButton = class(TButton)
  private
    FOnCreateParams: TRSCreateParamsEvent;
    FProps: TRSWinControlProps;
  protected
    procedure CreateParams(var Params:TCreateParams); override;
    procedure TranslateWndProc(var Msg:TMessage);
    procedure WndProc(var Msg:TMessage); override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property OnCanResize;
    property OnDblClick;
    property OnResize;
    {$I RSWinControlProps.inc}
  end;

procedure register;

implementation

procedure register;
begin
  RegisterComponents('RSPak', [TRSButton]);
end;

{
********************************** TRSButton ***********************************
}
constructor TRSButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  WindowProc:=TranslateWndProc;
end;

procedure TRSButton.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  if Assigned(FOnCreateParams) then FOnCreateParams(Params);
end;

procedure TRSButton.TranslateWndProc(var Msg:TMessage);
var b:boolean;
begin
  if Assigned(FProps.OnWndProc) then
  begin
    b:=false;
    FProps.OnWndProc(Self, Msg, b, WndProc);
    if b then exit;
  end;
  WndProc(Msg);
end;

procedure TRSButton.WndProc(var Msg:TMessage);
begin
  RSProcessProps(self, Msg, FProps);
  inherited;
end;

end.
