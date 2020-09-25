#Sam McKee
# CPE 315
# Lab 01 Part 3

#java code 
#	long dividend;
#	int divisor;
#			
#	Scanner scanman = new Scanner(System.in);
#			
#	System.out.println("This program will take a 64 bit number and divide it by any 31 bit integer\n");
#	System.out.print("Enter a 64 bit dividend: ");
#			
#	dividend = scanman.nextLong();
#			
#	System.out.print("\nEnter a 31 bit divisor: ");
#			
#	divisor = scanman.nextInt();
#			
#	System.out.print("\n\nResult = " + (dividend/divisor));
#			
#	scanman.close();

#declare the prompt messages
.globl welcome
.globl promptUpper
.globl promptLower
.globl promptDivisor
.globl result
.globl comma

# data area
.data

welcome: 
	.asciiz " This program will take a 64 bit integer in 2 prompts and divide by any 31 bit integer as long as it is a factor of 2 \n\n"

promptUpper:
	.asciiz " Enter the upper 32 bit integer: "

promptLower: 
	.asciiz "\n Enter the lower 32 bit integer: "

promptDivisor:
	.asciiz " \nEnter a 31 bit divisor (reminder: MUST BE FACTOR OF 2 OR PROGRAM WILL NOT OPERATE PROPERLY): "

result:
	.asciiz " \n\nResult = "

comma: 
	.asciiz ","

.text

main:
	#display welcome prompt
	ori $v0, $0, 4

	#generate address for welcome message
	lui $a0, 0x1001
	syscall

	ori $v0, $0, 4

	#generate the upper prompt
	lui $a0, 0x1001
	ori $a0, $a0, 0x79
	syscall

	#take in the num
	ori $v0, $0, 5
	syscall

	#put the upper num into s0
	ori $s0, $v0, 0

	#display the lower text 
	ori $v0, $0, 4
	lui $a0, 0x1001
	ori $a0, $a0, 0x9C
	syscall

	#load that bad boy into s1
	ori $v0, $0, 5
	syscall

	ori $s1, $v0, 0

	#load the divisor prompt
	ori $v0, $0, 4
	lui $a0, 0x1001
	ori $a0, $a0, 0xBF
	syscall

	#load that badder boy into s2
	ori $v0, $0, 5
	syscall

	ori $s2, $v0, 0

	#all that the division is gonna do is shift right until our divisor is 0
	#if the LSB in upper is high then it needs to shift into the lower register upon the shift 
loop:
	beq $s2, 0x1, end

	andi $t0, $s0, 1
	sll $t0, $t0, 31

	srl $s2, $s2, 1

	srl $s0, $s0, 1
	srl $s1, $s1, 1

	#if upper had a high LSB put it into the MSB of lower
	or $s1, $s1, $t0

	j loop

end: 
	#print result seperated by comma
	ori $v0, $0, 4
	lui $a0, 0x1001
	ori $a0, $a0, 0x11E
	syscall

	ori $v0, $0, 1
	addi $a0, $s0, 0
	syscall

	ori $v0, $0, 4
	lui $a0, 0x1001
	ori $a0, $a0, 0x12B
	syscall

	ori $v0, $0, 1
	addi $a0, $s1, 0
	syscall

	#Exit
	ori $v0, $0, 10
	syscall

	
