#!/usr/bin/env -S rdmd -J=.
module p2;

import std.array;
import std.conv;
import std.format;
import std.string;
import std.stdio;

enum inputs = import("input.txt");
// enum inputs = import("example.txt");

struct Cubes {
    int red;
    int green;
    int blue;

    string toString() const {
        return format(
            "red: %s, green: %s, blue: %s", 
            red, green, blue);
    }
}

// "5 red, 3 gren, 4 blue"
Cubes countCubes(string input) {
    Cubes c;
    auto cubes = input.split(",");
    foreach(cube; cubes) {
        auto kv = cube.strip(" ").split(" ");
        switch (kv[1]) {
            case "red":
                c.red += kv[0].to!int;
                break;
            case "green":
                c.green += kv[0].to!int;
                break;
            case "blue":
                c.blue += kv[0].to!int;
                break;
            default:
                throw new Exception(format("Color doesn't exist %s",  kv[1]));
        }
    }
    return c;
}

Cubes max = {
    red: 12,
    green: 13,
    blue: 14,
};


bool impossible(string input) {
    auto sets = input.split(":")[1].strip;

    foreach(set; sets.split(";")) {
        auto cubes = countCubes(set);
        // writeln(cubes);
        if (!( (cubes.red <= max.red) 
            && (cubes.green <= max.green)
            && (cubes.blue <= max.red ))) {
            return true;
        }
    }

    return false;
}

void main() {
    int possible_id_sum = 0;

    foreach(id, i; inputs.split("\n")[0 .. $-1]) {
        id++;

        bool possible = !impossible(i);
        // writeln(possible);
        if(possible) {
            writeln(id);
            possible_id_sum += id;
        }
    }
    writeln(possible_id_sum);
}
