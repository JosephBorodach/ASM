.data
.text
.globl test
test:
    xorq %rax, %rax
    xorq %rdx, %rdx
    movq %rdi, %rax
    mul %rsi
    ret
