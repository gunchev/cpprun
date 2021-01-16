#!/usr/local/bin/cpprun.sh g++ -I. -Wall --std=c++14 -pthread complex_src2.cpp
// Here the only "problem" is that we need '-I.' for the time being.

#include "complex_src2.h"

#include <cstdio>
#include <thread>

int main() {
    std::thread t([](){
        hello();
    });
    t.join();
    return 0;
}
