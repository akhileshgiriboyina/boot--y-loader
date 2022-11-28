; Global Descriptor Table code
; db: defines words, dw: defines word, dd: defines double words

gdt_begin:
    dq 0x0   ;null descriptor: error handle

code_descriptor:
    dw 0xffff   ;segment length
    dw 0x0      ;base first 16 bit
    db 0x0      ;base next 8 bit
    db 10011010b;Type flags
    db 11001111b;Other flags
    db 0x0      ;base last 8 bits

data_descriptor:
    dw 0xffff   ;segment length
    dw 0x0      ;base first 16 bit
    db 0x0      ;base first 8 bit
    db 10010010b;Type flags
    db 11001111b;Other flags
    db 0x0      ;base last 8 bits

gdt_end:

descriptor:
    dw gdt_end - gdt_begin - 1
    dd gdt_begin

code_segment equ code_descriptor - gdt_begin 
;equ defines it at compile time
data_segment equ data_descriptor - gdt_begin