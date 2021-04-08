/*/true;A="$(readlink -f -- "$0")";g++ --std=c++14 -Wall -Wno-unused-label -o "$A.bin" "$A" && "$A.bin" "$@";E=$?;rm "$A.bin";exit $E #*/

// The "trick" here is that if no valid shebang is found then /bin/sh will
// be used as interpreter. Using // makes it a C++ comment, but /* works in C too.

// A shorter way of doing it would be (if you promise not to use funky names):
/*/bin/g++ -Wall -o "$0.bin" "$0" && "$0.bin";E=$?;rm "$0.bin";exit $E #*/


#include <cstdio>

int main() {
    puts("Hello world!");
    return 0;
}
