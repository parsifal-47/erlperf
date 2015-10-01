#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(0) -> ok;
iterate(N) -> exometer:update("test", 1), iterate(N-1).

main([]) ->
    add_libs(),
    {ok, _} = application:ensure_all_started(exometer),
    exometer:new("test", counter),
	run_series(fun iterate/1, fun()->ok end, fun()->ok end, "Exometer counter", [300, 1]).