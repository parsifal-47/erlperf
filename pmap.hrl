pmap(Fun, List) ->
    Self = self(),
    Refs = lists:map(fun (Element) ->
        Ref = erlang:make_ref(),
        _ = erlang:spawn_link(fun () ->
            Res = try
                {Ref, {ok, Fun(Element)}}
            catch
                C:E -> {Ref, {exception, {C,E,erlang:get_stacktrace()}}}
            end,
            Self ! Res
        end),
        Ref
    end, List),
    pmap_results(Refs, []).

pmap_results([], Res) -> lists:reverse(Res);
pmap_results([Ref|T], Res) ->
    receive
        {Ref, {ok, R}} ->
            pmap_results(T, [R|Res]);
        {Ref, {exception, {C,E,ST}}} ->
            erlang:raise(C, E, ST)
    end.
