.data
.text
.globl test
test:
    movq $1, %r9
    mul %r9
    ret
