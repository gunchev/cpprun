#!/usr/local/bin/cpprun.sh

#include <stdio.h>
#include <sysexits.h>

int main(int argc, char **argv, char **envv) {
    puts("Hello world!");
    for (int i = 1; i < argc; ++i) {
        puts(argv[i]);
    }
    return EX_OK;
}
