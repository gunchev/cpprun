#!/bin/bash

set -e
if [ "$#" == '0' ]; then
    echo "This script compiles and runs a C++ source file.
You can use it as shebang and make the source.cpp file executable.

Example hello.cpp:

#!/path/to/this/cpprun.sh
#include <stdio.h>
void main() {
    puts(\"Hello world!\");
}

You can add extra arguments also:

#!/path/to/this/cpprun.sh --std=c++20 -pthread extra_source.cpp

NB: On Linux and Minix an interpreter can be a script.
    On OSX the interpreter must be an executable binary, sorry Apples.
"
    exit 0
fi

TMP_DIR=$(mktemp -d /tmp/cpprun.XXXXXXXXXX)
function atexit { rm -rf -- "${TMP_DIR}"; }
trap atexit EXIT

# If there are arguments in the shebang they are in $1 and the script itself is $2. If there are none the script is $1.
# Assuming that if $1 is not a readable file it is shebang args till I know how to disambiguate this situation better.
SH_ARGS="g++ --std=c++20 -Wall -fstack-protector-all -O1 -D_FORTIFY_SOURCE=2"  # Some sane defaults
if [ ! -r "$1" ]; then
    SH_ARGS="$1"
    shift 1
else
    # Do we need -pthread
    if grep '<\(thread\|pthread\.h\)>' "$1" > /dev/null 2>&1; then
        SH_ARGS="${SH_ARGS} -pthread"
    fi
fi
SCRIPT="$1" # Now $1 is the script for sure (baring the ambiguity above).

# Make SH_ARGS an actual array with hackery, hope it is safe.
# Test with #!/path/cpprun strange "arg uments" )here(!
eval SH_ARGS=($(sed 's/\([()]\)/\\\1/g' <<< "${SH_ARGS}")) # 'cause

SCRIPT_NAME="$(basename -- "${SCRIPT}")"
BASE_NAME="${SCRIPT_NAME%.[^.]*}"
# Extra '.cpp' does not hurt, saves the effort to check if SCRIPT_NAME == BASE_NAME
tail -n +2 -- "${SCRIPT}" > "${TMP_DIR}/${SCRIPT_NAME}.cpp"

OLD_PWD="${PWD}"
# Go to where the source is, makes including extra sources/headers possible (relative to the source file).
cd -- "$(dirname -- "${SCRIPT}")"
set +e
# Compile
"${SH_ARGS[@]}" "${TMP_DIR}/${SCRIPT_NAME}.cpp" -o "${TMP_DIR}/${BASE_NAME}" > "${TMP_DIR}/.stdout" 2> "${TMP_DIR}/.stderr"
ERR=$?
cd "$OLD_PWD"
if [ "$ERR" != "0" ]; then
    (
        echo "Error compiling!"
        echo "=== stdout ==="
        cat "${TMP_DIR}/.stdout"
        echo "=== stderr ==="
        cat "${TMP_DIR}/.stderr"
    ) >> /dev/stderr
else
    # Run
    "${TMP_DIR}/${BASE_NAME}" "${@: 2:$#-1}"
    ERR=$?
fi

exit $ERR
