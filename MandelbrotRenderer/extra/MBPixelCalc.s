.global _MBPixelCalc
// take decimals, but flip order, multiply, flip back
_MBPixelCalc:
	movq $0, %r8 // set iteration to 0
_iterate:
// whats holding value- r8 i guess
	cmpq $1000, %r8 // see if less than 1000
	jge _complete // return if so
	//new x
	addq $0, %r10
	// new y
	// do math calcs
	// get top 6 bits, bit shift left 58
	// copy x to r19
	movq %rdi, %r15 // d
	sar $58, %r15 // keep highest bit to keep two's compliment active
	// put it in 32 bit register to keep overflow
	// now r15 has whole number part of a
	// get square of a
	movq %r15, %r14
    	imul %r14
		//r14d now has square of whole of a
	//do same for b
	movq %rsi, %r13 //d
	sar $58, %r13d //keep highest bit to keep twos compliment active
	//put it in 32 bit register to keep overflow
	//now r15 has whole number part of a
	//get square of a
	movq %r13d, %r12d
    	imul %r12d
		//r12d now has square of whole of a
	addq %r14d, %r9
	addq %r12d, %r9

// _iterate:
// 1) If r8 less than 1000, else move to done
//      if it's not less, move to complete. Otherwise, continue.
// 2) Add one to counter each time
// 3) x * x
//      a) move the value of x into r13
//      b) r13 *= r10 == which multiplies x by itself
//      c) Do the same for decimals:
// 4) y * y
//      a) move the value of y into rdx
//      b) rdx *= r10 == which multiplies x by itself
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

	// square decimals and add
	movq %rdi, %r11
	shl $6, %r11
	rol $29 %r11
	movq %r11, %rdx
	imul %rdx
	movq %rsi, %r10
	shl $6, %r10
	rol $29 %r10
	movq %r10, %rcx
	imul %rcx
	//both decimals are squared
	//rotate back to decimal form
	rol $29 %rdx
	rol $29 %rcx
	addq %rcx, %rdx //rdx has binary additions
	//see if its greater
	cmpq $4, %r9 //see if greater than 4
	jg _complete
	movq %rsi, %r14 //put it in 32 bit register to keep overflow
	sar %r15, 58 //keep highest bit to keep twos compliment active
	//now r15 has whole number part of a
	addq $0, %r11
	movq %rsi, %rax
    	imul %rax
	movq %rax, %r8
	movq %rdi, %rax
    	imul %rax
	subq %r8, %rax
	addq %rdi, %rax
	cmpq $4, %r9 //see if greater than 4
	jg _complete
	addq $1, %r8 // add one to counter each time
	cmpq $1000, %r8 //see if less than 1000
	jge _complete //if less than 2 loop again
	jmp _iterate
_complete:
	movq %r8, %rax //put iterations in return value
	ret //return