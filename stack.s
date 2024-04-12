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
    subq $12, %rsp # creating space for int a, int b, int c
    # a at -8(%rbp)
    # b at -12(%rbp)
    # c at -16(%rbp)

    movl $7, -8(%rbp)  # a = 7
    movl $5, -12(%rbp) # b = 5
    movl $3, -16(%rbp) # c = 12 

    # just to check if the values where set or not
        # c 
        movl -16(%rbp), %edi 
        # edi should be 3 

        # b
        movl -12(%rbp), %eax
        # eax should be 5
        
        # a 
        movl -8(%rbp),  %ebx
        # ebx should be 7
    
    # Pushing arguments
        #c 
            subq $4, %rsp 
            movl %edi, (%rsp)

            #check if the arg is populated?
            movl (%rsp), %edi # edi should be 3
        
        #b 
            subq $4, %rsp 
            movl %eax, (%rsp)

            #check if the arg is populated?
            movl (%rsp), %edi # edi should be 5
        
        #a
            subq $4, %rsp 
            movl %ebx, (%rsp)

            #check if the arg is populated?
            movl (%rsp), %edi # edi should be 7

    # checking the rsp 
        movq %rsp, %rdi
        # rdi should be a0-12 
    call _add 

    #eax should be 15 
    movl %eax, %esi 
    call _printf

    call _exit_program
    popq %rbp 

_add:
    # check what is the return address
        movq 12(%rsp), %rdi
    pushq %rbp
    movq %rsp, %rbp 
    
    subq $4, %rsp #space for c 

    # access a and put in eax
    # ret_addr ke alawa bhi 4 byte add kiya hai 
    movl 16(%rbp), %eax 
    # eax will be 7
    addl 20(%rbp), %eax 
    # eax will be 12
    addl 24(%rbp), %eax 
    # eax will be 15

    movl %eax, -8(%rbp)

    # Checking if c is placed or not 
    movl -8(%rbp), %edi #edi should be 15 

    addq $4, %rsp
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
