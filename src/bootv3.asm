org 0x7C00
bits 16
%define ENDL 0x0D, 0x0A

.start:
  cli
  mov ax, 0x0000
  mov ds, ax
  mov es, ax 
  mov ss, ax
  mov sp, 0x7C00
  sti
  mov si, msg_hello							;puts message string into si register
	call puts											;calls the puts function


puts:
	push si
	push ax
.loop:
	lodsb													;loads the next character in the string
	or al, al											;compares register to see if character is null
	jz .done											;if al flag is set to 0 jump to done function
	mov ah, 0x0e									;set interrupt value to write text to the screen TTY (teletype)
	mov bh, 0											;het page number to 0
	int 0x10											;sets a software interrupt to video
	jmp .loop											;jumps back to the start of loop function if flag is not 0
.done:
	pop ax												;clears ax register
	pop si												;clears si register
	ret														;return to where function was called

msg_hello: db 'Booting...', ENDL, 0
times 510-($-$$) db 0 					;Pads out file to 512MB
dw 0AA55h 											;signature for bootloader