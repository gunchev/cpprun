#!/usr/local/bin/cpprun.sh

// the need for -pthread will be detected.

#include <cstdio>
#include <thread>

int main() {
    std::thread t([](){
        puts("Hello world from std::thread!");
    });
    t.join();
    return 0;
}
