# PR1. PRINCIPIO DE COMPUTADORES.
# Autor: Noah Iovanni Lorenzo Díaz
# Fecha ultima modificacion: 28/02/2024

# #include <iostream>
# #include <iomanip>

# int main(int argc, char *argv[])
# {
#     double error = 0;
#     double e = 1; // 1/0!
#     double fact = 1; // 0!
#     double numterminos = 1;
#     double ultimo_termino = 1; ; // 1/0!

#     std::cout << "\nPR1: Principio de computadores.\n";
#     do {
#         std::cout << "\nIntroduzca maximo error permitido: ";
#         std::cin >> error;
#         if (!(error >= 0.00001 && error < 1))   // !(error >= 0.00001 && error < 1)
#             std::cout << "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n";
#         else break;
#     } while (true);

#     while (ultimo_termino >= error) {
#         fact *= numterminos;
#         ultimo_termino = 1/fact;
#         e += ultimo_termino;
#         numterminos++;
#     }
#     std::cout <<  "\nNumero e: ";
#     std::cout << std::fixed << std::setprecision(17) << e;
#     std::cout << "\nNumero de terminos: " << int(numterminos);
#     std::cout << "\nPR1: Fin del programa.\n";
#     return 0;
# }

	.data
titulo:		        .asciiz "\nPR1: Principio de computadores.\n"
pet:		        .asciiz "\nIntroduzca maximo error permitido: "
caderr:		        .asciiz "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n"
cade:		        .asciiz "\nNumero e: "
cadnt:		        .asciiz "\nNumero de terminos: "
cadfin:		        .asciiz "\nPR1: Fin del programa.\n"

error:              .double 0.0
e:                  .double 1.0   # 1/0!
fact:               .double 1.0   # 0!
numterminos:        .double 1.0   
ultimo_termino:     .double 1.0   # 1/0!


	.text 
#  Registries used:
#    $f20 <- error           (Ln 74)
#    $f22 <- fact            (Ln 96)
#    $f24 <- e               (Ln 97)
#    $f26 <- numterminos     (Ln 98)
#    $f28 <- ultimo_termino  (Ln 99)

main:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, titulo     # Load the string "titulo" for printing
    syscall					    # execute

do:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, pet        # Load the string "pet" for printing
    syscall						# execute

    li		    $v0, 7		    # system call #7 - input double
    syscall						# execute
    sdc1		$f0, error		# Store the inputed double in error
    ldc1        $f20, error     # Store the value of error into f20

if:                            
    li.d        $f4, 0.00001    # Loading first limit into f4
    c.lt.d      $f20, $f4       # Compare error < 0.00001
    bc1t        then            # Branch if error < 0.00001

    li.d        $f4, 1.0        # Loading second limit into f4
    c.lt.d      $f20, $f4       # Compare error < 1
    bc1f        then            # Branch if error >= 1
    
    b           else            # Branch if both are false

then:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, caderr     # Load the string "caderr" for printing
    syscall						# execute
   
    b		    do			    # branch to do

else:

    ldc1        $f22, fact
    ldc1        $f24, e
    ldc1        $f26, numterminos
    ldc1        $f28, ultimo_termino

# while(ultimo_termino >= error)
while: 
    mul.d       $f22, $f22, $f26        # fact = fact * numterminos;
    li.d        $f4, 1.0                # load one for the next division
    div.d       $f28, $f4, $f22         # ultimo_termino = 1/fact
    add.d       $f24, $f24, $f28        # e = e + ultimo_termino
    li.d        $f4, 1.0                # load one for the next increment
    add.d       $f26, $f26, $f4         # numterminos = numterminos + 1

    c.lt.d      $f28, $f20              # Compare ultimo_termino < error
    bc1f        while                   # Branch if ultimo_termino >= error

# BREAK:
    sdc1        $f24, e                 # Save the obtained result into e
    sdc1        $f26, numterminos   # Save obtained number of terms into numterminos
    
    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cade       # Load string "cade" for printing
    syscall					    # execute

    li		    $v0, 3          # system call #3 - print double
    ldc1        $f12, e         # Load the value of e for printing
    syscall					    # execute

    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cadnt      # Load string "cadnt" for printing
    syscall					    # execute

    li		    $v0, 3              # system call #3 - print double
    ldc1        $f12, numterminos   # Load the value of numterminos for printing
    syscall					        # execute

    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cadfin     # Load string "cadfin" for printing
    syscall					    # execute

    li	        $v0, 10		    # System call 10 - Exit
    syscall					    # execute

##END