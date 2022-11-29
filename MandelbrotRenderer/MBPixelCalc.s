.data
.text
.globl _MBPixelCalc
// _MBPixelCalc:
//      Setting up all the variables and registers
// Goal: Get return values from _MBPixelCalc
// %eax is the return value from _MBPixelCalc
// Move %eax it to %rax, which is the default return register
// Args: rdi, rsi, rdx, rcx
// %rdi holds a
// %rsi holds b
// %r10 & %r11 are caller saved so we will use them for the x & y values
// Prepare values for 1000 iterations
// Save the relevant registers to the stack
// Set iteration, x, & y to 0
// We no longer need the return values
// So push them onto the stack, so their registers can be used
//
// _iterate:
// 1) If r8 less than 1000, else move to done
//      if it's not less, move to complete. Otherwise, continue.
// 2) Add one to counter each time
// 3) x * x
//      a)
//      a) move the value of x into rdi
//      b) rdi *= r10 == which multiplies x by itself
// 4) y * y
//      a) move the value of y into rsi
//      b) rsi *= r10 == which multiplies x by itself
// 5) (x * x + y * y)
//      %rdx = (x * x)
//      %rdx += (y * y)
// 6) (x * x + y * y) <= (2 * 2)
// 7) Calculations
//      a) int temp = (x * x) - (y * y) + x0;
//          1. Move (x * x) into %r15
//          2. Subtract %r15 by (y * y)
//          3. Add x0 to %r15
//      b) y = (2 * x * y) + y0; y is %r11
//          1. Multiply %r11 by x, which is %r10
//          2. Multiply %r11 by 2
//          3. Add y0, which is %r14, to %r11
//      c) x = temp;
//          1. Set %r10 to %r15
//
// _done:
// 1) Place iterations in return value
// 2) Pop the relevant values back off the stack
//
_MBPixelCalc:
    pushq %r8; pushq %r9
    pushq %r10; pushq %r11
    pushq %r12       // iterative variable
    pushq %r13       // x * x
    pushq %r14       // y * y
    pushq %r15       // temp variable
    pushq %rdx
    movq $0, %r8     // set x whole = 0
    movq $0, %r9     // set x decimals = 0
    movq $0, %r10    // set y whole = 0
    movq $0, %r11    // set y decimals = 0
    movq $0, %r12    // int i = 0
    // rdx is free
_loop:
    cmpq $1000, %r12 // #1
    jge _done

    mov %r10, %r13   // #3a
    imul %r10, %r13  // #3b

    mov %r11, %r14   // #4a
    imul %r11, %r14  // #4b

    mov %r13, %rdx   // #5
    addq %r14, %rdx

    // How do I do <=?
    cmpq $4, %rdx    // #6
    jge _done

    // 7) Calculations
    // a) int temp = (x * x) - (y * y) + x0; %r15 is int temp
    mov %r13, %r15   // #7a1. Move (x * x) into %r15
    subq %r14, %r15  // #7a2. Subtract %r15 by (y * y)
    addq %rdi, %r15  // #7a3. Add x0 to %r15

    // b) y = (2 * x * y) + y0; y is %r11;
    imul %r10, %r11   // #7b1. Multiply %r11 by x, which is %r10
    imul $2, %r11     // #7b2. Multiply %r11 by 2
    addq %rsi, %r11   // #7b3. Add y0, which is %r14, to %r11

    // c) x = temp;
    mov %r15, %r10    // 7c1. Set %r10 to %r15

    addq $1, %r12    // #2

    cmpq $1000, %r12 // #1
    jge _done
    jmp _loop
_done:
    movq %r12, %rax
    popq %r8; popq %r9; popq %r10; popq %r11
    popq %r12; popq %r13; popq %r14; popq %r15
    popq %rdx
    ret