.globl _start

.section .data

numberofnumbers:
    .quad 7

mynumbers:
    .quad 5, 20, 33, 80, 52, 10, 1

### This programm will find the largest value in the array

.section .text
_start:
    ### Initialize Registers ###

    # Put the number of elements of the array in %rcx
    movq numberofnumbers, %rcx

    # Use %rdi to hold the current-high value
    movq $0xFFFFFFFFFFFF , %rdi

    ### Check Preconditions

    # If there are no numbers, stop
    cmp $0, %rcx
    je endloop

    ### Main Loop ###
myloop:
    # Get the next value of mynumbers indexed by %rbx
    movq mynumbers-8(,%rcx,8), %rax

    # If it is not bigger, go to the end of the Loop
    cmp %rdi, %rax
    jae loopcontrol

    # Otherwise, store this as the biggest element so far
    movq %rax, %rdi

loopcontrol:
    # Decrement %rcx and keep going until %rcx is zero
    loopq myloop

    ### Clean up and Exit ###
endloop:
    # We're done - Exit
    movq $60, %rax
    syscall
