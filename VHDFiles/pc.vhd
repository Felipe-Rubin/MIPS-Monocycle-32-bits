-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  pc.vhd
-- Description: PC component, outputs new value during Rising Edge

library ieee;
use ieee.std_logic_1164.all;

entity pc is
port(
		pc_in : in std_logic_vector (31 downto 0);
		clk : in std_logic;
		rst : in std_logic;
		pc_out : out std_logic_vector(31 downto 0)
	);
end entity;

architecture apc of pc is

begin

	process(clk,rst)
		begin
			if rst = '1' then
				pc_out <= "00000000010000000000000000000000";
			else if clk = '1' and clk'event then
				pc_out <= pc_in;
			end if;
			end if;
	end process;
end architecture;