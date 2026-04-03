
ORG 0x7C00											;tells compiler where to start 
BITS 16													;tells compiler to use 16 bit segments
%define ENDL 0x0D, 0x0A					;defines end line character
global _start
_start:													;first function to jump over secondary functions to the main function
	mov si, msg_hello							;puts message string into si register
	call puts											;calls the puts function
	jmp main											;jumps to the main function
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
main: 													;where is all starts
	mov	ax, 0											;initialise register ax as 0
	mov ds, ax										;initialise register ax as 0
	mov es, ax										;initialise register ax as 0
	mov ss, ax										;initialise register ax as 0
	mov sp, 0x7c00								;initialise stack pointer at start of file
	mov si, initialised_msg				;moves the extended message into the si register
	call puts											;calls the puts function to write the message to the screen
	jmp 0x10000
	hlt 													;temporary halt command

.halt: 													;Really makes sure that it stops
	jmp .halt 										;jumps to start of loop
msg_hello: db 'Hello world!', ENDL, 0
initialised_msg: db 'The registers are initialised!', ENDL, 0
after_jmp_msg: db 'We have now jumped to another memory location', ENDL, 0
times 510-($-$$) db 0 					;Pads out file to 512MB
dw 0AA55h 											;signature for bootloader
jmp 0x10000											;tells compiler where to start 
mov si, after_jmp_msg
call puts
hlt