-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  alucontrol.vhd
-- Description: ALU operation controller
-- For type R instructions, Uses function field to verify which operation should do
-- for other types of instruction uses the unique ALUOp


library ieee;
use ieee.std_logic_1164.all;

entity alucontrol is
port(
		clk,rst: in std_logic;
		ALUOp : in std_logic_vector(2 downto 0);
		aluco : out std_logic_vector(3 downto 0); -- aluco == ALUControlOutput
		func : in std_logic_vector(5 downto 0)
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



architecture ac of alucontrol is
begin 

	process(ALUOp,func)
	begin
		case ALUOp is
			when "000" => aluco <= "0010"; --add
			when "001" => aluco <= "0110"; -- beq,bne
			when "011" => aluco <= "0111"; --slt
			when "100" => aluco <= "0000"; -- and
			when "101" => aluco <= "0001";-- or
			when "110" => aluco <= "0011"; --xor
			when "111" => aluco <= "0100"; --lui
			when "010" => case func is
							when "100001" => aluco <= "0010"; --addu
							when "101010" => aluco <= "0111"; --slt
							when "000000" => aluco <= "0101"; --sll
							when "000010" => aluco <= "1000"; --srl
							when others => aluco <= "1111";
						end case;
			when others => aluco <= "1111";
			end case;
			end process;


end ac;
