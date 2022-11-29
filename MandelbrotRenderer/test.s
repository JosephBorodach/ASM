.data
.text
.globl test
test:
    movq %rdi, %rax
    mul %rsi
    ret
