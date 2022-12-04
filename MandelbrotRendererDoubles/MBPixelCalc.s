.section .data
.section .text
.global _MBPixelCalc
_MBPixelCalc:
    ###############################################
    # All registers a caller saved, so we don't need to deal with the stack!
    xorpd %xmm0, %xmm0; xorpd %xmm1, %xmm1; xorpd %xmm2, %xmm2; xorpd %xmm3, %xmm3; xorpd %xmm4, %xmm4; xorpd %xmm5, %xmm5;
    ###############################################
_loop:
    ###############################################
    # %rdi == 1st arg / x0
    # %rsi == 2nd args / y0
    # %xmm0 == counter / number of iterations
    # %xmm1 == x
    # %xmm2 == y
    # %xmm3 == holder for x * x
    # %xmm4 == holder for y * y
    # %xmm5 == holder for (x * x) + (y * y)
    # %xmm6 ==
    # %xmm7 ==
    # %xmm8 ==
    # %xmm9 ==
    # %xmm10 ==
    # %xmm11 ==
    # %xmm12 ==
    # %xmm13 ==
    # %xmm14 ==
    # %xmm15 ==
    ###############################################

    ###############################################
    # counter <= 1000
    cmpq $1000, %xmm0
    jge _done
    ###############################################

    ###############################################
    movq $0, %rax
    movq $0, %rdx
    ###############################################

    ###############################################
    # (x * x): Move x into %rax and square %rax
    # Remember: %xmm1 is x, so don't mess with it just yet!
    mov %xmm1, %rax
    imulq %xmm1
    ret

    ###############################################

    ###############################################
    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to con
    cmpq $0, %rdx
    jne .con
    movq %rax, %rdx      # Place %rax into %rdx

    # Move (x * x) into %xmm3 - the temporary holder
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
    # Check if (x*x + y*y) < (2 * 2); if this fails, end the program
    # %r8 holds (x*x + y*y)
    cmpq $4, %r8
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
    addq $1, %xmm0
    ###############################################

    ###############################################
    # Continue looping
    jmp _loop
    ###############################################
_done:
    movq $0, %rax      # Zero out %rax
    movq %xmm0, %rax   # Move the number of iterations into %rax
    ret
