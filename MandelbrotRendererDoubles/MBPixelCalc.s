#.section .data
#.section .text
.global MBPixelCalc
MBPixelCalc:
    ###############################################
    # All registers a caller saved, so we don't need to deal with the stack!
    xorpd %xmm0, %xmm0; xorpd %xmm1, %xmm1; xorpd %xmm2, %xmm2; xorpd %xmm3, %xmm3; xorpd %xmm4, %xmm4; xorpd %xmm5, %xmm5
    xorpd %xmm6, %xmm6; xorpd %xmm7, %xmm7; xorpd %xmm8, %xmm8; xorpd %xmm9, %xmm9; xorpd %xmm10, %xmm10; xor %eax, %eax;
    mov $1000, %eax
    movd %eax, %xmm6
    xor %eax, %eax

    mov $1, %eax
    movd %eax, %xmm7
    xor %eax, %eax

    mov $4, %eax
    movd %eax, %xmm8
    xor %eax, %eax

    movd %rdi, %xmm9
    movd %rsi, %xmm10
    ###############################################
_loop:
    ###############################################
    # %rdi == 1st arg / x0
    # %rsi == 2nd args / y0
    # %eax
    # %exs
    # %edx
    # %xmm0 == counter / number of iterations
    # %xmm1 == x
    # %xmm2 == y
    # %xmm3 == holder for x * x
    # %xmm4 == holder for y * y
    # %xmm5 == holder for (x * x) + (y * y)
    # %xmm6 == 1000
    # %xmm7 == Incremeting 1
    # %xmm8 == 4, aka (2*2)
    # %xmm9 == x0
    # %xmm10 == y0
    # %xmm11 ==
    # %xmm12 ==
    # %xmm13 ==
    # %xmm14 ==
    # %xmm15 ==
    ###############################################

    ###############################################
    # counter <= 1000
    ucomisd %xmm6, %xmm0
    jge _done
    ###############################################

    ###############################################
    movq $0, %rax
    movq $0, %rdx
    ###############################################

    ###############################################
    # (x * x): Move x into %rax and square %rax
    # Remember: %xmm1 is x, so don't mess with it just yet!
    movq %xmm1, %rax
    mulq %rax
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
    # Do we still need to bit shift?
    # salq $6, %rdx
    movq %rdx, %xmm3
    ###############################################

    ###############################################
    # Keep them fresh and set to zero
    movq $0, %rax
    movq $0, %rdx
    ###############################################

    ###############################################
    # (y * y): Move y (%xmm2) into %rax and square %rax
    movq %xmm2, %rax
    imulq %rax

    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to conn
    cmpq $0, %rdx
    jne .conn
    movq %rax, %rdx      # Place %rax into %rdx

    # Bit shift 6 to get the correct number
    # Move (y * y) into %xmm4 - the temporary holder
    .conn:
    # Do we still need to bit shift?
    # salq $6, %rdx
    movq %rdx, %xmm4
    ###############################################

    ###############################################
    movq $0, %rax
    movq $0, %rdx
    xorpd %xmm5, %xmm5
    ###############################################

    ###############################################
    # Make %xmm5 equal to (x*x + y*y)
    movapd %xmm3, %xmm5        # %xmm5 = x*x
    addpd %xmm4, %xmm5         # %xmm5 += y*y
    # Keep %xmm3 & %xmm4, becuase they will be need for the equation (x*x - y*y + x0) later
    ###############################################

    ###############################################
    # Check if (x*x + y*y) < (2 * 2); if this fails, end the program
    # %xmm5 == (x*x + y*y)
    # %xmm8 == (2*2)
    ucomisd %xmm8, %xmm5
    jge _done
    ###############################################

    ###############################################
    # No need to keep %xmm8
    xorpd %xmm8, %xmm8
    ###############################################

    ###############################################
    # %xmm3 will become the temp holder for (x*x - y*y + x0),
    # which will ultimately be placed into x
    # since %xmm3 alreay contains (x*x)
    subsd %xmm4, %xmm3      # Subtract (x*x) by (y*y)
    addpd %xmm9, %xmm3      # Add arg x
    ###############################################

    ###############################################
    # Do not touch %xmm3, it holds (x*x - y*y + x0)
    # Zero out %xmm4, (y*y) is no longer needed
    xorpd %xmm4, %xmm4
    ###############################################

    ###############################################
    # Make %xmm2 (aka y) equal to (2 * x * y + y0)
    addpd %xmm2, %xmm2      # Multiply y by 2 by adding %r14 to itself
    mulpd %xmm1, %xmm2      # Multiply y by x
    addpd %xmm10, %xmm2     # Add arg y to y
    ###############################################

    ###############################################
    # Set %xmm1 equal to xtemp, which holds (x*x - y*y + x0)
    # Remember: %xmm1 & %xmm2 holds x & y, so don't touch them
    movapd %xmm3, %xmm1      # x = xtemp
    ###############################################

    ###############################################
    xorpd %xmm3, %xmm3
    ###############################################

    ###############################################
    # Increment the counter
    addpd %xmm7, %xmm0
    ###############################################

    ###############################################
    # Continue looping
    jmp _loop
    ###############################################
_done:
    movq $0, %rax      # Zero out %rax
    movq %xmm0, %rax   # Move the number of iterations into %rax
    ret
