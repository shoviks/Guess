.data #let processor know we will be submitting data to program now

Thinking:
	.asciiz "\I am thinking of a random number between 1 and 100" #Prompt for the user

Enter:
	.asciiz "\Enter your guess"
	
Too_High:
	.asciiz "\Your guess is too high." #in unused memory store this string with address Not_two

Too_Low:
	.asciiz "\Your guess is too low."
	
Right_Number:
	.asciiz "\You have guessed the number. Well done!" 

You_Have:
	.asciiz "\You have "
	
Guesses:
	.asciiz " guesses"
	
Newline:
	.asciiz "\n"	
	

.text #Code section of our MIPS program
	
main:
	addi $t0, $zero, 1	
	addi $t1, $zero, 100
		
Outer:	bge $t0, $t1, Exit #First while loop, branch if 1 > 100
	
	li $a1, 100 #$a0 contains random number
        li $v0, 42
        syscall
	
	add $t3, $a0, $zero #$t3 contains random number
	
	addi $t2, $zero, 10 #num of guesses
	
	li  $v0, 4 #Prints message
        la  $a0, Thinking
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
Inner:
        beq $t2, $zero, Outer #Branch if num of guesses = 0
        
        li  $v0, 4 #Prints message
        la  $a0, Enter
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall

	li  $v0, 4 #Prints message
        la  $a0, You_Have
        syscall
  
        # Print number (syscall 0)
	add $a0, $zero, $t2  # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 1   # Prepare syscall 0
	syscall              # System call

	li  $v0, 4 #Prints message
        la  $a0, Guesses
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        addi $v0, $zero, 5 #loads the value 5 (opcode for read integer)
	syscall
	addi $s0, $v0, 0  #move the input number to $s0
	                        
        addi $t2, $t2, -1 #decrement num of guesses
        
        bge $s0, $t3, L1 #Branch if user input is greater than random number
        
    
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Too_Low
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        
        j Inner
             
L1:
	beq  $s0, $t3, ELSE #Branch if user input is equal to random number
        
       
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Too_High
        syscall
        
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall

	li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
	j Inner

ELSE:
       
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
	li  $v0, 4 #Prints message
        la  $a0, Right_Number
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        li  $v0, 4 #Prints message
        la  $a0, Newline
        syscall
        
        j Outer
        
Exit:
	li $v0, 10 #loads op code into $v0 to exit program
	syscall #reads $v0 and exits program
  
