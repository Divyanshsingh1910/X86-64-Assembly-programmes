.section .data
    str1:
        .string "Hellr!"
    str2:
        .string "Hello, world!"

.section .text
.extern strcmp
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp 
    lea str1(%rip), %rdi
    lea str2(%rip), %rsi
    call strcmp

    cmp $0, %rax
    jl less_than
    je equal
    jg greater_than

less_than:
    # Code to execute if str1 < str2
    jmp end

equal:
    # Code to execute if str1 == str2
    jmp end

greater_than:
    # Code to execute if str1 > str2
    jmp end

end:
    # Rest of your code
    popq %rbp
    ret 
