# int main() {
#     std::cout << "Programa para repasar las tablas de multiplicar.\n";
#     int n;

#     do {
#         std::cout << "De qué tabla deseas repasar? Introduce un número (0 para salir): ";
#         std::cin >> n;
#         if(n == 0) break;
#         int aciertos = 0;
#         for(int i{1}; i <= 10; i++) {
#             std::cout << i << " x " << n << " ? ";
#             int resultado;
#             std::cin >> resultado;
#             if (resultado == i * n) aciertos++;
#         }
#         int porcentaje = aciertos * 10;
#         std::cout << "Tu porcentaje de aciertos es del " << porcentaje << "%\n";
#     } while(n != 0);
#     std::cout << "Termina el programa. \n";
# }    
    
    .data
cadint:     .asciiz "Programa para repasar las tablas de multiplicar.\n"
cadpet:     .asciiz "De qué tabla deseas repasar? Introduce un número (0 para salir): "
cadx:       .asciiz " x "
cadqst:     .asciiz " ? "
cadper:     .asciiz "Tu porcentaje de aciertos es del "
cadmod:     .asciiz "%\n"

cadend:     .asciiz "Termina el programa. \n"

number:     .word 0
result:     .word 0
correct:    .word 0
percentage: .word 0

    .text
#  Registries used:
#    $s0 <- counter       (Ln 51)
#    $s1 <- result        (Ln 96)
#    $s2 <- number        (Ln 62)
#    $s3 <- correct       (Ln 88)
#    $s4 <- percentage    (Ln 89)

main:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, cadint
    syscall						# execute

do:
    li          $s0, 1              # Reset counter for iterations 1-10
    li          $s3, 0              # Reset correct answers counter
    sw          $zero, correct      # Also reset the correct counter in memory

    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, cadpet
    syscall						# execute

    li		    $v0, 5		    # system call #5 - input int
    syscall						# execute
    move 	    $s2, $v0
    sw          $s2, number     
    beqz        $s2, endwhile      # branch if number == 0

for: #int i{1} <= 10
    li		    $v0, 1		        # system call #1 - print int
    move        $a0, $s0
    syscall						    # execute

    li		    $v0, 4		        # system call #4 - print string
    la		    $a0, cadx
    syscall						    # execute

    li		    $v0, 1		        # system call #1 - print int
    lw		    $a0, number
    syscall						    # execute

    li		    $v0, 4		        # system call #4 - print string
    la		    $a0, cadqst
    syscall						    # execute

    li		    $v0, 5		        # system call #5 - input int
    syscall						    # execute
    sw          $v0, result         # result = v0

if:
    lw		    $s1, result		    # s1 = result
    lw          $s3, correct        # s3 = correct
    lw          $s4, percentage     # s4 = percentage

    mul         $t2, $s0, $s2       # t2 = counter * number
    addi        $s0, 1              # counter++
    bne		    $s1, $t2, else	    # branch if result != counter * number

    addi        $s3, 1              # correct++
    sw          $s3, correct
    b           else                # branch to else

else:
    li          $t1, 10             # t1 = 10 for comparation
    sle         $t0, $s0, $t1       # compare counter <= 10
    bnez        $t0, for            # branch if counter > 10

do2:
    li          $t1, 10         # $t1 = 10
    mul	        $s4, $s3, $t1	# percentage = aciertos * 10
    sw          $s4, percentage

    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, cadper
    syscall						# execute

    li		    $v0, 1		    # system call #1 - print int
    lw	        $a0, percentage
    syscall						# execute

    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, cadmod
    syscall						# execute

# While:
    bnez        $s2, do         # branch to do if s2 != 0

endwhile:
    li  		$v0, 4		    # system call #4 - print string
    la		    $a0, cadend
    syscall						# execute

    li	        $v0, 10		    # System call 10 - Exit
    syscall					    # execute