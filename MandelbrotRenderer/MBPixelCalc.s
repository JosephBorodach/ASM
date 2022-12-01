//.section .data
//.section .text
.global _MBPixelCalc
_MBPixelCalc:
    pushq %r8; pushq %r9; pushq %r10; pushq %r11; pushq %r12; pushq %r13; pushq %r14; pushq %r15
    pushq %rdx; pushq %rbx; movq $0, %r8; movq $0, %r9; movq $0, %r10; movq $0, %r11; movq $0, %r12; movq $0, %r13
    movq $0, %r14; movq $0, %r15; movq $0, %rdx; movq $0, %rax; movq $576460752303423488, %rbx;
_loop:
    cmpq $1000, %r12
    jge _done

    mov %r13, %rax
    imulq %r13

    movq $0, %r13

    cmpq $0, %rdx
    je .L1
    jne .L2
    .L1:
        movq %rax, %rdx

    .L2:
    shl $6, %rdx
    movq %rdx, %r10

    movq $0, %rax
    movq $0, %rdx

    mov %r14, %rax
    imulq %r14

    cmpq $0, %rdx
    je .L3
    jne .L4
   .L3:
        movq %rax, %rdx

    .L4:
    shl $6, %rdx
    mov %rdx, %r11

    movq $0, %rax
    movq $0, %rdx

    movq %r10, %rdx
    addq %r11, %rdx

    cmpq %rbx, %rdx
    jge _done

    mov %r10, %r15
    subq %r11, %r15
    addq %rdi, %r15

    imul %r13, %r14
    imul $2, %r14
    addq %rsi, %r14

    mov %r15, %r13

    addq $1, %r12

    cmpq $1000, %r12
    jge _done
    jmp _loop
_done:
    movq %r12, %rax
    popq %r8; popq %r9; popq %r10; popq %r11
    popq %r12; popq %r13; popq %r14; popq %r15
    popq %rdx; popq %rbx
    ret
