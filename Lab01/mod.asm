# Name: 		Sam McKee, Jiajun Guan
# Section: 		01
# Description:	This program takes two inputs and performs a mod operation
# CPE 315

#Java Code
# Scanner scansalot = new Scanner(System.in);
# 
# System.out.print("Enter a number: ");
# int num = scansalot.nextInt();
# 
# System.out.print("\nEnter a divisor: ");
# int div = scansalot.nextInt();
# 
# System.out.print("\nRemainder: ");
# System.out.println(num&(div-1));


# declare global so programmer can see actual addresses.
.globl welcome
.globl promptNum
.globl promptDiv
.globl remainderText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program mods two numbers \n\n"

promptNum:
	.asciiz " Enter a num: "

promptDiv: 
	.asciiz " Enter a divisor: "
	
remainderText: 
	.asciiz " \n Remainder = "

#Text Area (i.e. instructions)
.text

main:

	# Display the welcome message (load 4 into $v0 to display)
	ori     $v0, $0, 4			

	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall

	# Display prompt
	ori     $v0, $0, 4			
	
	# This is the starting address of the num prompt
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall
	

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	# Clear $s0 for the sum
	ori     $s0, $0, 0	

	# Add 1st integer to sum 
	# (could have put 1st integer into $s0 and skipped clearing it above)
	addu    $s0, $v0, $s0
	
	# Display prompt (4 is loaded into $v0 to display)
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x31
	syscall

	# Read in the divisor
	ori	$v0, $0, 5			
	syscall
	# $v0 now has the value of the divisor

	# subtract 1 from the divisor to get the mask
	addi $v0, $v0, -1

	#and the mask with the num
	and $s0, $s0, $v0

	# Display the remainder
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x45
	syscall
	
	# Display the sum
	# load 1 into $v0 to display an integer
	ori     $v0, $0, 1			
	add 	$a0, $s0, $0
	syscall
	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall
