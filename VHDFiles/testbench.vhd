-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File: testbench.vhd
-- The testbench of the cpu, our cycle is 10ns
-- we use a reset signal at first.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb is
end entity;

architecture atb of tb is
	signal clk : std_logic;
	signal rst : std_logic;
begin
	
	CPU: entity work.cpu
	port map(
		clk => clk,
		rst => rst
	);


process
begin
	clk <= '0','1' after 5 ns;
	wait for 10 ns;
end process;

rst <= '1', '0' after 10 ns;



end architecture;
