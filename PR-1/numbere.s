# PR1. PRINCIPIO DE COMPUTADORES.
# Autor: 
# Fecha ultima modificacion:

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

main:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, titulo
    syscall					    # execute

do:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, pet
    syscall						# execute

    li		    $v0, 7		    # system call #7 - input double
    syscall						# execute
    sdc1		$f0, error		# Store the input double in error
    ldc1        $f20, error     # Store the value of error into f20

if:                            
    li.d        $f4, 0.00001    # Loading first limit into f4
    c.lt.d      $f20, $f4       # Compare error < 0.00001
    bc1t        then            # Branch if error < 0.00001

    li.d        $f4, 1.0        # Loading second limit into f4
    c.lt.d      $f20, $f4      # Compare error < 1
    bc1f        then            # Branch if error >= 1
    
    b           else            # Branch if both are false

then:
    li		    $v0, 4		    # system call #4 - print string
    la		    $a0, caderr
    syscall						# execute
   
    b		    do			    # branch to do

else:

    ldc1        $f22, fact
    ldc1        $f24, e
    ldc1        $f26, numterminos
    ldc1        $f28, ultimo_termino

while: # ultimo_termino >= error
    mul.d       $f22, $f22, $f26        # fact = fact * numterminos;
    li.d        $f4, 1.0                # load one for the next division
    div.d       $f28, $f4, $f22         # ultimo_termino = 1/fact
    add.d       $f24, $f24, $f28        # e = e + ultimo_termino
    li.d        $f4, 1.0                # load one for the next increment
    add.d       $f26, $f26, $f4         # numterminos = numterminos + 1

    c.lt.d      $f28, $f20              # Compare ultimo_termino < error
    bc1f        while                   # Branch if ultimo_termino >= error

# BREAK
    sdc1        $f24, e             # Save the obtained result into e
    sdc1        $f26, numterminos   # Save num of terms obtained into numterminos

    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cade
    syscall					    # execute

    li		    $v0, 3          # system call #4 - print string
    ldc1        $f12, e         # Store the value of e into f12
    syscall					    # execute

    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cadnt
    syscall					    # execute

    li		    $v0, 3              # system call #4 - print string
    ldc1        $f12, numterminos   # Store the value of numterminos into f12
    syscall					        # execute

    li		    $v0, 4          # system call #4 - print string
    la		    $a0, cadfin
    syscall					    # execute

    li	        $v0, 10		    # System call 10 - Exit
    syscall					    # execute