#!/usr/bin/env escript
-mode(compile).

next_sample(N, A, X) when N > length(A) -> [X | A];
next_sample(_, A, {T, D}) ->
	Random = math:exp(0.1*T)/random:uniform(),
	[_ | SN] = lists:sort(fun({X, _}, {Y, _}) -> X =< Y end, [{Random, D} | A]),
	SN.

run_until(_, Sample, [], _) -> {[], Sample};
run_until(_, Sample, [{T, D} | Data], Until) when T > Until ->
	{[{T, D} | Data], Sample};
run_until(Size, Sample, [{T, D} | Data], Until) ->
	S = next_sample(Size, Sample, {T, D}), run_until(Size, S, Data, Until).

read_list(L, 0) -> L;
read_list(L, N) -> {ok, [X]} = io:fread("", "~f"), read_list(L ++ [X], N - 1).

main([]) ->
	Length = 204,
	Data = lists:zip(read_list([], Length), lists:seq(1, Length)),
	{NewData, Sample} = run_until(15, [], Data, 4),
	{_, Nums} = lists:unzip(Sample),
	io:format("~w~n", [lists:sort(Nums)]),
	{NewData2, Sample2} = run_until(15, Sample, NewData, 8),
	{_, Nums2} = lists:unzip(Sample2),
	io:format("~w~n", [lists:sort(Nums2)]),
	{NewData3, Sample3} = run_until(15, Sample2, NewData2, 12),
	{_, Nums3} = lists:unzip(Sample3),
	io:format("~w~n", [lists:sort(Nums3)]),
	{[], Sample4} = run_until(15, Sample3, NewData3, 16),
	{_, Nums4} = lists:unzip(Sample4),
	io:format("~w~n", [lists:sort(Nums4)]).
