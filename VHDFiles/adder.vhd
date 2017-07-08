-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  adder.vhd
-- Description: input 2 vectors and output their sum.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity adder is
port(
		e0,e1: in std_logic_vector(31 downto 0);
		s1: out std_logic_vector(31 downto 0)
	);
end entity;

architecture a4 of adder is
begin

	s1 <= std_logic_vector(signed(e0) + signed(e1));
end architecture;
