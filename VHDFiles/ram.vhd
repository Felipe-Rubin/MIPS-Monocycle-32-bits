-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  ram.vhd
-- Description: Memory to be pre-loaded at the start of the simulation
-- the file should be a  .text with binary (32 bits) data on it.

library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use Std.textio.all;
entity ram is
	port (
		address, writeData : in std_logic_vector(31 downto 0);
		readData : out std_logic_vector(31 downto 0);
		memWrite, memRead, clk, rst : in std_logic
	);
end entity;
architecture aram of ram is
	-- Array that represents the memory, please change if the memory
	-- is bigger than 190 lines
	type data_mem is array(0 to 190) of std_logic_vector(31 downto 0);
	signal dmem : data_mem := (others => (others => '0'));
	signal arqLido : std_logic := '0';
begin
	process (clk, rst, address, writeData, memRead, memWrite)
	file file_pointer : text;
	variable line_content : string (1 to 32);
	variable line_num : line;
	variable i : integer := 0;
	variable j : integer := 0;
	variable char : character := '1';
	begin
		if rst = '1' and arqLido = '0' then
			-- This should be changed to the right one
			-- The file should be a .text file (as we just verified this type)
			-- each line is a 32 bit, regardless if its only 0's
			file_open(file_pointer, "/home/15105085/Desktop/trab/TrabISE/data.txt", READ_MODE);
			while not endfile (file_pointer) loop
			readline(file_pointer, line_num);
			READ(line_num, line_content);
 
			for j in 1 to 32 loop
				char := line_content(j);
				if (char = '1') then
					dmem(i) (32 - j) <= '1';
				else
					dmem(i) (32 - j) <= '0';
				end if;
			end loop;
			i := i + 1;
		end loop;
		file_close(file_pointer); -- Close the file
		arqLido <= '1';
	elsif clk'EVENT and clk = '1' then
		if memWrite = '1' then
			dmem((to_integer(unsigned(address)) mod 268500992)/4) <= writeData;
		elsif memRead = '1' then
			readData <= dmem((to_integer(unsigned(address)) mod 268500992)/4);
		end if;

	end if;
	end process;

end architecture;