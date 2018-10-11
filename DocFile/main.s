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


            THUMB    
            AREA    |.text|, CODE, READONLY, ALIGN=4
            EXPORT  Start
Start		
	        ADR     r1, testStr
base        
            LDRB    r0, [r1], #1 ; load byte & increment address pointer
            CMP     r0, #0			
			BLNE    vcheck	     ; Else branch to vowel check
stop       
            LDR     r1, =prevCount
            STR     r2, [r1]
			B       .

;----------------------------VOWEL CHECK--------------------------------------
; Examines a char to see if it's a vowel. If the test passes, it changes the 
; case of the char to upper in the *original* string and increases the value
; count by one.
vcheck      
			TST     r0, #'A'
			TSTNE   r0, #'E'
			TSTNE   r0, #'I'
			TSTNE   r0, #'O'
			TSTNE   r0, #'U'
			BEQ     increment    
			TSTNE   r0, #'a'      ; Test for vowels
			TSTNE   r0, #'e'
			TSTNE   r0, #'i'
			TSTNE   r0, #'o'
			TSTNE   r0, #'u'   
            BNE     base			
	   
toUpper	    
            SUBEQ   r0, r0, #32  ; Convert to Uppercase
			STR     r0, [r1, #-1]; Store into memory, increase pointer register
			
increment
			ADD     r2, r2, #1   ; Increase the vowel count
			B       base           ; Branch back to loop start

 
; ---------Range Check----------
; Sets r3 to #1 if within a set range. Equivilant to::
;
; if (low <= x < up) SF = 1
; else SF = 0

;
; RESETS THE VALUE OF THE STATUS FLAGS
; -------------------------------
rcheck	CMP	  r0, r4  ; See if greater than lower bound
		CMPGE r5, r0  ; If greater than (or equal to) the lower bound, 
		              ;   Test if less than upper bound
		MOVGT r3, #0  ; If both checks passed, prep reset of Z status flag
		CMPGT r3, #0  ; Set Z status flag if tests passed
		BX    lr      ; Branch back to l
		
testStr 	DCB     "thisisastringwithvowels", 0 
prevCount   DCB     0

            ALIGN
            END