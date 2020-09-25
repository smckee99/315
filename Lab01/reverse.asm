# Name: 		Sam McKee
# Section: 		01
# Description:	This program takes two inputs and performs a mod operation
# CPE 315

#java 
#	int input,output=0;
#	int currentBit;
#		
#	Scanner scanman = new Scanner(System.in);
#		
#	System.out.print("This program reverses a numbers binary bits\n\n "
#			+ "Enter an integer: ");
#	
#	input = scanman.nextInt();
#		
#	for(int i=0;i<32;i++) {
#			
#		output = output << 1;
#		currentBit = input & 1;
#			
#		output = output | currentBit;
#			
#		input = input >> 1;
#	}
#		
#	System.out.println("\n\nInteger reversed: "+ output);
#	
#	scanman.close();

#MIPS 
.globl welcome 
.globl prompt
.globl reversedNum

#Data Area 
.data

welcome: 
	.asciiz "This program reverses a numbers binary bits\n"

prompt:
	.asciiz "Enter an integer: "

reversedNum:
	.asciiz "\nInteger reversed: "

.text

main:
	
	#display welcome message
	ori $v0,$0,4

	#load a0 with the string address
	lui $a0, 0x1001
	syscall

	#display prompt
	ori $v0,$0,4

	#load prompt message 
	lui $a0,0x1001
	ori $a0,$a0,0x2D
	syscall

	#load int
	ori $v0,$0,5
	syscall
	#v0 contains our num
	
	#load 32 into t0 for 32 bits, set t1 to zero
	ori $t0,$0,32
	and $t1, $t1, $0

loop: 
	#when t0 is zero, gone through 32 times
	beq $t0, $0, end
	
	#shift the last bit in $s1 up for space of new bit
	sll $s1, $s1, 1

	#take off the LSB of $v0 into t1
	andi $t1, $v0, 1
	
	#shift the bit off 
	srl $v0, $v0, 1

	#new bit into the rightmost position of $s1
	or $s1, $s1, $t1

	#iterate and jump
	addi $t0, $t0, -1
	j loop

end:
	#print the reversed int prompt
	ori $v0,$0,4
	lui $a0,0x1001
	ori $a0,$a0,0x40
	syscall

	#print the reversed int
	ori $v0,$0,1
	add $a0,$s1,$0
	syscall

	#Exit
	ori $v0,$0,10
	syscall