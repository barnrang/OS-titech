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
	pushl	%esi
	subl	$68, %esp
	.cfi_offset %esi, -12
	movl	$1, %eax
	movl	$15, %ecx
	movl	_xpos, %edx
	movl	_ypos, %esi
	movl	$1, (%esp)
	movl	%edx, 4(%esp)
	movl	%esi, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	movl	%ecx, -16(%ebp)         ## 4-byte Spill
	calll	_print
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	calll	_register_kbd_handler
	movl	%eax, -24(%ebp)         ## 4-byte Spill
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	calll	_cli
	cmpl	$-1, _key_code
	movl	%eax, -28(%ebp)         ## 4-byte Spill
	je	LBB0_5
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	_key_code, %eax
	movl	%eax, -8(%ebp)
	movl	$-1, _key_code
	calll	_sti
	cmpl	$16, -8(%ebp)
	movl	%eax, -32(%ebp)         ## 4-byte Spill
	jge	LBB0_4
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	$15, %eax
	movl	-8(%ebp), %ecx
	movl	_xpos, %edx
	movl	_ypos, %esi
	movl	%ecx, (%esp)
	movl	%edx, 4(%esp)
	movl	%esi, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	calll	_print
	movl	%eax, -40(%ebp)         ## 4-byte Spill
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	movl	_xpos, %eax
	addl	$5, %eax
	movl	%eax, _xpos
	jmp	LBB0_6
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	calll	_sti_and_halt
	movl	%eax, -44(%ebp)         ## 4-byte Spill
LBB0_6:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
	.cfi_endproc
                                        ## -- End function
	.globl	_kbd_handler            ## -- Begin function kbd_handler
	.p2align	4, 0x90
