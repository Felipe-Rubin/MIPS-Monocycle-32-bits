-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  control.vhd
-- Description: Send control signals to data block according to the instruction

library ieee;
use ieee.std_logic_1164.all;

entity control is
port(
		rst : in std_logic;
		clk : in std_logic;
		instr : in std_logic_vector(5 downto 0);
		Branch_NE,Sign_Ext : out std_logic;
		RegWrite, RegDst, ALUSrc,Branch,MemRead,MemWrite,MemtoReg : out std_logic;
		ALUOp : out std_logic_vector(2 downto 0)

	);
end entity;

architecture acontrol of control is
signal rformat,lw,sw,beq,bne,iformat,signext : std_logic;
begin

	rformat <= '1' when instr = "000000" else '0'; --tipo R
	lw  	<= '1' when instr = "100011" else '0'; -- LW
	sw  	<= '1' when instr = "101011" else '0'; -- SW
	beq 	<= '1' when instr = "000100" else '0'; -- BEQ
	bne 	<= '1' when instr = "000101" else '0'; -- BNE
	iformat <= '1' when instr = "001001" or --addiu
						instr = "001011" or --sltiu
						instr = "001100" or --andi
						instr = "001101" or --ori
						instr = "001110" or -- xori
						instr = "001111" -- lui
						else '0';

	signext <= '1' when instr = "001001" or --addiu
				   		instr = "001011" or --sltiu
				   		instr = "000100" or -- beq
				   		instr = "000101" or -- bne
				   		instr = "100011" or -- LW
				   		instr = "101011" -- SW
				   		else '0';


--000 = add,lw,sw,addiu
--001 = beq,bne,sub
--010 = rformat
--011 = sltiu
--100 = andi
--101 = ori
--110 = xori
--111 = lui
	
		RegDst <= rformat;
		ALUSrc <= iformat or lw or sw;
		Branch <= beq;
		Branch_NE <= bne;
		MemRead <= lw;
		MemWrite <= sw; 
		MemtoReg <= lw;

		process(clk)
		begin
		if clk = '1' then
			RegWrite <= rformat or iformat or lw;
		else
			RegWrite <= '0';
		end if;
		end process;
	
		-- Circuito para definir a ALUOp
		ALUOp(2) <= iformat and (not signext);
		ALUOp(1) <= rformat or (iformat and instr(1));
		ALUOp(0) <= beq or bne or (iformat and (instr(0) and (instr(1) or instr(2))));
		Sign_Ext <= signext;





end acontrol;
