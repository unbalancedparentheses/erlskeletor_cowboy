-module(websocket_handler).

-export([
	init/2,
	websocket_handle/3,
	websocket_info/3
	]).

init(Req, _Opts) ->
    {cowboy_websocket, Req, #{}}.

websocket_handle(Frame = {text, _}, Req, State) ->
    {reply, Frame, Req, State};
websocket_handle(_Frame, Req, State) ->
    {ok, Req, State}.

websocket_info({log, Text}, Req, State) ->
    {reply, {text, Text}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.
