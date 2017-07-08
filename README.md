# MIPS-Monocycle-32-bits
Implementation of MIPS Monocycle 32 bits in VHDL for a CS Class

T2 Organizacao e Arquitetura de Computadores I
University: Pontificia Universidade Catolica do Rio Grande do Sul, Brazil
Year 2017/1
Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti

#Accepted instructions:

LA (Pseudo-Instruction which is actually LUI then ORI),
LW, SW, ADDU, ADDIU, SLT, SLTIU, BEQ,
BNE, ANDI, LUI, ORI, XORI, SLL, SRL

#If you have any questions, feel free to ask.

#You can see in Architecture.png what we "modified".

#In the file called "tp2_20171-5.pdf" you can, in Brazillian Portuguese, what the our job was.

#Side-Note:

This project is fully compatible with GHDL and GTKWAVE.

We used them while creating the project and the presentation for 
class was done in Xilinx ISE.

GHDL + GTKWAVE Tutorial:

1) Compile it in this order (mostly because cpu then testbench should be at the end)

ghdl -a adder.vhd alu.vhd alucontrol.vhd control.vhd InstructionMemory.vhd mux.vhd pc.vhd ram.vhd registerBlock.vhd shiftleft2.vhd signExtend.vhd zeroExtend.vhd cpu.vhd testbench.vhd;

2) Execute Testbench 

ghdl -e tb

3) Run it

ghdl -r tb --stop-time=200ns --wave=wave.ghw;

Note that 
--stop-time=number ns is important

the output can be either

--wave=file.ghw : Runs a bit buggy in GTWAVE, but shows everything you need

or 

--vcd=wave.vcd : Runs nice in GTKWAVE, but doesn't show arrays of RAM, InstructionMemory and registerblock

















