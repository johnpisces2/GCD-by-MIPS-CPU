.data
str_inputA : .asciiz "Enter the numA: "
str_inputB : .asciiz "Enter the numB: "

str_gcd : .asciiz    "gcd is        : "

.text
.globl main

main : 
		#read the A number
		li $v0, 4 			# load syscall code (4 : print string)
		la $a0, str_inputA	# load address of string to be printed into $a0
		syscall				# print string
		li $v0, 5			# load syscall code (5 : read int)
		syscall				# read int
		add $t1, $zero, $v0 # put the enter into $t1 
		
		#read the B number
		li $v0, 4 			# load syscall code (4 : print string)
		la $a0, str_inputB	# load address of string to be printed into $a0
		syscall				# print str
		li $v0, 5			# load syscall code (5 : read int)
		syscall				# read int
		add $t2, $zero, $v0 # put the enter into $t2
	
		move $t3, $t1		# extend $t1 into $t3
		move $t4, $t2		# extend $t2 into $t4
		j equalzero

#equal or not equal for begining		
equalzero :
		sub $t1, $t3, $t4 	#if $t3=$t4,go to Exit and get the gcd
		beq $t1, $zero,	Exit# $t3!=$t4
		j compare           #compare $t3 & $t4
		
compare :
		beq $t3, $zero, Exit#critical! ,geting the gcd before $t3==0
		slt $t1, $t3, $t4 	#t4>$t3 ,$t1=1  or $t4$<t3
		beq $t1, $zero, morethan #if t3>=$t4,go to morethan but lessthan
		j lessthan          #t3<$t4
		
lessthan :		
		sub $t2, $t4, $t3   
		move $t4,$t2
		j compare			#go to compare
morethan :		
		sub $t1, $t3, $t4
		move $t3, $t1
		j compare			#go to compare
Exit :
		li $v0, 4 			# load syscall code (4 : print string)
		la $a0, str_gcd		# load address of string to be printed into $a0
		syscall
		li $v0, 1			# load syscall code (1 : print int)
		move $a0, $t4		# copy the content in t0 to a0 , $t4 will be the gcd!
		syscall
		li $v0, 10			# Leave the program!
		syscall