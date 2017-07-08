-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  registerBlock.vhd
-- Description: Register bank, all values start with 0 with the 
-- exception of special ones such as $sp.
-- Register values can be read while the Clock is 0
-- Registers can be written while the Clock is 1


library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

entity registerBlock is
port (
		regWrite,clk,rst : in std_logic;
		readReg1,readReg2,writeReg : in std_logic_vector(4 downto 0);
		writeData : in std_logic_vector(31 downto 0);
		readData1, readData2 : out std_logic_vector(31 downto 0)
	);
end entity;


architecture arb of registerBlock is

	type reg_mem is array(0 to 31) of std_logic_vector(31 downto 0);

	signal rmem : reg_mem := (
			28 => "00010000000000001000000000000000", -- $gp
			29 => "01111111111111111110111111111100", -- $sp
			others => "00000000000000000000000000000000" -- any other
		);

begin

	process(clk,rst,writeReg,readReg1,readReg2,regWrite,writeData,rmem)
	begin
	if rst = '1' then
	elsif clk = '1' then
		-- Also makes sure that $0($zero) should not be written on
		if writeReg /= "00000" and regWrite = '1' then
			rmem(to_integer(unsigned(writeReg(4 downto 0)))) <= writeData;
		end if;
	elsif clk = '0' then
		readData1 <= rmem(to_integer(unsigned(readReg1(4 downto 0))));
		readData2 <= rmem(to_integer(unsigned(readReg2(4 downto 0))));
	end if;
	end process;

end architecture;
