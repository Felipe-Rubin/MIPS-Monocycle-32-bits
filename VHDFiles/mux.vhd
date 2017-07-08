-- T2 Organizacao e Arquitetura de Computadores I
-- Year 2017/1
-- Members: Felipe Rubin, Yuri Bittencourt, Vinicius Cerutti
-- File:  mux.vhd
-- Description: Generic implementation of a MUX
-- input 2 vectors and a signal to choose, outputs its choice.
-- 'n' defines how many bits the inputs and outputs should be

library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
generic  (n: integer:= 5);
    port( 
    		e0 : in  STD_LOGIC_VECTOR(n -1 downto 0);
        	e1 : in  STD_LOGIC_VECTOR(n -1 downto 0);
			s1 : out  STD_LOGIC_VECTOR(n -1 downto 0);
			sel : in  STD_LOGIC
		);
end mux;

architecture bhr of mux is

begin
	s1 <= e0 when(sel='0') else e1;
end architecture;

