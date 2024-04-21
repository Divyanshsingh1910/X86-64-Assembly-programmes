.section .data
format:
	 .string "%d\n" 
str_0:
	 .string "bubbleSort started execution\n"

str_1:
	 .string "this should not be printed\n"

str_2:
	 .string "main execution started\n"

str_3:
	 .string "Sorted Array in Ascending Order:\n"

.section .text
	# Instruction number: 0
	

.globl main
.type main, @function
main: 
	
	# Instruction number: 59
	# 3AC: L_begin_func | L_begin_func | 12
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	# Instruction number: 60
	# 3AC: t_26 | str_alloc | "main execution started\n"
	lea str_2(%rip), %rax
	
	# Instruction number: 61
	# 3AC: push_param | t_26
	movq %rax, %rdi 
	movl $0, %eax
	# Instruction number: 62
	# 3AC: call | print
	call printf
	
	# Instruction number: 63
	# 3AC: data | mem_alloc | 20
	movq $20, %rdi
	call malloc 
    movq (%rax), %rbx
	movq %rax, -8(%rbp)
	# Instruction number: 64
	# 3AC: data | = 2 | mem_assign | 0
	movq -8(%rbp), %rax
	addq $0, %rax
	movl $2, %edi
	movl %edi, (%rax)
	
	# Instruction number: 65
	# 3AC: data | = 45 | mem_assign | 1
	movq -8(%rbp), %rax
	addq $4, %rax
	movl $45, %edi
	movl %edi, (%rax)
	
	# Instruction number: 66
	# 3AC: data | = 0 | mem_assign | 2
	movq -8(%rbp), %rax
	addq $8, %rax
	movl $0, %edi
	movl %edi, (%rax)
	
	# Instruction number: 67
	# 3AC: data | = 11 | mem_assign | 3
	movq -8(%rbp), %rax
	addq $12, %rax
	movl $11, %edi
	movl %edi, (%rax)
	
	# Instruction number: 68
	# 3AC: data | = 9 | mem_assign | 4
	movq -8(%rbp), %rax
	addq $16, %rax
	movl $9, %edi
	movl %edi, (%rax)
	
	# Instruction number: 73
	# 3AC: t_28 | str_alloc | 'Sorted Array in Ascending Order:\n'
	lea str_3(%rip), %rax
	
	# Instruction number: 74
	# 3AC: push_param | t_28
	movq %rax, %rdi 
	movl $0, %eax
	# Instruction number: 75
	# 3AC: call | print
	call printf
	
	# Instruction number: 76
	# 3AC: i | = | 0
	movl $0, %eax
	movl %eax, -12(%rbp)
	
	# Instruction number: 77
.L_12: 
	
	# Instruction number: 78
	# 3AC: i | = | 0
	movl $0, %eax
	movl %eax, -12(%rbp)
	
	# Instruction number: 79
	# 3AC: t_32 | = i | < | 5
	movl $0, %eax         #making zero just in case
	movl -12(%rbp), %eax
	cmpl $5, %eax
	setl %al
	movzbl %al, %eax
	movl %eax, %edi
	
	# Instruction number: 80
	# 3AC: L_14 | ifZ | t_32
	movl %edi, %eax
	cmpl $0, %eax
	je .L_14
	
	# Instruction number: 81
.L_13: 
	
	# Instruction number: 82
	# 3AC: t_31 | = data | [] | i
	movq -8(%rbp), %r12
	movl -12(%rbp), %r13d
	imul $4, %r13d
	addq %r13, %r12
	movl (%r12), %r12d
	movl %r12d, %eax
	
	# Instruction number: 83
	# 3AC: push_param | t_31
	movl %eax, %esi
	lea format(%rip), %rdi 
	movl $0, %eax
	# Instruction number: 84
	# 3AC: call | print
	call printf
	
	# Instruction number: 85
	# 3AC: i | = i | + | 1
	movl -12(%rbp), %eax
	addl $1, %eax
	movl %eax, -12(%rbp)
	
	# Instruction number: 86
	# 3AC: t_32 | = i | < | 5
	movl $0, %eax         #making zero just in case
	movl -12(%rbp), %eax
	cmpl $5, %eax
	setl %al
	movzbl %al, %eax
	movl %eax, %edi
	
	# Instruction number: 87
	# 3AC: L_14 | ifZ | t_32
	movl %edi, %eax
	cmpl $0, %eax
	je .L_14
	
	# Instruction number: 88
	# 3AC: Goto | L_13
	jmp .L_13
	
	# Instruction number: 89
.L_14: 
	
	# Instruction number: 90
	# 3AC: L_func_end_main | L_func_end_main | 12
.L_func_end_main: 
	addq $16, %rsp
	popq %rbp
	ret
	
	

