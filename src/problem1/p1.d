module p1;

import std.algorithm;
import std.stdio;
import std.string;
import std.regex;

enum filename = "p1-input.txt";


import std.array;
import std.conv;

auto ctr = ctRegex!(`\d`);
void main() {
    auto file = File(filename);

    auto x = file
        .byLine
        .map!(str_line => str_line.matchAll(ctr))
        .map!(ds => ds.join)
        .filter!(ds => !ds.empty)
        .map!(digit_line => digit_line.front ~ digit_line.back)
        .map!(digit => digit.to!int)
        .sum;

    writeln(x);
}