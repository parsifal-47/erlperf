#!/usr/bin/env escript
-mode(compile).

-include_lib("common.hrl").

iterate(_, 0) -> ok;
iterate(F, N) -> F(), iterate(F, N-1).


main([]) ->
	add_libs(),
	NN = [300, 1],
	run_series(fun (N) -> iterate(fun random:uniform/0, N) end, 
		fun()->ok end, fun()->ok end, "Random uniform", NN),
	run_series(fun (N) -> iterate(fun os:timestamp/0, N) end, 
		fun()->ok end, fun()->ok end, "Os timestamp", NN),
	run_series(fun (N) -> iterate(fun() -> crypto:rand_bytes(4) end, N) end, 
		fun()->ok end, fun()->ok end, "Crypto rnd_bytes", NN),
	run_series(fun (N) -> iterate(fun erlang:now/0, N) end, 
		fun()->ok end, fun()->ok end, "Erlang now", NN).