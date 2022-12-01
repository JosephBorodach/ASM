.section .data
.section .text
.global _MBPixelCalc
_MBPixelCalc:
    pushq %r8; pushq %r9; pushq %r10; pushq %r11; pushq %r12; pushq %r13; pushq %r14
    movq $0, %r8; movq $0, %r9; movq $0, %r10; movq $0, %r11; movq $0, %r12; movq $0, %r13; movq $0, %r14
    movq $0, %rdx; movq $0, %rax;
    movq $1152921504606846976, %r9
_loop:
    ###############################################
    # %r10 == holder for x * x
    # %r11 == holder for y * y
    # %r12 == the counter
    # %r13 == x0
    # %r14 == y0
    # %r8  == holder for (x * x) + (y * y)
    # %r9  == holder for the (2 * 2)
    # %rdi == 1st arg
    # %rsi == 2nd args
    # %15 is free
    # %rbx is free
    ###############################################

    ###############################################
    # counter <= 1000
    cmpq $1000, %r12
    jge _done
    ###############################################

    ###############################################
    movq $0, %rax
    movq $0, %rdx
    ###############################################

    ###############################################
    # (x * x): Move x into %rax and square %rax
    # Remember: %r13 is x, so don't mess with it just yet!
    mov %r13, %rax
    imulq %r13
    ###############################################

    ###############################################
    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to con
    cmpq $0, %rdx
    jne .con
    movq %rax, %rdx      # Place %rax into %rdx

    # Move (x * x) into %r10 - the temporary holder
    # Bit shift 6 to get the correct number
    .con:
    salq $6, %rdx
    movq %rdx, %r10
    ###############################################

    ###############################################
    # Keep them fresh and set to zero
    movq $0, %rax
    movq $0, %rdx
    ###############################################

    ###############################################
    # (y * y): Move y into %rax and square %rax
    mov %r14, %rax
    imulq %r14

    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to conn
    cmpq $0, %rdx
    jne .conn
    movq %rax, %rdx      # Place %rax into %rdx

    # Bit shift 6 to get the correct number
    # Move (y * y) into %r11 - the temporary holder
    .conn:
    salq $6, %rdx
    mov %rdx, %r11
    ###############################################

    ###############################################
    movq $0, %rax
    movq $0, %rdx
    movq $0, %r8
    ###############################################

    ###############################################
    # Make %r8 equal to (x*x + y*y)
    movq %r10, %r8      # %r8 = x*x
    addq %r11, %r8      # %r8 += y*y
    # Keep %r10 & %r11, becuase they will be need for the equation (x*x - y*y + x0) later
    ###############################################

    ###############################################
    # Check if (x*x + y*y) < 1152921504606846976; if this fails, end the program
    # %r8 holds (x*x + y*y)
    # %r9 holds 1152921504606846976
    cmpq %r9, %r8
    jge _done
    ###############################################

    ###############################################
    # No need to keep %r8
    movq $0, %r8
    ###############################################

    ###############################################
    # %r10 will become the temp holder for (x*x - y*y + x0),
    # which will ultimately be placed into x
    # since %r10 alreay contains (x*x)
    subq %r11, %r10     # Subtract (x*x) by (y*y)
    addq %rdi, %r10     # Add arg x
    ###############################################

    ###############################################
    # Do not touch %r10, it holds (x*x - y*y + x0)
    # Zero out %r11, (y*y) is no longer needed
    movq $0, %r11
    ###############################################

    ###############################################
    # Make %r14 (aka y) equal to (2 * x * y + y0)
    addq %r14, %r14     # Multiply y by 2 by adding %r14 to itself
    imul %r13, %r14     # Multiply y by x
    addq %rsi, %r14     # Add arg y to y
    ###############################################

    ###############################################
    # Set %r13 equal to xtemp, which holds (x*x - y*y + x0)
    # Remember: %r13 & %r14 holds x & y, so don't touch them
    mov %r10, %r13      # x = xtemp
    ###############################################

    ###############################################
    movq $0, %r10
    ###############################################

    ###############################################
    # Increment the counter
    addq $1, %r12
    ###############################################

    ###############################################
    # Continue looping
    jmp _loop
    ###############################################
_done:
    movq $0, %rax      # Zero out %rax
    movq %r12, %rax    # Move the number of iterations into %rax
    popq %r8; popq %r9; popq %r10; popq %r11; popq %r12; popq %r13; popq %r14;
    ret
