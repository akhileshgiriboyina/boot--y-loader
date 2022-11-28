boot_disk_load:
    pusha
    push dx

    mov al,dh
    mov cl, 0x02
    mov dh, 0x00
    mov ch, 0x00
    mov ah, 0x02

    int 0x13
    jc infinite_loop

    pop dx
    cmp al,dh
    jne infinite_loop

    popa
    ret

infinite_loop:
    jmp $