/*/true;A="$(readlink -f -- "$0")";cc -Wall -o "$A.bin" "$A" && "$A.bin";E=$?;rm "$A.bin";exit $E #*/

#include <stdio.h>

int main() {
    puts("Hello world!");
    return 0;
}
