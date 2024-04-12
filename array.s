
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
    
    # int n = 5;
    # int arr[n] = {1,2,3,4,5};
    # int sum = get_sum(arr,n);

    subq $28, %rsp 

    # n   : -8
    # arr : -12
    # sum : -32 

    # n
    movl $5, -8(%rbp)
        movl -8(%rbp), %eax #debug stmt
    
    # arr[0]
    movl $1, -12(%rbp)
        movl -12(%rbp), %eax 
        lea -12(%rbp), %rdi 
    # arr[1]
    movl $2, -16(%rbp)
        movl -16(%rbp), %eax

    # arr[2]
    movl $3, -20(%rbp)
        movl -20(%rbp), %eax 
    
    # arr[3]
    movl $4, -24(%rbp)
        movl -24(%rbp), %eax

    # arr[4]
    movl $5, -28(%rbp)
        movl -28(%rbp), %eax 


    # pushing arguments 
        # n
        subq $4, %rsp
        movl -8(%rbp), %eax 
        movl %eax, (%rsp)

        # arr
        subq $8, %rsp 
        leaq -12(%rbp), %rax
        movq %rax, (%rsp)

    call _get_sum

    movl %eax, %esi
    call _printf 

    call _exit_program
    popq %rbp 

_get_sum:
    pushq %rbp
    movq %rsp, %rbp 
    
    subq $8, %rsp #space for sum 
    # sum (%rsp)
    # i -4(%rsp)

    movl $0, (%rbp)
    movl $0, -4(%rbp)

    # Checking received arguments 
        movl 20(%rbp), %ebx
        movl 24(%rbp), %ebx
        movq 16(%rbp), %rbx 

    # for(int i=0; i<n; i++){
    #   sum += arr[i]
    #}

# for loop start:
for_loop:
    movl -4(%rbp), %eax           # i

    movq 16(%rbp), %rbx             #arr

    movl (%rbx,%rax,4), %eax             # arr[i]
    addl (%rbp), %eax             # sum += arr[i]

    movl 24(%rbp), %eax           # n
    addl $1, -4(%rbp)
        #checking 
            movl -4(%rbp), %ecx 
    cmpl  %eax, %ecx           # (i < n)? 
    jl for_loop

    movl (%rbp), %eax

    addq $8, %rsp
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
