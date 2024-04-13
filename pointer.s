
.section .data
    dividend:   .int    39
    divisor:    .int    5

.section .bss
    buffer:   .space 12 

.section .text
.global _start


_start:
    pushq %rbp
    movq %rsp, %rbp 
    
    subq $4, %rsp  # space for a 

    movl $17, -4(%rbp)

    # pushing the pointer of a 
    subq $8, %rsp           # space for the pointer argument
    lea -4(%rbp), %rax      # address of a 
    movq %rax, -12(%rbp)    # pushed the argument 

    call _get_val
    
    call _exit_program
    popq %rbp 

_get_val:
        movq %rsp, %rax # debug 
    pushq %rbp
        movq (%rsp), %rbx # this time isme rbp nhi milega ?
    movq %rsp, %rbp 

    movq 16(%rbp), %rax   # &a 
    movl (%rax), %eax     # a 

    movl %eax, %esi 

    call _printf
    
    popq %rbp
    ret

# print routine
_printf:
    # assume krte hain ki esi mein hogi value 
    # which needs to be printed 
    pushq %rbp 
    movq %rsp, %rbp 

    lea buffer(%rip), %rdi 
    call int_to_ascii 


    # syscall to write out the variable 
    movl $1, %eax             # sys_call number 
    movl $1, %edi             # fd: stdout 
    lea buffer(%rip), %rsi    # buffer to write from 
    movl $12, %edx            # number of bytes to write 
    syscall

    popq %rbp 
    ret 

#function: convert integer to ascii 
#input: %esi (number), %rdi (buffer)

int_to_ascii:
    addq    $11, %rdi                  # Move to the end of the buffer (1 past the last digit)
    movb    $0, (%rdi)                 # Null terminate the string

    convert_loop:
        decq    %rdi                   # Move buffer pointer back
        xorl    %eax, %eax             # Clear eax
        xorl    %edx, %edx             # Clear edx before division
        movl    %esi, %eax             # Move number to eax for division
        movl    $10, %ecx              # Set divisor to 10
        idivl   %ecx                   # Divide eax by 10
        addb    $'0', %dl              # Convert remainder to ASCII
        movb    %dl, (%rdi)            # Store ASCII character
        movl    %eax, %esi             # Update number in esi
        testl   %eax, %eax             # Check if quotient is zero
        jnz     convert_loop           # If not zero, repeat

    ret                                 # Return from function


    # Exit the program
_exit_program:
    movl    $60, %eax                  # syscall: sys_exit
    xorl    %edi, %edi                 # exit code: 0
    syscall                           # perform syscall
