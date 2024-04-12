.section .data
    dividend:   .int    39
    divisor:    .int    5

    .section .bss
    buffer:     .space  12              # Allocate buffer for ASCII conversion

    .section .text
    .global _start

_start:
    # Load the dividend and divisor
    movl    dividend, %eax             # Load dividend into eax
    xorl    %edx, %edx                 # Clear edx for division (high part of dividend)
    movl    divisor, %ecx              # Load divisor into ecx

    # Perform division
    idivl   %ecx                       # Divide: quotient in eax, remainder in edx

    # Convert integer remainder to string
    movl    %edx, %esi                 # Move remainder to esi for conversion
    lea     buffer(%rip), %rdi         # Pointer to buffer for conversion
    call    int_to_ascii               # Convert integer to ASCII

    # Prepare for syscall to write remainder to stdout
    movl    $1, %eax                   # syscall: sys_write
    movl    $1, %edi                   # file descriptor: stdout
    lea     buffer(%rip), %rsi         # buffer to write from
    movl    $12, %edx                  # number of bytes to write, adjust as needed
    syscall                           # perform syscall

    # Exit the program
    movl    $60, %eax                  # syscall: sys_exit
    xorl    %edi, %edi                 # exit code: 0
    syscall                           # perform syscall

# Function: Convert integer to ASCII
# Input: %esi (number), %rdi (buffer)
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
