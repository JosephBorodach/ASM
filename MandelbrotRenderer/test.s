.data
.text
.globl test
test:
    xorq %r12, %r12
    xorq %r13, %r13
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %rcx, %rcx
    xorq %rcx, %rcx
    xorq %rsp, %rsp
    xorq %r8, %r8
    xorq %r9, %r9
    xorq %rax, %rax
    xorq %rax, %rax
    movq $1, %rdx
    movq %rdi, %rax
    mul %rsi
    ret
