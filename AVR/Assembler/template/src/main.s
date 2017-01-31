						; atmega32
		.include "m32def.inc"		; Includes
		
		.section	.data	
		.section	.bss	

		.section	.vectors

vectors:	
		rjmp 	reset			; Reset Handler
		rjmp 	default 		; External Interrupt0 Handler
		rjmp 	default	 		; External Interrupt1 Handler
		rjmp 	default	 		; External Interrupt2 Handler
		rjmp 	default			; Timer2 Compare Handler
		rjmp 	default 		; Timer2 Overflow Handler
		rjmp 	default			; Timer1 Capture Handler
		rjmp 	default 		; Timer1 CompareA Handler
		rjmp 	default 		; Timer1 CompareB Handler
		rjmp 	default 		; Timer1 Overflow Handler
		rjmp 	default 		; Timer0 Compare Handler
		rjmp 	default 		; Timer0 Overflow Handler
		rjmp	default			; SPI Complete Handler
		rjmp 	default	 		; USART0 RX Complete Handler
		rjmp 	default 		; USART0,UDR Empty Handler
		rjmp 	default 		; USART0 TX Complete Handler
		rjmp 	default 		; ADC Conversion Complete Handler
		rjmp 	default 		; EEPROM Ready Handler
		rjmp 	default 		; Analog Comparator Handler
		rjmp 	default 		; Two-wire Serial Handler
		rjmp 	default 		; Store Program Memory Ready Handler

		.section	.text
reset:		
		ldi 	r16, 	hi8(RAMEND)
		out	SPH, 	r16		; Stack Pointer High Init 
		ldi	r16, 	lo8(RAMEND)
		out 	SPL, 	r16		; Stack Pointer Low Init 

loop:		rjmp 	loop			; Infinite loop	

default:	
		reti				; Default interrupt execution
