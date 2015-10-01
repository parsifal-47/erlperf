#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(0) -> ok;
iterate(N) -> exometer:update("test", N), iterate(N-1).

main([]) ->
    add_libs(),
    {ok, _} = application:ensure_all_started(exometer),
    exometer:new("test", histogram), % default is slide
	run_series(fun iterate/1, fun()->ok end, fun()->ok end, "Exometer default histogram", [300, 1]).