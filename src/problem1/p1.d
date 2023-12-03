module p1;

import std.algorithm;
import std.stdio;
import std.string;
import std.regex;
import std.conv;


int[string] callibration_strings;




static string[] words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
static int[] numbers = [1,2,3,4,5,6,7,8,9];


// create a function for skipping finding the first num
int findFirstCallibration(char[] line) {
    import std.ascii;
    for(size_t i=0; i < line.length; i++) {
        const c = line[i];
        if (c.isDigit) {
            return cast(int) c-'0';
        }

        for(size_t d=0; d<words.length; d++) {
            const word = words[d];
            if (word.length > line.length - i) {
                continue;
            }
            const digit_from_index = line[i..i+word.length];
            if (digit_from_index == word) {
                return numbers[d];
            }

        }
        
    }
    assert(0);
}
int findLastCallibration(char[] line) {
    import std.ascii;
    for(size_t i=line.length-1; i >= 0; i--) {
        const c = line[i];
        if (c.isDigit) {
            return cast(int) c-'0';
        }
        for(size_t d=0; d<words.length; d++) {
            const word = words[d];
            if (word.length > line.length - i) {
                continue;
            }
            const digit_from_index = line[i..i+word.length];
            if (digit_from_index == word) {
                return numbers[d];
            }

        }
    }
    assert(0);
}


void main() {
    auto file = File("p1-input.txt");


    import std.datetime.stopwatch;
    auto sw = StopWatch(AutoStart.no);
    sw.start();
    auto x = file.byLine
        .map!(line => findFirstCallibration(line)*10 + findLastCallibration(line))
        .sum;
    writeln(x);
    sw.stop();

    long msecs = sw.peek.total!"usecs";
    writefln("took: %d msecs", msecs);

}