_kbd_handler:                           ## @kbd_handler
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$40, %esp
	movl	$32, %eax
	movl	$97, %ecx
	movl	$32, (%esp)
	movl	$97, 4(%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	movl	%ecx, -16(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$96, %ecx
	movl	$96, (%esp)
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	movl	%ecx, -24(%ebp)         ## 4-byte Spill
	calll	_in8
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	andl	$127, %eax
	movl	%eax, _key_code
	movl	-4(%ebp), %eax
	addl	$40, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_register_kbd_handler   ## -- Begin function register_kbd_handler
	.p2align	4, 0x90
_register_kbd_handler:                  ## @register_kbd_handler
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$56, %esp
	leal	_kbd_handler, %eax
	movl	$32256, %ecx            ## imm = 0x7E00
	movl	%ecx, -8(%ebp)
	movl	-8(%ebp), %ecx
	movl	%eax, (%ecx)
	calll	_sti
	movl	$33, %ecx
	movl	$249, %edx
	movl	$33, (%esp)
	movl	$249, 4(%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	movl	%ecx, -16(%ebp)         ## 4-byte Spill
	movl	%edx, -20(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$161, %ecx
	movl	$255, %edx
	movl	$161, (%esp)
	movl	$255, 4(%esp)
	movl	%eax, -24(%ebp)         ## 4-byte Spill
	movl	%ecx, -28(%ebp)         ## 4-byte Spill
	movl	%edx, -32(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	-4(%ebp), %ecx
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, %eax
	addl	$56, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_print                  ## -- Begin function print
	.p2align	4, 0x90
_print:                                 ## @print
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$40, %esp
	.cfi_offset %esi, -20
	.cfi_offset %edi, -16
	.cfi_offset %ebx, -12
	movl	20(%ebp), %eax
	movl	16(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	8(%ebp), %esi
	leal	_print.bitmaps, %edi
	movl	$655360, %ebx           ## imm = 0xA0000
	movl	%ebx, -24(%ebp)
	movl	8(%ebp), %ebx
	shll	$2, %ebx
	addl	%ebx, %edi
	movl	%edi, -28(%ebp)
	imull	$320, 16(%ebp), %edi    ## imm = 0x140
	addl	12(%ebp), %edi
	addl	-24(%ebp), %edi
	movl	%edi, -24(%ebp)
	movl	$0, -16(%ebp)
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, -40(%ebp)         ## 4-byte Spill
	movl	%edx, -44(%ebp)         ## 4-byte Spill
	movl	%esi, -48(%ebp)         ## 4-byte Spill
LBB3_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB3_3 Depth 2
	cmpl	$8, -16(%ebp)
	jge	LBB3_11
## %bb.2:                               ##   in Loop: Header=BB3_1 Depth=1
	movl	$0, -20(%ebp)
LBB3_3:                                 ##   Parent Loop BB3_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$4, -20(%ebp)
	jge	LBB3_9
## %bb.4:                               ##   in Loop: Header=BB3_3 Depth=2
	movl	$128, %eax
	movl	-28(%ebp), %ecx
	movl	-20(%ebp), %edx
	movb	(%ecx,%edx), %bl
	movb	%bl, -29(%ebp)
	movsbl	-29(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%ecx, -52(%ebp)         ## 4-byte Spill
	movl	%edx, %ecx
                                        ## kill: def %cl killed %ecx
	sarl	%cl, %eax
	movl	-52(%ebp), %edx         ## 4-byte Reload
	andl	%eax, %edx
	cmpl	$0, %edx
	je	LBB3_6
## %bb.5:                               ##   in Loop: Header=BB3_3 Depth=2
	movl	20(%ebp), %eax
	movb	%al, %cl
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	movb	%cl, (%eax,%edx)
	jmp	LBB3_7
LBB3_6:                                 ##   in Loop: Header=BB3_3 Depth=2
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %ecx
	movb	$0, (%eax,%ecx)
LBB3_7:                                 ##   in Loop: Header=BB3_3 Depth=2
	jmp	LBB3_8
LBB3_8:                                 ##   in Loop: Header=BB3_3 Depth=2
	movl	-20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -20(%ebp)
	jmp	LBB3_3
LBB3_9:                                 ##   in Loop: Header=BB3_1 Depth=1
	movl	-24(%ebp), %eax
	addl	$320, %eax              ## imm = 0x140
	movl	%eax, -24(%ebp)
## %bb.10:                              ##   in Loop: Header=BB3_1 Depth=1
	movl	-16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -16(%ebp)
	jmp	LBB3_1
LBB3_11:
	xorl	%eax, %eax
	addl	$40, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_in8                    ## -- Begin function in8
	.p2align	4, 0x90
_in8:                                   ## @in8
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	## InlineAsm Start
	movl	$0, %eax
	inb	%dx, %al
	## InlineAsm End
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_out8                   ## -- Begin function out8
	.p2align	4, 0x90
_out8:                                  ## @out8
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	pushl	%esi
	subl	$8, %esp
	.cfi_offset %esi, -12
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	8(%ebp), %edx
	movl	12(%ebp), %esi
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	movl	%esi, %eax
	## InlineAsm Start
	outb	%al, %dx
	## InlineAsm End
	xorl	%eax, %eax
	movl	%ecx, -12(%ebp)         ## 4-byte Spill
	addl	$8, %esp
	popl	%esi
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti                    ## -- Begin function sti
	.p2align	4, 0x90
_sti:                                   ## @sti
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_cli                    ## -- Begin function cli
	.p2align	4, 0x90
_cli:                                   ## @cli
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	cli
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_halt                   ## -- Begin function halt
	.p2align	4, 0x90
_halt:                                  ## @halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti_and_halt           ## -- Begin function sti_and_halt
	.p2align	4, 0x90
_sti_and_halt:                          ## @sti_and_halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__data
	.globl	_xpos                   ## @xpos
	.p2align	2
_xpos:
	.long	100                     ## 0x64

	.globl	_ypos                   ## @ypos
	.p2align	2
_ypos:
	.long	60                      ## 0x3c

	.globl	_key_code               ## @key_code
	.p2align	2
_key_code:
	.long	4294967295              ## 0xffffffff

_print.bitmaps:                         ## @print.bitmaps
	.ascii	"~\201\201~"
	.ascii	"\000A\377\001"
	.ascii	"G\211\221a"
	.ascii	"B\201\231f"
	.ascii	"8H\377\b"
	.ascii	"\372\221\221\215"
	.ascii	"}\211\211F"
	.ascii	"\303\214\260\300"
	.ascii	"f\231\231f"
	.ascii	"`\220\220\377"
	.ascii	"?\310\310?"
	.ascii	"\377\231\231f"
	.ascii	"~\201\201f"
	.ascii	"\377\201\303~"
	.ascii	"\377\231\231\231"
	.ascii	"\377\210\210\210"


.subsections_via_symbols
