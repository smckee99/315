#Sam McKEe
# CPE 315
# Lab 1 Part 4

#Java Code
#		int base,exponent;
#		int result;
#		
#		Scanner scanman = new Scanner(System.in);
#		
#		System.out.println("This program will take a base and raise it to the power of an integer\n");
#		
#		System.out.print("Enter a base number: ");
#		base = scanman.nextInt();
#		
#		System.out.print("\nEnter a number exponent: ");
#		exponent = scanman.nextInt();
#		
#		result = (int)Math.pow((double)base,(double)exponent);
#		
#		System.out.print("\n\nYour result is: " + result);
#		
#		scanman.close();

#declare messages
.globl welcome
.globl basePrompt
.globl powerPrompt
.globl result

.data
	
welcome: 
	.asciiz " This program will take a base and raise it to the power of an integer\n\n"

basePrompt:
	.asciiz " Enter a base number: "

powerPromot:
	.asciiz " \nEnter a number exponent: "

result: 
	.asciiz " \n\nYour result is: "

.text

main: 
	#display welcome
	ori $v0, $0, 4

	lui $a0, 0x1001
	syscall

	#prompt user for value
	ori $v0, $0, 4

	lui $a0, 0x1001
	ori $a0, $a0, 0x4A
	syscall

	ori $v0, $0, 5
	syscall

	#put base into $t0
	ori $t0, $v0, 0

	#prompt user for the exponent
	ori $v0, $0, 4

	lui $a0, 0x1001
	ori $a0, $a0, 0x60
	syscall

	ori $v0, $0, 5
	syscall

	#put exponent into t1
	ori $t1, $v0, 0

	#before going into multiplying anything, check if t1 is zero
	ori $s0, $0, 1
	beq $t1, $0, end

	or $s0, $0, $t0
	#create a multiplication method that we call t1 number of times

loop:
	#if t1 is 1, go to end
	beq $t1, 1, end 

	#call mult on the t0 and decrement t1
	ori $a0, $t0, 0
	ori $a1, $s0, 0

	ori $v0, $0, 0
	jal multiply

	ori $s0, $v0, 0
	addi $t1, $t1, -1

	j loop

multiply:
	#arguments in a0 and a1
	#return int in $v0
	beq $a0, 0, endMult

	add $v0,$v0,$a1
	
	#decrement and jump
	addi $a0,$a0,-1
	j multiply

endMult:
	jr $ra

end:
	#print result 
	ori $v0, $0, 4
	
	lui $a0,0x1001
	ori $a0,$a0,0x7C
	syscall

	ori $v0, $0, 1
	addi $a0, $s0, 0
	syscall

	#exit
	ori $v0,$0, 10
	syscall
