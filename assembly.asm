.data  

buffer: .space 256

filename: .asciiz "input.txt"

str0:  .asciiz "zero"
str1:  .asciiz "one"
str2:  .asciiz "two"
str3:  .asciiz "three"
str4:  .asciiz "four"
str5:  .asciiz "five"
str6:  .asciiz "six"
str7:  .asciiz "seven"
str8:  .asciiz "eight"
str9:  .asciiz "nine"

strB0: .asciiz "Zero"
strB1: .asciiz "One"
strB2: .asciiz "Two"
strB3: .asciiz "Three"
strB4: .asciiz "Four"
strB5: .asciiz "Five"
strB6:  .asciiz "Six"
strB7:  .asciiz "Seven"
strB8:  .asciiz "Eight"
strB9:  .asciiz "Nine"

.text
.globl main

j main

Capital.procedure:  #This function for printing number strings with capital letter
beq $a0, 48, Label0_C  # C means capital
j Next_B0
Label0_C:

la $a0, strB0
li $v0, 4
syscall
Next_B0:

beq $a0, 49, Label1_C #this conditions looking search number that will be printed
j Next_B1
Label1_C:

la $a0, strB1
li $v0, 4
syscall
Next_B1:

beq $a0, 50, Label2_C
j Next_B2
Label2_C:

la $a0, strB2
li $v0, 4
syscall
Next_B2:

beq $a0, 51, Label3_C
j Next_B3
Label3_C:
la $a0, strB3
li $v0, 4
syscall

Next_B3:

beq $a0, 52, Label4_C
j Next_B4
Label4_C:
la $a0, strB4
li $v0, 4
syscall
Next_B4:

beq $a0, 53, Label5_C
j Next_B5
Label5_C:
la $a0, strB5
li $v0, 4
syscall
Next_B5:

beq $a0, 54, Label6_C
j Next_B6
Label6_C:
la $a0, strB6
li $v0, 4
syscall
Next_B6:

beq $a0, 55, Label7_C
j Next_B7
Label7_C:
la $a0, strB7
li $v0, 4
syscall
Next_B7:

beq $a0, 56, Label8_C
j Next_B8
Label8_C:
la $a0, strB8
li $v0, 4
syscall
Next_B8:

beq $a0, 57, Label9_C
j Next_B9
Label9_C:
la $a0, strB9
li $v0, 4
syscall
Next_B9:

jr $ra
procedure:   #this function is for to printing number strings with no capital letter 

beq $a0, 48, Label_0
j Next_0
Label_0:

la $a0, str0
li $v0, 4
syscall
Next_0:

beq $a0, 49, Label_1
j Next_1
Label_1:

la $a0, str1
li $v0, 4
syscall
Next_1:

beq $a0, 50, Label_2
j Next_2
Label_2:

la $a0, str2
li $v0, 4
syscall
Next_2:

beq $a0, 51, Label_3
j Next_3
Label_3:
la $a0, str3
li $v0, 4
syscall

Next_3:

beq $a0, 52, Label_4
j Next_4
Label_4:
la $a0, str4
li $v0, 4
syscall
Next_4:

beq $a0, 53, Label_5
j Next_5
Label_5:
la $a0, str5
li $v0, 4
syscall
Next_5:

beq $a0, 54, Label_6
j Next_6
Label_6:
la $a0, str6
li $v0, 4
syscall
Next_6:

beq $a0, 55, Label_7
j Next_7
Label_7:
la $a0, str7
li $v0, 4
syscall
Next_7:

beq $a0, 56, Label_8
j Next_8
Label_8:
la $a0, str8
li $v0, 4
syscall
Next_8:

beq $a0, 57, Label_9
j Next_9
Label_9:
la $a0, str9
li $v0, 4
syscall
Next_9:

jr $ra

main:

li   $v0, 13       # system call for open file
la   $a0, filename      # input file name
li   $a1, 0        # flag for reading
li   $a2, 0        # mode is ignored
syscall            # open a file 
move $s0, $v0      # save the file descriptor 

li   $v0, 14       # system call for reading from file
move $a0, $s0      # file descriptor 
la   $a1, buffer   # address of buffer from which to read
li   $a2,  256  # hardcoded buffer length
syscall            # read from file

move $t2,$a1 #The initial address of the string is stored in case it can be used in the future

li $t4, 47
li $t5, 58

li $t7, 0 #the counter is held to understand the beginning of the text, and naturally the first value becomes 0
loop:   lb $a0, 0($a1)
	lb $a2, -1($a1)
	lb $a3, 1($a1)
beq $a0, 0, out

slt $t0, $a0, $t5 # if ($s1 < $s2)
bne $t0, $zero, L
beq $t0, 0, X		#these two comparison are to understand current character is number or not.

L:
slt $t0, $t4, $a0 # if ($s1 < $s2)
beq $t0, 0, X
bne $t0, $zero, Nextt
Nextt: 

beq $t7, 0 , M
beq $a2, 10, M
beq $a2, 32, M		#these are  characters that before current character
bne $a2, 32, X

M:
beq $a3, 10, P
beq $a3, 32, P

lb $a2, 2($a1)

beq $a3, 46, G
bne $a3, 46, X		#these are characters that one or two after current character

G:
beq $a2, 32, P

lb $a2, 3($a1)
beq $a2, 10, P
bne $a2, 32, X

j Y

P:
lb $a3, -2($a1)
lb $a2, -1($a1)

beq $t7, 0 ,R
bne $a3, 46, T
beq $a2, 32, R		#if the current character is number and  appropriate to print as a text then call the functions that print it. 
beq $a2, 10, R

R:
jal Capital.procedure  #Capital letters function call
j Z

T:
jal procedure		#non-capital letters function call
j Z

Y:

j Z

X: 
li $v0, 11         #these two line are just for printing numbers that will not printing as string and non-numbers characters.
syscall
Z:
addi $a1,$a1,1    #increase index to access next element of string
addi $t7,$zero,1

j loop
out:
