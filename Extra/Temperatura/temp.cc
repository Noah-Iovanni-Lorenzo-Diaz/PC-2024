#include <iostream>
#include <iomanip>
#include <string>

int main(int argc, char* argv[]) {
    int    farenheit;
    double celsius;

    if(argc > 1) {
        farenheit = atof(argv[1]);
    } else {
        std::cin >> farenheit;
    }

    celsius = (farenheit - 32) / 1.8;

    std::cout << std::fixed << std::setprecision(8) << celsius;
}