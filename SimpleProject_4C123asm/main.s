; Counts the number of vowels in a String and makes them uppercase.
;
; ---------------------------REGISTER SET-UP----------------------------------
; r0 := Working Byte
; r1 := Working pointer
; r2 := Working count of vowels
; r3 := Working offset from String pointer
; r4 := 
; r5 :=
; r6 := String Pointer


; we align 32 bit variables to 32-bits
; we align op codes to 16 bits

            AREA    |.text|, CODE, READONLY, ALIGN=2
            EXPORT  Start
;-----------------------------------DATA--------------------------------------
testStr 	DCB     "abcdefghijklmnopqrstuvwxyzAEIOU", 0 

;-----------------------------------CODE--------------------------------------
Start		
	        ADR     r1, testStr
base        
            LDRB    r0, [r1], #1 ; load byte & increment address pointer
            CMP     r0, #0			
			BNE    vcheck	     ; Else branch to vowel check
stop        
            CMP     r2, #10      ; expected value check
			B       .

;----------------------------VOWEL CHECK--------------------------------------
; Examines a char to see if it's a vowel. If the test passes, it changes the 
; case of the char to upper in the *original* string and increases the value
; count by one.
vcheck      
			CMP     r0, #0x41 ; A
			CMPNE   r0, #0x45 ; E 
			CMPNE   r0, #0x49 ; I
			CMPNE   r0, #0x4F ; O
			CMPNE   r0, #0x55 ; U
			BEQ     increment    
			CMPNE   r0, #0x61 ; a
			CMPNE   r0, #0x64 ; e
			CMPNE   r0, #0x69 ; i
			CMPNE   r0, #0x6F ; o
			CMPNE   r0, #0x75 ; u
            BNE     base			
	   
toUpper	    
            SUB     r0, r0, #32  ; Convert to Uppercase
			STR     r0, [r1, #-1]; Store into memory, increase pointer register
			
increment
			ADD     r2, r2, #1   ; Increase the vowel count
			B       base         ; Branch back to loop start

            ALIGN
            END
           