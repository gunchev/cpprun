//usr/bin/g++ -Wall "$0" -o "$0.bin"; "$0.bin"; E=$?; rm "$0.bin"; exit $E

// The "trick" here is that if no valid shebang is found then /bin/sh will
// be used as interpreter. Using // makes it a C++ comment, and...

#include <stdio.h>

int main() {
    puts("Hello world!");
    return 0;
}
