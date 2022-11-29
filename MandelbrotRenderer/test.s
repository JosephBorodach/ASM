.data
.text
.globl _test
_test:
    xorq %rax, %rax
    xorq %rdx, %rdx
    movq %rdi, %rax
    mul %rsi
    ret
