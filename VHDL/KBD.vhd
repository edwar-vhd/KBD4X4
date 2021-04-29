-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Author: Edwar Javier Patiño Núñez
--
-- Create Date: 01/06/2020
-- Project Name: KBD
-- Description:
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KBD is
	port(
		key_to_press	:in std_logic_vector(3 downto 0);
		column			:in std_logic_vector(3 downto 0);
		
		row				:out std_logic_vector(3 downto 0)
	);
end entity;

architecture behav of KBD is
	type matrix is array (3 downto 0) of std_logic_vector(3 downto 0);
	signal keyboard 	:matrix := (others=>(others=>'0'));
	signal dec_rows	:std_logic_vector(3 downto 0);
begin
	---------------------------------------------------------
	-- Decoder
	---------------------------------------------------------	
	decoder: process(key_to_press)
	begin
		dec_rows <= (others => '1');
		dec_rows(to_integer(unsigned(key_to_press(3 downto 2)))) <= '0';
	end process;
	
	---------------------------------------------------------
	-- Matrix of logic gates
	---------------------------------------------------------	
	matrix_gates: process(dec_rows, column)
	begin
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				keyboard(i)(j) <= dec_rows(i) or column(j);
			end loop;
		end loop;
	end process;
	
	---------------------------------------------------------
	-- Output multiplexers
	---------------------------------------------------------	
	row(3) <= keyboard(3)(to_integer(unsigned(key_to_press(1 downto 0))));
	row(2) <= keyboard(2)(to_integer(unsigned(key_to_press(1 downto 0))));
	row(1) <= keyboard(1)(to_integer(unsigned(key_to_press(1 downto 0))));
	row(0) <= keyboard(0)(to_integer(unsigned(key_to_press(1 downto 0))));
end architecture;