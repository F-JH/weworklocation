//
// Created by Xiaoandi Fu on 2024/3/18.
//
#include <iostream>
#include <time.h>
#include <string>

using namespace std;

int main(int argc, char* argv[]) {
    if (argc < 2){
        exit(1);
    }
    char buf[128] = {0};
    tm _tm;
    strptime(argv[1], "%a %b %d %H:%M:%S %Z %Y", &_tm);
    strftime(buf, 128, "%Y-%m-%d %H:%M:%S", &_tm);
    cout << buf << endl;
}
