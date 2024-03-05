# int main(int argc, char* argv[]) {
#     int    farenheit;
#     double celsius;

#     if(argc > 1) {
#         farenheit = atof(argv[1]);
#     } else {
#         std::cin >> farenheit;
#     }

#     celsius = (farenheit - 32) / 1.8;

#     std::cout << std::fixed << std::setprecision(8) << celsius;
# }
    
    .data
farenheit:  .word   0
celsius:    .double 0.0
factor:     .double 1.8

    .text
#  Registries used:
#    $s0 <- farenheit (int)    
#    $f2 <- farenheit (double)        
#    $f6 <- factor      
#    $f8 <- 32.0   
#    $f20 <- celsius 

main:

    li		    $v0, 5		        # system call #5 - input int
    syscall				            # execute
    move 	    $s0, $v0	        # $s0 = $v0

    mtc1        $s0, $f0            # move s0 into cp1
    cvt.d.w     $f2, $f0            # convert integer into double
    swc1		$f2, farenheit		# 
    

    ldc1        $f6, factor
    li.d        $f8, 32.0

    sub.d       $f20, $f2, $f8
    div.d       $f20, $f20, $f6

    sdc1        $f20, celsius

    addi		$v0, $0, 3		# system call #3 - print double
    ldc1		$f12, celsius
    syscall						# execute

    addi	    $v0, $0, 10		# System call 10 - Exit
    syscall					    # execute