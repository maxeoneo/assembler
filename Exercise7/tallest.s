.globl _start
.section .text
_start:
    ### Initialize Registers ###

    # Pointer to first record
    leaq people, %rbx

    # Record count
    movq numpeople, %rcx

    # Tallest value found
    movq %rbx, %rdi

    ### Check Preconditions ###
    # If there are no records, finish
    cmpq $0, %rcx
    je finish

    ### Main Loop ###
mainloop:
    # %rbx is the pointer to the whole struct
    # This instrcution grab the height field
    # and stores it in %rax
    movq HEIGHT_OFFSET(%rbx), %rax

    # Of it is less than or equal to our current
    # tallest, go to the next one.
    cmpq HEIGHT_OFFSET(%rdi), %rax
    jbe endloop

    # Copy this value as the tallest value
    movq %rbx, %rdi

endloop:
    # Move %rbx to point to the next record
    addq $PERSON_RECORD_SIZE, %rbx

    # Decrement %rcx and do it again
    loopq mainloop

    ### Finish it off ###
finish:
    # we want to return the age of the tallest person
    movq AGE_OFFSET(%rdi), %rdi

    movq $60, %rax
    syscall
