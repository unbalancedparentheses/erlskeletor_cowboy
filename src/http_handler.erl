-module(http_handler).

-export([init/2]).

init(Req, Opts) ->
    Req2 = cowboy_req:reply(200, [
                                  {<<"content-type">>, <<"text/plain">>}
                                 ], <<"Hello world!\n">>, Req),
    {ok, Req2, Opts}.
