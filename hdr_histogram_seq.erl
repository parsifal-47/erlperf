#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(_, 0) -> ok;
iterate(R, N) -> hdr_histogram:record(R, N), iterate(R, N-1).

main([]) ->
    add_libs(),
    {ok, _} = application:ensure_all_started(hdr_histogram),
    {ok,R} = hdr_histogram:open(1000000,3),
    run_series(fun (N)->iterate(R, N) end, fun()->ok end, fun()->ok end, 
    	"HDR histogram", lists:seq(1, 15)).