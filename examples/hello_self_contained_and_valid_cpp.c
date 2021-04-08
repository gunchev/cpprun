/*/true;A="$(readlink -f -- "$0")";cc -Wall -o "$A.bin" "$A" && "$A.bin" "$@";E=$?;rm "$A.bin";exit $E #*/

#include <stdio.h>
#include <sysexits.h>

int main(int argc, char **argv, char **envv) {
    puts("Hello world!");
    for (int i = 1; i < argc; ++i) {
        puts(argv[i]);
    }
    return EX_OK;
}
