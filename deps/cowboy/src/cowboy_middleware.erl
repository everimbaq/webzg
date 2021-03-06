%% Copyright (c) 2013-2014, Loïc Hoguin <essen@ninenines.eu>
%%
%% Permission to use, copy, modify, and/or distribute this software for any
%% purpose with or without fee is hereby granted, provided that the above
%% copyright notice and this permission notice appear in all copies.
%%
%% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
%% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
%% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
%% ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
%% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
%% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
%% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

%% The cowboy_middleware behaviour defines the interface used by Cowboy middleware modules.
%% Middlewares process the request sequentially in the order they are configured.
%% http://ninenines.eu/docs/en/cowboy/HEAD/manual/cowboy_middleware/
-module(cowboy_middleware).

-type env() :: [{atom(), any()}].
-export_type([env/0]).

%% Execute the middleware.
%%
%% The ok return value indicates that everything went well
%% and that Cowboy should continue processing the request.
%% A response may or may not have been sent.
%%
%% The suspend return value will hibernate the process until an Erlang message is received.
%% Note that when resuming, any previous stacktrace information will be gone.
%%
%% The stop return value stops Cowboy from doing any further processing of the request,
%% even if there are middlewares that haven't been executed yet.
%% The connection may be left open to receive more requests from the client.
-callback execute(Req, Env)
	-> {ok, Req, Env}
	| {suspend, module(), atom(), [any()]}
	| {stop, Req}
	when Req::cowboy_req:req(), Env::env().


