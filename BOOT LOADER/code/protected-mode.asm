[bits 16]
protected_mode:
	cli	;disabling interrupts
	lgdt [descriptor]	;load GDT descriptor table
	
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax	;enable protected mode in control mode register
	
	jmp code_segment:init_protected		;jump at a far location
	
[bits 32]
init_protected:
	mov ax, data_segment
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax
	
	mov ebp, 0x90000
	mov esp, ebp
	
	call begin_protected_mode	;move back to mbr