-export([parallel/2]).
-include_lib("pmap.hrl").

add_libs() ->
    CodePaths = filelib:wildcard("./deps/*/ebin/"),
    code:add_pathsz(CodePaths).

parallel(Iter, T) -> pmap(Iter, lists:duplicate(T, 3000000 div T)).

get_result(Iter, T) ->
    {Time, _Result} = timer:tc(?MODULE, parallel, [Iter, T]),
    Time.

out(Iterate, Text, T) ->
    io:format("~s ~p~n", [Text, T]),
    lists:map(fun(_) -> io:format("~p~n", [get_result(Iterate, T)]) end, lists:seq(1, 200)).

run_series(Iterate, Pre, Post, Text, Numbers) -> lists:map(fun(X) -> Pre(), out(Iterate, Text, X), Post() end, Numbers).
