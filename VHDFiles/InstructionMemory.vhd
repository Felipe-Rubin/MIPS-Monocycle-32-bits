-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  InstructionMemory.vhd
-- Description: Represents the instruction memory that will
-- be read in falling edge

library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

--
entity InstructionMemory is
	port (
		clk, rst : in std_logic;
		address : in std_logic_vector(31 downto 0);
		instr_out : out std_logic_vector(31 downto 0)
	);
end entity;
architecture aim of InstructionMemory is
	-- We followed Mars Mips memory for our study.
	-- As a consequence, our instruction memory begins at 0x00400000 untill 0x0FFFFFFF

	
	-- Please, change the length of this array if needed
	-- with 20 positions it only support 20 instructions, but it
	-- can be pretty much any valid number witin VHDL grounds.
	type instr_mem is array(0 to 20) of std_logic_vector(31 downto 0);
	signal imem : instr_mem := (others => (others => '0'));

begin
	process
		file file_pointer : text;
		variable line_content : string (1 to 32);
		variable line_num : line;
		variable i : integer := 0;
		variable j : integer := 0;
		variable char : character := '0';
	begin
		-- Explicit path to the instruction text file.
		-- Please change it before simulating as it wont work.
		-- The file should be .text (whe only tried this).
		-- each line is the instruction with its 32 bits
		file_open(file_pointer, "/home/15105085/Desktop/trab/TrabISE/instructions.txt", READ_MODE);
		while not endfile (file_pointer) loop
			readline(file_pointer, line_num);
			READ(line_num, line_content);

			for j in 1 to 32 loop
				char := line_content(j);
				if (char = '0') then
					imem(i)(32 - j) <= '0';
				else
					imem(i)(32 - j) <= '1';
				end if;
			end loop;
			i := i + 1;
		end loop;
		file_close(file_pointer); -- Close the file
		wait;
	end process;

	process (clk, rst)
	begin
		if rst = '1' then
			instr_out <= "00000000000000000000000000000000";
		elsif clk'EVENT and clk = '0' then
			-- This assert can be changed if you like.
			-- The reason it is here is that we couldn't find a way 
			-- in VHDL to stop the simulation when it should end.
			-- So, if it tries to access a bigger position in memory
			-- than there is instructions in, it throws an error
			-- which isn't exacly an error, but a way of saying 
			-- the Simulation ended properly.
				assert (( (to_integer(unsigned(address)) mod 4194304)/4) < instr_mem'LENGTH)
				report  "Simulation has ended"
				severity ERROR;
			instr_out <= imem((to_integer(unsigned(address)) mod 4194304)/4);
		end if;
	end process;
end architecture;