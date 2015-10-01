#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(0) -> ok;
iterate(N) -> folsom_metrics:notify({"test", {inc, 1}}), iterate(N-1).

main([]) ->
    add_libs(),
    {ok, _} = application:ensure_all_started(folsom),
	folsom_metrics:new_counter("test"),
	run_series(fun iterate/1, fun()->ok end, fun()->ok end, "Folsom counter", [300, 1]).