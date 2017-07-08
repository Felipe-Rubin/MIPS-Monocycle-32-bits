-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  ZeroExtend.vhd
-- Description: Zero extension, input 16 bits and outputs 32 bits zero extended.
-- It is important to instructions where
-- the immediate should only be positive, such as XORI

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- permite resize
entity zeroExtend is
port(
		in_16  : in std_logic_vector(15 downto 0);
		out_32 : out std_logic_vector(31 downto 0)
	);
end entity;

architecture aze of zeroExtend is
begin
	-- Beeing lazy, just gets the 16 bit input and concatenate 0's at front
	out_32 <= "0000000000000000"&in_16;

end architecture;
