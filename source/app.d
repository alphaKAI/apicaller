import std.algorithm,
			 std.string,
			 std.array,
			 std.range,
			 std.stdio;

import twitter4d;

void main() {
	Twitter4D t4d;
	string[string] keys = [
    // Please replace here
	  "consumerKey"       : "Your ConsumerKey",
	  "consumerSecret"    : "Your ConsumerSecret",
	  "accessToken"       : "Your AccessToken",
	  "accessTokenSecret" : "Your AccessTokenSecret"
	];

	t4d = new Twitter4D(keys);
	writeln("API Console");
  writeln("Usage: Method(GET/POST) EndPoint(Ex: statuses/update) Parameters...(key value)");
  writeln("Example: POST statuses/update status foobar");

	while (true) {
		write("=> ");

    string input = readln.chomp;

    if (input == "exit") break;
		if (stdin.eof) break;

		string[] inputs = input.split;

    if (inputs.length < 2) {
			writeln("Invalid request");
			continue;
		}

		string method   = inputs[0];
		string endPoint = inputs[1] ~ ".json";
		size_t params   = inputs.length - 2;

		if (0 < params) {
			if (params % 2 != 0) {
				writeln("Invalid parameters");
				continue;
			}

      inputs = inputs[2..$];
			auto ikeys = params.iota.filter!(i => i % 2 == 0).map!(i => inputs[i]).array;
			auto ivals = params.iota.filter!(i => i % 2 != 0).map!(i => inputs[i]).array;

			writeln("Request ->");
			writeln("  Method: ", method);
			writeln("  EndPoin: ", endPoint);
			writeln("  Options: ", assocArray(zip(ikeys, ivals)));
			writeln("  Result:");
			writeln("  " ~ t4d.request(method, endPoint, assocArray(zip(ikeys, ivals))));
		}
	}
}
