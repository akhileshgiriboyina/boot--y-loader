; This is the main file defining the master boot record (512 byte boot sector)

[bits 16] ; sets the instructions mode to 16-bit
[org 0x7c00] ; specifies the offset from the start of a segment


; sets the assembler constant kernel_base_addr's value to where the kernel is to be loaded
kernel_base_addr equ 0x1000 

; copying the boot drive from d1 set by BIOS into variable org_boot_drive for later use
mov [org_boot_drive], dl

; setting stack pointer registers sp and bp to 0x9000 (away from our other bootloader memory)
mov bp, 0x9000
mov sp, 0x9000

; instruct the BIOS to load the kernel from disk into memory at the kernel_base_addr address
call boot_load_kernel

; switch to 32-bit mode and pass the control to kernel by jumping to kernel_base_addr
call protected_mode

; infinite loop to keep the kernel running forever
jmp $

; file includes
%include "disk.asm"
%include "gdt.asm"
%include "protected-mode.asm"

[bits 16]
boot_load_kernel:
    ; move the boot drive number back to dl in case it was changed
    mov dl, [org_boot_drive] 
    ; location of kernel to base register
    mov bx, kernel_base_addr
    ; set dh to number of sectors
    mov dh, 10 
    ; call disk_load procedure from disk.asm
    call boot_disk_load
    ret

[bits 32]
begin_protected_mode:
    ; give control to the kernel
    call kernel_base_addr 
    ; infinite loop in case kernel returns
    jmp $ 

; declaring the boot drive variable
org_boot_drive db 0

; padding the remaining memory with zeroes
; $ is start of current line and $$ is start of current section
times 510 - ($-$$) db 0

; set last word to magic number (0x55aa) in little endian format
dw 0xaa55