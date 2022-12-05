#.section .data
#.section .text
.global MBPixelCalc
MBPixelCalc:
    ###############################################
    # All registers a caller saved, so we don't need to deal with the stack!
    xorpd %xmm2, %xmm2; xorpd %xmm3, %xmm3; xorpd %xmm4, %xmm4; xorpd %xmm5, %xmm5
    xorpd %xmm6, %xmm6; xorpd %xmm7, %xmm7; xorpd %xmm8, %xmm8; xorpd %xmm9, %xmm9;
    xorpd %xmm10, %xmm10; xorpd %xmm11, %xmm11
    xor %rax, %rax
    xor %rbx, %rbx
    ###############################################

    ###############################################
    # Move x0 into xmm9
    movapd %xmm0, %xmm9

    # Move y0 into xmm10
    movapd %xmm1, %xmm10
    ###############################################

    ###############################################
    # Set xmm0 & xmm1 to 0, since they represent x & y
    #xorpd %xmm0, %xmm0;
    xorpd %xmm1, %xmm1;
    ###############################################

    ###############################################
    # Set %xmm6 == 1000.0
    xor %rax, %rax
    mov $1000.0, %rax
    movd %rax, %xmm6
    ###############################################

    ###############################################
    # Set %xmm7 == 1.0
    # xor %rax, %rax
    # mov $1.0, %rax
    # movd %rax, %xmm7
    ###############################################

    ###############################################
    xor %rax, %rax
    mov $4.0, %rax
    movd %rax, %xmm8
    ###############################################

    ###############################################
    xor %rax, %rax
    ###############################################

_loop:
    ###############################################
    # %xmm1 == x : Originally, 2nd args / y0
    # %xmm2 == y : Originally, 1st arg / x0
    # %xmm3 == holder for x * x
    # %xmm4 == holder for y * y
    # %xmm5 == holder for (x * x) + (y * y)
    #
    # Might not need!
    # %xmm6 == 1000
    # %xmm7 == Incremeting 1
    # %xmm8 == 4, aka (2*2)
    #
    #
    # %xmm9 == 1st arg / x0
    # %xmm10 == 2nd args / y0
    # %xmm11 == counter / number of iterations
    #
    # %rbx == counter / number of iterations
    #
    # %xmm12 ==
    # %xmm13 ==
    # %xmm14 ==
    # %xmm15 ==
    # %eax
    # %exs
    # %edx
    # %rdi
    # %rsi
    ###############################################

    ###############################################
    # counter <= 1000.0
    # xmm6 == 1000.0
    # ucomisd %xmm6, %xmm11
    cmpq $1000, %rbx
    jge _done
    ###############################################

    ###############################################
    xorpd %xmm3, %xmm3
    xorpd %xmm4, %xmm4
    ###############################################

    ###############################################
    # (x * x): Move x into %rax and square %xmm3
    # Remember: %xmm0 is x, so don't mess with it just yet!
    movapd %xmm0, %xmm3
    mulsd %xmm3, %xmm3
    ###############################################

    ###############################################
    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to con
    # cmpq $0, %rdx
    # jne .con
    # movq %rax, %rdx      # Place %rax into %rdx

    # Move (x * x) into %xmm3 - the temporary holder
    # Bit shift 6 to get the correct number
    # .con:
    # Do we still need to bit shift?
    # salq $6, %rdx
    # movq %rdx, %xmm3
    ###############################################

    ###############################################
    # Keep them fresh and set to zero
    # movq $0, %rax
    # movq $0, %rdx
    ###############################################

    ###############################################
    # (y * y): Move y (%xmm1) into %xmm4 and square %xmm4
    movq %xmm1, %xmm4
    mulsd %xmm4, %xmm4
    ###############################################

    ###############################################
    # Do the %rdx and %rax magic
    # place %rax into %rdx if rdx is zero
    # If %rdx is not zero, and this fails, then it will jump to conn
    # cmpq $0, %rdx
    # jne .conn
    # movq %rax, %rdx      # Place %rax into %rdx

    # Bit shift 6 to get the correct number
    # Move (y * y) into %xmm4 - the temporary holder
    # .conn:
    # Do we still need to bit shift?
    # salq $6, %rdx
    # movq %rdx, %xmm4
    ###############################################

    ###############################################
    # Make %xmm5 equal to (x*x + y*y)
    # Keep %xmm3 & %xmm4, becuase they will be need for the equation (x*x - y*y + x0) later
    xorpd %xmm5, %xmm5
    movapd %xmm3, %xmm5        # %xmm5 = x*x
    addpd %xmm4, %xmm5         # %xmm5 += y*y
    ###############################################

    ###############################################
    # Check if (x*x + y*y) < (2 * 2); if this fails, end the program
    # %xmm5 == (x*x + y*y)
    # %xmm8 == (2*2)
    ucomisd %xmm8, %xmm5
    jge _done
    ###############################################

    ###############################################
    # No need to keep %xmm5 == (x*x + y*y)
    xorpd %xmm5, %xmm5
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
    # Make %xmm1 (aka y) equal to (2 * x * y + y0)
    addpd %xmm1, %xmm1      # Multiply y by 2 by adding %xmm1 to itself
    mulpd %xmm0, %xmm1      # Multiply y by x
    addpd %xmm10, %xmm1     # Add arg y0 to y
    ###############################################

    ###############################################
    # Set %xmm0 equal to xtemp, which holds (x*x - y*y + x0)
    # Remember: %xmm0 & %xmm1 holds x & y, so don't touch them
    movapd %xmm3, %xmm0      # x = xtemp
    ###############################################

    ###############################################
    xorpd %xmm3, %xmm3
    ###############################################

    ###############################################
    # Increment the counter
    # addpd %xmm7, %xmm11
    add $1, %rbx
    ###############################################

    ###############################################
    # Continue looping
    jmp _loop
    ###############################################
_done:
    ###############################################
    # Since we are returning an int, the value must be return in %xmm0
    # Move the number of iterations into %xmm11
    # set %rax to 0
    # Then set it to xmm11
    xor %rax, %rax
    movq %rbx, %rax
    # movq %xmm11, %rax
    ret
