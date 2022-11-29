.data
.text
.globl MBPixelCalc
MBPixelCalc:
    pushq %r8; pushq %r9
    pushq %r10; pushq %r11
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
    pushq %rdx
    movq $0, %r8
    movq $0, %r9
    movq $0, %r10
    movq $0, %r11
    movq $0, %r12
_loop:
    cmpq $1000, %r12
    jge _done

    mov %r10, %r13
    imul %r10, %r13

    mov %r11, %r14
    imul %r11, %r14

    mov %r13, %rdx
    addq %r14, %rdx

    cmpq $4, %rdx
    jge _done

    mov %r13, %r15
    subq %r14, %r15
    addq %rdi, %r15

    imul %r10, %r11
    imul $2, %r11
    addq %rsi, %r11

    mov %r15, %r10

    addq $1, %r12

    cmpq $1000, %r12
    jge _done
    jmp _loop
_done:
    movq %r12, %rax
    popq %r8; popq %r9; popq %r10; popq %r11
    popq %r12; popq %r13; popq %r14; popq %r15
    popq %rdx
    ret
