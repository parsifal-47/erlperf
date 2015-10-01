#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(0) -> ok;
iterate(N) -> iterate(N-1).

main([]) ->
	run_series(fun iterate/1, fun()->ok end, fun()->ok end, "Simple inc", [300, 1]).
