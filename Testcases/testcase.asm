.text
.globl main
main:
	la $t0, A # Carrega pos mem A
	lw $t0, 0 ($t0) # carrega valor pos mem A
	
	xori $t1, $zero, 0 # Zera $t1
	
	la $t2, B #Carrega pos mem B
	lw $t2, 0 ($t2) #Carrega valor pos mem B
	
	addu $t0, $t0, $t2 # Soma Val[A] + Val[B]
	
	addiu $t0, $t0, 3 # incrementa o valor da soma em 3
	
	ori $t5, $zero, 2 # i = 2
	
	beq $zero, $zero, loop # Salta pro loop
	
loop:
	sll $t0, $t0, 4 # $t0 * 8
	srl $t0, $t0, 2 # $t0 / 4
	
	addiu $t5, $t5, -1 # i--
	
	bne $t5, $zero, loop # Se i = 0, para, senao loop denovo 

fim:
	andi $t7, $t0, 1 #Verifica se o resultado eh par = 0, ou impar = 1

	slt $t8, $t5, $t0 # 1 se 0 < Resultado, senao 0
	sltiu $t9, $t0, 10 # 1 se Resultado < 10, senao 0
	la $t1, C # Carrega pos mem C
	sw $t0, 0 ($t1) # Salva o resultado em C

.data

A: .word 0x3
B: .word 0x4
C: .word 0x0