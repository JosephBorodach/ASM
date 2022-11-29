	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 12, 1
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ## -- Begin function main
LCPI0_0:
	.quad	0xc000000000000000              ## double -2
LCPI0_1:
	.quad	0x3fde147ae147ae14              ## double 0.46999999999999997
LCPI0_2:
	.quad	0xbff1eb851eb851ec              ## double -1.1200000000000001
LCPI0_3:
	.quad	0x3ff1eb851eb851ec              ## double 1.1200000000000001
LCPI0_4:
	.quad	0xbff0000000000000              ## double -1
LCPI0_5:
	.quad	0x3ff0000000000000              ## double 1
LCPI0_6:
	.quad	0x4000000000000000              ## double 2
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$416, %rsp                      ## imm = 0x1A0
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -244(%rbp)
	movl	%edi, -248(%rbp)
	movq	%rsi, -256(%rbp)
	cmpl	$3, -248(%rbp)
	je	LBB0_2
## %bb.1:
	movl	$-1, -244(%rbp)
	jmp	LBB0_58
LBB0_2:
	movq	-256(%rbp), %rax
	movq	8(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	leaq	-264(%rbp), %rdx
	movb	$0, %al
	callq	_sscanf
	movq	-256(%rbp), %rax
	movq	16(%rax), %rdi
	leaq	L_.str(%rip), %rsi
	leaq	-272(%rbp), %rdx
	movb	$0, %al
	callq	_sscanf
	movsd	LCPI0_0(%rip), %xmm0            ## xmm0 = mem[0],zero
	ucomisd	-264(%rbp), %xmm0
	ja	LBB0_6
## %bb.3:
	movsd	LCPI0_1(%rip), %xmm1            ## xmm1 = mem[0],zero
	movsd	-264(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	ja	LBB0_6
## %bb.4:
	movsd	LCPI0_2(%rip), %xmm0            ## xmm0 = mem[0],zero
	ucomisd	-272(%rbp), %xmm0
	ja	LBB0_6
## %bb.5:
	movsd	LCPI0_3(%rip), %xmm1            ## xmm1 = mem[0],zero
	movsd	-272(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	LBB0_7
LBB0_6:
	movl	$-1, -244(%rbp)
	jmp	LBB0_58
LBB0_7:
	movb	$0, -16(%rbp)
	movb	$0, -96(%rbp)
	movl	$0, -292(%rbp)
LBB0_8:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_22 Depth 2
                                        ##       Child Loop BB0_26 Depth 3
                                        ##     Child Loop BB0_41 Depth 2
	cmpl	$2, -292(%rbp)
	jge	LBB0_54
## %bb.9:                               ##   in Loop: Header=BB0_8 Depth=1
	cmpl	$0, -292(%rbp)
	jne	LBB0_11
## %bb.10:                              ##   in Loop: Header=BB0_8 Depth=1
	movsd	-264(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movsd	%xmm0, -304(%rbp)
	jmp	LBB0_12
LBB0_11:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	-272(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movsd	%xmm0, -304(%rbp)
LBB0_12:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jbe	LBB0_17
## %bb.13:                              ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_5(%rip), %xmm1            ## xmm1 = mem[0],zero
	movb	$48, -313(%rbp)
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	LBB0_15
## %bb.14:                              ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_5(%rip), %xmm1            ## xmm1 = mem[0],zero
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -312(%rbp)
	jmp	LBB0_16
LBB0_15:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movsd	%xmm0, -312(%rbp)
LBB0_16:                                ##   in Loop: Header=BB0_8 Depth=1
	jmp	LBB0_21
LBB0_17:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_4(%rip), %xmm1            ## xmm1 = mem[0],zero
	movb	$49, -313(%rbp)
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	LBB0_19
## %bb.18:                              ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_5(%rip), %xmm0            ## xmm0 = mem[0],zero
	addsd	-304(%rbp), %xmm0
	movsd	%xmm0, -312(%rbp)
	jmp	LBB0_20
LBB0_19:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_5(%rip), %xmm1            ## xmm1 = mem[0],zero
	movsd	LCPI0_4(%rip), %xmm0            ## xmm0 = mem[0],zero
	mulsd	-304(%rbp), %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -312(%rbp)
LBB0_20:                                ##   in Loop: Header=BB0_8 Depth=1
	jmp	LBB0_21
LBB0_21:                                ##   in Loop: Header=BB0_8 Depth=1
	movb	$0, -176(%rbp)
	movl	$0, -320(%rbp)
LBB0_22:                                ##   Parent Loop BB0_8 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB0_26 Depth 3
	cmpl	$64, -320(%rbp)
	jge	LBB0_34
## %bb.23:                              ##   in Loop: Header=BB0_22 Depth=2
	cmpl	$6, -320(%rbp)
	jge	LBB0_25
## %bb.24:                              ##   in Loop: Header=BB0_22 Depth=2
	movb	-313(%rbp), %cl
	movslq	-320(%rbp), %rax
	movb	%cl, -240(%rbp,%rax)
	jmp	LBB0_32
LBB0_25:                                ##   in Loop: Header=BB0_22 Depth=2
	movsd	LCPI0_6(%rip), %xmm0            ## xmm0 = mem[0],zero
	movsd	%xmm0, -328(%rbp)
	movl	$1, -332(%rbp)
	movl	-320(%rbp), %eax
	subl	$5, %eax
	movl	%eax, -336(%rbp)
LBB0_26:                                ##   Parent Loop BB0_8 Depth=1
                                        ##     Parent Loop BB0_22 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	-332(%rbp), %eax
	cmpl	-336(%rbp), %eax
	jge	LBB0_29
## %bb.27:                              ##   in Loop: Header=BB0_26 Depth=3
	movsd	LCPI0_6(%rip), %xmm0            ## xmm0 = mem[0],zero
	mulsd	-328(%rbp), %xmm0
	movsd	%xmm0, -328(%rbp)
## %bb.28:                              ##   in Loop: Header=BB0_26 Depth=3
	movl	-332(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -332(%rbp)
	jmp	LBB0_26
LBB0_29:                                ##   in Loop: Header=BB0_22 Depth=2
	movsd	LCPI0_5(%rip), %xmm0            ## xmm0 = mem[0],zero
	divsd	-328(%rbp), %xmm0
	movsd	%xmm0, -344(%rbp)
	movb	$48, -313(%rbp)
	movsd	-312(%rbp), %xmm0               ## xmm0 = mem[0],zero
	subsd	-344(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jb	LBB0_31
## %bb.30:                              ##   in Loop: Header=BB0_22 Depth=2
	movsd	-344(%rbp), %xmm1               ## xmm1 = mem[0],zero
	movsd	-312(%rbp), %xmm0               ## xmm0 = mem[0],zero
	subsd	%xmm1, %xmm0
	movsd	%xmm0, -312(%rbp)
	movb	$49, -313(%rbp)
LBB0_31:                                ##   in Loop: Header=BB0_22 Depth=2
	movb	-313(%rbp), %cl
	movslq	-320(%rbp), %rax
	movb	%cl, -240(%rbp,%rax)
LBB0_32:                                ##   in Loop: Header=BB0_22 Depth=2
	jmp	LBB0_33
LBB0_33:                                ##   in Loop: Header=BB0_22 Depth=2
	movl	-320(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -320(%rbp)
	jmp	LBB0_22
LBB0_34:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_4(%rip), %xmm0            ## xmm0 = mem[0],zero
	ucomisd	-304(%rbp), %xmm0
	jbe	LBB0_36
## %bb.35:                              ##   in Loop: Header=BB0_8 Depth=1
	movb	$48, -235(%rbp)
	jmp	LBB0_39
LBB0_36:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	LCPI0_5(%rip), %xmm1            ## xmm1 = mem[0],zero
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jb	LBB0_38
## %bb.37:                              ##   in Loop: Header=BB0_8 Depth=1
	movb	$49, -235(%rbp)
LBB0_38:                                ##   in Loop: Header=BB0_8 Depth=1
	jmp	LBB0_39
LBB0_39:                                ##   in Loop: Header=BB0_8 Depth=1
	cmpl	$0, -292(%rbp)
	jne	LBB0_45
## %bb.40:                              ##   in Loop: Header=BB0_8 Depth=1
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movsd	%xmm0, -264(%rbp)
	movl	$0, -348(%rbp)
LBB0_41:                                ##   Parent Loop BB0_8 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$64, -348(%rbp)
	jge	LBB0_44
## %bb.42:                              ##   in Loop: Header=BB0_41 Depth=2
	movslq	-348(%rbp), %rax
	movb	-240(%rbp,%rax), %cl
	movslq	-348(%rbp), %rax
	movb	%cl, -80(%rbp,%rax)
## %bb.43:                              ##   in Loop: Header=BB0_41 Depth=2
	movl	-348(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -348(%rbp)
	jmp	LBB0_41
LBB0_44:                                ##   in Loop: Header=BB0_8 Depth=1
	leaq	-80(%rbp), %rdi
	leaq	-360(%rbp), %rsi
	movl	$2, %edx
	callq	_strtoll
	movq	%rax, -280(%rbp)
LBB0_45:                                ##   in Loop: Header=BB0_8 Depth=1
	movsd	-272(%rbp), %xmm0               ## xmm0 = mem[0],zero
	ucomisd	-264(%rbp), %xmm0
	jne	LBB0_46
	jp	LBB0_46
	jmp	LBB0_47
LBB0_46:                                ##   in Loop: Header=BB0_8 Depth=1
	cmpl	$1, -292(%rbp)
	jne	LBB0_52
LBB0_47:
	movsd	-304(%rbp), %xmm0               ## xmm0 = mem[0],zero
	movsd	%xmm0, -272(%rbp)
	movl	$0, -364(%rbp)
LBB0_48:                                ## =>This Inner Loop Header: Depth=1
	cmpl	$64, -364(%rbp)
	jge	LBB0_51
## %bb.49:                              ##   in Loop: Header=BB0_48 Depth=1
	movslq	-364(%rbp), %rax
	movb	-240(%rbp,%rax), %cl
	movslq	-364(%rbp), %rax
	movb	%cl, -160(%rbp,%rax)
## %bb.50:                              ##   in Loop: Header=BB0_48 Depth=1
	movl	-364(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -364(%rbp)
	jmp	LBB0_48
LBB0_51:
	leaq	-160(%rbp), %rdi
	leaq	-376(%rbp), %rsi
	movl	$2, %edx
	callq	_strtoll
	movq	%rax, -288(%rbp)
	jmp	LBB0_54
LBB0_52:                                ##   in Loop: Header=BB0_8 Depth=1
	jmp	LBB0_53
LBB0_53:                                ##   in Loop: Header=BB0_8 Depth=1
	movl	-292(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -292(%rbp)
	jmp	LBB0_8
LBB0_54:
	movq	-280(%rbp), %rsi
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	-288(%rbp), %rsi
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	$0, -384(%rbp)
	movq	$0, -392(%rbp)
	movl	$0, -396(%rbp)
	movq	-384(%rbp), %rsi
	imulq	-384(%rbp), %rsi
	movq	-392(%rbp), %rax
	imulq	-392(%rbp), %rax
	addq	%rax, %rsi
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
LBB0_55:                                ## =>This Inner Loop Header: Depth=1
	movq	-384(%rbp), %rax
	imulq	-384(%rbp), %rax
	movq	-392(%rbp), %rcx
	imulq	-392(%rbp), %rcx
	addq	%rcx, %rax
	cmpq	$4, %rax
	setle	%al
	andb	$1, %al
	movzbl	%al, %eax
	cmpl	$1000, -396(%rbp)               ## imm = 0x3E8
	setl	%cl
	andb	$1, %cl
	movzbl	%cl, %ecx
	andl	%ecx, %eax
	cmpl	$0, %eax
	je	LBB0_57
## %bb.56:                              ##   in Loop: Header=BB0_55 Depth=1
	movq	-384(%rbp), %rsi
	imulq	-384(%rbp), %rsi
	movq	-392(%rbp), %rax
	imulq	-392(%rbp), %rax
	addq	%rax, %rsi
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	-384(%rbp), %rax
	imulq	-384(%rbp), %rax
	movq	-392(%rbp), %rcx
	imulq	-392(%rbp), %rcx
	subq	%rcx, %rax
	addq	-280(%rbp), %rax
	movq	%rax, -408(%rbp)
	movq	-384(%rbp), %rax
	shlq	$1, %rax
	imulq	-392(%rbp), %rax
	addq	-288(%rbp), %rax
	movq	%rax, -392(%rbp)
	movq	-392(%rbp), %rsi
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	-408(%rbp), %rax
	movq	%rax, -384(%rbp)
	movq	-384(%rbp), %rsi
	leaq	L_.str.5(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	-396(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -396(%rbp)
	jmp	LBB0_55
LBB0_57:
	movl	-396(%rbp), %esi
	leaq	L_.str.6(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -244(%rbp)
LBB0_58:
	movl	-244(%rbp), %eax
	movl	%eax, -412(%rbp)                ## 4-byte Spill
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_60
## %bb.59:
	movl	-412(%rbp), %eax                ## 4-byte Reload
	addq	$416, %rsp                      ## imm = 0x1A0
	popq	%rbp
	retq
LBB0_60:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%lf"

L_.str.1:                               ## @.str.1
	.asciz	"a: %ld\n"

L_.str.2:                               ## @.str.2
	.asciz	"b: %ld\n"

L_.str.3:                               ## @.str.3
	.asciz	"(xx * xx + yy * yy): %ld\n"

L_.str.4:                               ## @.str.4
	.asciz	"yy: %ld\n"

L_.str.5:                               ## @.str.5
	.asciz	"xx: %ld\n"

L_.str.6:                               ## @.str.6
	.asciz	"i: %d\n"

.subsections_via_symbols
