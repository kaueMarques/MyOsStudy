bits 16
org 0x7C00

%define ENDL 0x0D, 0x0A

start:
    jmp main

; Imprime uma string
; Parâmetro:
;   - ds:si aponta para a string
puts:
    push si
    push ax
    mov ah, 0x0E ; Configura a função BIOS para imprimir caractere

.loop:
    lodsb   ; Carrega o próximo caractere do array
    or al, al ; Verifica se o próximo caractere é nulo
    jz .done

    ; Verifica se é uma nova linha
    cmp al, 0x0D
    jnz .not_newline
    mov al, 0x0A ; 

.not_newline:
    int 10h
    jmp .loop

.done:
    pop ax
    pop si
    ret

splash_screen:
    mov si, print_mesg
    call puts

    mov si, print_dois
    call puts
    ret

main:
    ; Configura o registrador de segmento de dados
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Configura a pilha
    mov ss, ax
    mov sp, 0x7C00 ; Assinatura da pilha onde a memória foi carregada

    jmp splash_screen

    hlt

.halt:
    jmp .halt

print_mesg: db 'Mr Jonh Colbyny OS - v20240330-1', ENDL, 0
print_dois: db 'Running Layer of bootloader', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h