.section .data
.section .text
.global MBPixelCalc
MBPixelCalc:
    pushq %r8; pushq %r9; pushq %r10; pushq %r11; pushq %r12; pushq %r13; pushq %r14; pushq %r15
    pushq %rdx; pushq %rbx; movq $0, %r8; movq $0, %r9; movq $0, %r10; movq $0, %r11; movq $0, %r12; movq $0, %r13
    movq $0, %r14; movq $0, %r15; movq $0, %rdx; movq $0, %rax; movq $576460752303423488, %rbx;
_loop:
    # Definitions:
    # %r13 == x
    # %r14 == y
    # %r10 == holder for x * x
    # %r11 == holder for y * y
    cmpq $1000, %r12
    jge _done

    # Move x into %rax and square %rax
    mov %r13, %rax
    imulq %r13

    # movq $0, %r13

    cmpq $0, %rdx
    je .L1
    jne .L2
    .L1:
        movq %rax, %rdx

    # Move (x * x) into %r10 - the temporary holder
    .L2:
    shl $6, %rdx
    movq %rdx, %r10

    movq $0, %rax
    movq $0, %rdx

    # Move y into %rax and square %rax
    mov %r14, %rax
    imulq %r14

    cmpq $0, %rdx
    je .L3
    jne .L4
   .L3:
        movq %rax, %rdx

    # Move (y * y) into %r11 - the temporary holder
    .L4:
    shl $6, %rdx
    mov %rdx, %r11

    movq $0, %rax
    movq $0, %rdx

    movq %r10, %rdx
    addq %r11, %rdx

    # Check if (x*x + y*y) <= 576460752303423488; if this fails, end the program
    cmpq %rbx, %rdx
    jge _done

    # %r15 is the temp holder for (x*x - y*y + x0),
    # which will ultimately be placed into x
    mov %r10, %r15      # Move (x*x) into %r15
    subq %r11, %r15     # Subtract (x*x) by (y*y)
    addq %rdi, %r15     # Add arg x

    # y = 2*x*y + y0
    imul %r13, %r14     # Add x to y
    imul $2, %r14       # Multiply y by 2
    addq %rsi, %r14     # Add arg y to y

    mov %r15, %r13      # x = xtemp

    addq $1, %r12

    jmp _loop
_done:
    movq $0, %rax      # Zero out %rax
    movq %r12, %rax    # Move the number of iterations into %rax
    popq %r8; popq %r9; popq %r10; popq %r11
    popq %r12; popq %r13; popq %r14; popq %r15
    popq %rdx; popq %rbx
    ret
