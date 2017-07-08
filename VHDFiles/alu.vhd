-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  alu.vhd
-- Description: Does logic and arithmentic operations, controlled by ALUControl


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu is
port(
		clk,rst : in std_logic;

		E1,E2 : in std_logic_vector(31 downto 0);
		aluco : in std_logic_vector(3 downto 0);
		Zero : out std_logic;
		shamt : in std_logic_vector(4 downto 0);
		ALUresult : out std_logic_vector(31 downto 0)
	);
end entity;

-- 0000 = and, andi
-- 0001 = or, ori
-- 0010 = add , lw,sw,addiu,addu
-- 0011 = xor , xori
-- 0100 = lui
-- 0101 = sll
-- 0110 = sub, beq,bne
-- 0111 = slt
-- 1000 = srl

architecture aalu of alu is

	signal sub : std_logic_vector(31 downto 0);
	signal slt : std_logic_vector(31 downto 0);

begin 
	
	process(E1,E2,aluco,shamt,sub,slt,clk,rst)
	begin
	if rst = '1' then
		ALUresult <= "00000000000000000000000000000000";
	elsif clk = '0' then
		case aluco is
			when "0000" => ALUresult <= E1 and E2; -- and
			when "0001" => ALUresult <= E1 or E2; -- or
			when "0010" => ALUresult <= std_logic_vector(signed(E1) + signed(E2)); -- add
			when "0011" => ALUresult <= E1 xor E2; -- xor
			when "0100" => ALUresult <= E2(15 downto 0)&"0000000000000000"; --lui
			when "0101" => ALUresult <= std_logic_vector(shift_left(signed(E2),to_integer(unsigned(shamt)))); --sll
			when "0110" => ALUresult <= sub; -- beq bne
			when "0111" => ALUresult <= slt; --slt
			when "1000" => ALUresult <= std_logic_vector(shift_right(signed(E2),to_integer(unsigned(shamt))));
			when others => ALUresult <= "00001111000011110000111100001111"; -- Tratamento de erros
		end case;
	end if;
	end process;
	
	sub <= std_logic_vector(signed(E1) - signed(E2));
	
	slt <= "00000000000000000000000000000001" when E1 < E2
	  else "00000000000000000000000000000000";

	Zero <= '1' when sub = "00000000000000000000000000000000" else '0';	
	
end aalu;
