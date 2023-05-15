BITS 64

extern rand, srand, time, printf, scanf

section .text

    global _start

_start:

    mov rdi, 0x0
    call time
    add rsp, 8

    mov rdi, rax
    call srand
    add rsp, 8

    call rand

    xor rdx, rdx
    mov rcx, 100
    div rcx
    add rdx, 1
    mov [answer], edx

    .while_start:
        mov rdi, formatHello
        xor rax, rax
        call printf

        mov rdi, formatScanf
        mov rsi, guess
        xor rax, rax
        call scanf

        mov rax, [guess]
        cmp eax, [answer]
        je .while_end
        jl .if_less
        jg .if_greater

        .if_less:
            mov rdi, tooLowMsg
            xor rax, rax
            call printf
            jmp .while_start

        .if_greater:
            mov rdi, tooHighMsg
            xor rax, rax
            call printf
            jmp .while_start

    .while_end:
        xor rax, rax
        mov rdi, formatWinMsg
        mov rsi, [answer]
        call printf

    mov rdi, 0

    mov rax, 0x3c
    syscall


section .data

    formatHello db "Try to guess a number between 1 and 100", 10, "> ", 0

    formatScanf db "%d"

    tooLowMsg db "Too low!", 10, 0
    tooHighMsg db "Too high!", 10, 0

    formatWinMsg db "Congrats! The number was: %d", 10, 0

section .bss

    answer resd 1
    guess resd 1
