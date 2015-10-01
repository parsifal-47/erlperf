compile:
	./rebar get-deps
	./rebar compile
run: compile
	./simple_inc.erl
	./folsom_inc.erl
	./exometer_inc.erl
	./folsom_hist.erl
	./exometer_hist.erl
	./hdr_histogram.erl
	./random.erl