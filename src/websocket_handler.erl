-module(websocket_handler).

-export([
	init/2,
	websocket_handle/3,
	websocket_info/3
	]).

init(Req, _Opts) ->
    erlang:start_timer(1000, self(), get_time()),
    {cowboy_websocket, Req, #{}}.

websocket_handle(Frame = {text, _}, Req, State) ->
    {reply, Frame, Req, State};
websocket_handle(_Frame, Req, State) ->
    {ok, Req, State}.

websocket_info({log, Text}, Req, State) ->
    {reply, {text, Text}, Req, State};
websocket_info({timeout, _Ref, Msg}, Req, State) ->
    erlang:start_timer(1000, self(), get_time()),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

get_time() ->
    {{_Year, _Month, _Day}, {Hour, Min, Sec}} = erlang:localtime(),
    lists:concat([Hour, ":", Min, ":", Sec]).
