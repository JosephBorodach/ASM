.data
.text
.globl test
test:
    xorq %rax, %rax
    movq $1, %rdx
    movq %rdi, %rax
    mul %rsi
    ret
