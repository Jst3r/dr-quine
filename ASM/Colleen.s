section .text
    global _start

_start:
    ; comment within the entry point routine
    call helper_fun
    mov rax, 60
    xor rdi, rdi
    syscall

; comment outside of the entry point routine
helper_fun:
    lea r12, [rel data_]
    sub rsp, 8
.loop:
    mov al, [r12]
    test al, al
    jz .done
    mov rdx, 1
    cmp al, 124
    je .newline
    cmp al, 126
    je .quote
    cmp al, 64
    je .self
    mov rsi, r12
    jmp .write
.newline:
    mov byte [rsp], 10
    mov rsi, rsp
    jmp .write
.quote:
    mov byte [rsp], 39
    mov rsi, rsp
    jmp .write
.self:
    lea rsi, [rel data_]
    mov rdx, data_len
.write:
    mov rax, 1
    mov rdi, 1
    syscall
    inc r12
    jmp .loop
.done:
    add rsp, 8
    ret

section .data
    data_ db 'section .text|    global _start||_start:|    ; comment within the entry point routine|    call helper_fun|    mov rax, 60|    xor rdi, rdi|    syscall||; comment outside of the entry point routine|helper_fun:|    lea r12, [rel data_]|    sub rsp, 8|.loop:|    mov al, [r12]|    test al, al|    jz .done|    mov rdx, 1|    cmp al, 124|    je .newline|    cmp al, 126|    je .quote|    cmp al, 64|    je .self|    mov rsi, r12|    jmp .write|.newline:|    mov byte [rsp], 10|    mov rsi, rsp|    jmp .write|.quote:|    mov byte [rsp], 39|    mov rsi, rsp|    jmp .write|.self:|    lea rsi, [rel data_]|    mov rdx, data_len|.write:|    mov rax, 1|    mov rdi, 1|    syscall|    inc r12|    jmp .loop|.done:|    add rsp, 8|    ret||section .data|    data_ db ~@~, 0|    data_len equ $ - data_ - 1|', 0
    data_len equ $ - data_ - 1
