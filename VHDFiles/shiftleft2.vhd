-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  shiftleft2.vhd
-- Description: Input 32 bits and return 32 bits << 2

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity shiftleft2 is
	port(
			e1: in std_logic_vector(31 downto 0);
			s1: out std_logic_vector(31 downto 0)
		);
end shiftleft2;

architecture Behavioral of shiftleft2 is

begin
	
	s1 <= e1(29 downto 0)&'0'&'0';  

end Behavioral;

