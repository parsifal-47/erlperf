#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(0) -> ok;
iterate(N) -> folsom_metrics:notify({"test", N}), iterate(N-1).

init(Params) -> apply(folsom_metrics, new_histogram, ["test"] ++ Params).
cleanup() -> folsom_metrics:delete_metric("test").

main([]) ->
    add_libs(),
    {ok, _} = application:ensure_all_started(folsom),
    NN = [300, 1],
	run_series(fun iterate/1, fun()->init([]) end, fun cleanup/0, "Folsom default hist", NN),
	run_series(fun iterate/1, fun()->init([exdec, 0.11]) end, 
		fun cleanup/0, "Folsom exdec 0.11", NN),
	run_series(fun iterate/1, fun()->init([slide, 1024]) end, 
		fun cleanup/0, "Folsom slide 1024", NN),
	run_series(fun iterate/1, fun()->init([slide_uniform, {10, 1024}]) end, 
		fun cleanup/0, "Folsom slide uniform 10 1024", NN).