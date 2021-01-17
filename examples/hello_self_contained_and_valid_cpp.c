/*usr/bin/true; A="$(readlink -f -- "$0")"; function x { rm "$A.bin"; }; trap x EXIT; cc -Wall "$A" -o "$A.bin"; "$A.bin"; E=$?; exit $E; # */

// Looks like we can pull up the same trick in C.

#include <stdio.h>

int main() {
    puts("Hello world!");
    return 0;
}
