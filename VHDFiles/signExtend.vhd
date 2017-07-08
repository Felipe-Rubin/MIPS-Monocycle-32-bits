-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  signExtend.vhd
-- Description: Sign extension, input 16 bits outputs
-- 32 bits sign extended

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- permite resize
entity signExtend is
port(
		in_16 : in std_logic_vector(15 downto 0);
		out_32 : out std_logic_vector(31 downto 0)
	);
end entity;

architecture ase of signExtend is

begin
	-- this line, creates a new vector from the input, while replicating
	-- the firs bit, beeing a 0 or 1.
	out_32 <= std_logic_vector(resize(signed(in_16),out_32'length));

end architecture;