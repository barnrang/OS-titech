.org 0x8200

	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14
	.globl	_boot2                  ## -- Begin function boot2
	.p2align	4, 0x90
_boot2:                                 ## @boot2
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$8, %esp
	movl	$655360, %eax           ## imm = 0xA0000
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	addl	$3200, %eax             ## imm = 0xC80
	movl	%eax, -8(%ebp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	$659200, %eax           ## imm = 0xA0F00
	cmpl	%eax, -8(%ebp)
	jae	LBB0_3
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-8(%ebp), %eax
	movl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, -8(%ebp)
	movb	$15, (%eax)
	jmp	LBB0_1
LBB0_3:
	calll	_halt
	addl	$8, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function halt
_halt:                                  ## @halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	jmp	LBB1_1
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	jmp	LBB1_1
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
