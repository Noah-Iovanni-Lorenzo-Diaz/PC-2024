#include <iostream>

int main() {
    std::cout << "Programa para repasar las tablas de multiplicar.\n";
    int n;

    do {
        std::cout << "De qué tabla deseas repasar? Introduce un número (0 para salir): ";
        std::cin >> n;
        if(n == 0) break;
        int aciertos = 0;
        for(int i{1}; i <= 10; i++) {
            std::cout << i << " x " << n << " ? ";
            int resultado;
            std::cin >> resultado;
            if (resultado == i * n) aciertos++;
        }
        int porcentaje = aciertos * 10;
        std::cout << "Tu porcentaje de aciertos es del " << porcentaje << "%\n";
    } while(n != 0);
    std::cout << "Termina el programa. \n";
}


