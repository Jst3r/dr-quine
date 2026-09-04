; Colleen reproduces its own source code on the standard output.
; Inside the template, byte 35 stands for a newline, byte 33 for a double
; quote, and byte 38 for the template itself.

global main

section .data

tpl:    db "; Colleen reproduces its own source code on the standard output.#; Inside the template, byte 35 stands for a newline, byte 33 for a double#; quote, and byte 38 for the template itself.##global main##section .data##tpl:    db !&!#tpllen equ $ - tpl#chr:    db 0##section .text##main:#    ; the template describes the whole file, so replaying it prints the source#    call print#    xor eax, eax#    ret##print:#    push rbx#    push r12#    lea r12, [rel tpl]#    xor ebx, ebx#.next:#    cmp rbx, tpllen#    jae .done#    mov al, [r12 + rbx]#    cmp al, 35#    je .newline#    cmp al, 33#    je .quote#    cmp al, 38#    je .body#    call putc#.step:#    inc rbx#    jmp .next#.newline:#    mov al, 10#    call putc#    jmp .step#.quote:#    mov al, 34#    call putc#    jmp .step#.body:#    mov rsi, r12#    mov rdx, tpllen#    call emit#    jmp .step#.done:#    pop r12#    pop rbx#    ret##putc:#    lea rsi, [rel chr]#    mov [rsi], al#    mov rdx, 1#    call emit#    ret##emit:#    mov eax, 1#    mov edi, 1#    syscall#    ret##section .note.GNU-stack noalloc noexec nowrite progbits#"
tpllen equ $ - tpl
chr:    db 0

section .text

main:
    ; the template describes the whole file, so replaying it prints the source
    call print
    xor eax, eax
    ret

print:
    push rbx
    push r12
    lea r12, [rel tpl]
    xor ebx, ebx
.next:
    cmp rbx, tpllen
    jae .done
    mov al, [r12 + rbx]
    cmp al, 35
    je .newline
    cmp al, 33
    je .quote
    cmp al, 38
    je .body
    call putc
.step:
    inc rbx
    jmp .next
.newline:
    mov al, 10
    call putc
    jmp .step
.quote:
    mov al, 34
    call putc
    jmp .step
.body:
    mov rsi, r12
    mov rdx, tpllen
    call emit
    jmp .step
.done:
    pop r12
    pop rbx
    ret

putc:
    lea rsi, [rel chr]
    mov [rsi], al
    mov rdx, 1
    call emit
    ret

emit:
    mov eax, 1
    mov edi, 1
    syscall
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
