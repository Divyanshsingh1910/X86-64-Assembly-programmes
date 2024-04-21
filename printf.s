.section .data
format:
    .string "%d\n"  # Format string for printf

.section .text
.globl main
.type main, @function
main:
    # Function prologue
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp   # Reserve space for local variables, aligning to a 16-byte boundary

    # Initialize a to 1
    movl $-89, -4(%rbp)  # Store 1 at address [rbp-4]

    # Increment a by 1
    movl -4(%rbp), %eax  # Move the value of a into eax
    addl $1, %eax        # Increment eax by 1
    movl %eax, -8(%rbp)  # Store the result back into b

    # Prepare printf arguments
    movl -8(%rbp), %esi  # Load b into esi for printf
    lea format(%rip), %rdi  # Load the address of the format string

    # Call printf
    mov $0, %eax  # Clear %eax to indicate no SSE instructions used
    call printf

    # Function epilogue
    leave
    ret
