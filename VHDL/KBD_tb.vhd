-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Author: Edwar Javier Patiño Núñez
--
-- Create Date: 01/06/2020
-- Project Name: KBD_tb
-- Description:
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;

entity KBD_tb is 
end entity;

architecture behav of KBD_tb is
	-- Testbench internal signals
	signal key_to_press	:std_logic_vector(3 downto 0) := (others => '0');
	signal column			:std_logic_vector(3 downto 0) := (others => '0');

	signal row				:std_logic_vector(3 downto 0);
	
	signal key_pressed  	:character;
	signal key_code		:std_logic_vector(7 downto 0);
	
	type mode is (Scanning, Detected);
	signal s_mode 			:mode := Scanning;
begin
	---------------------------------------------------------
	-- Instantiate and map the design under test 
	---------------------------------------------------------	
	DUT: entity work.KBD
		port map(
			key_to_press	=> key_to_press,
			column			=> column,
		              
		   row				=> row
		);

	-- WR signal generation
	key_to_press_gen: process
	begin
		key_to_press <= "0000";
		wait for 4 us;
		key_to_press <= "0101";
		wait for 4 us;
		key_to_press <= "1010";
		wait for 4 us;
		key_to_press <= "1111";
		wait for 4 us;
	end process;
		
	-- Input data
	column_gen: process
	begin
		column <= "1110";
		wait for 1 us;
		column <= "1101";
		wait for 1 us;
		column <= "1011";
		wait for 1 us;
		column <= "0111";
		wait for 1 us;
	end process;

	-- Write state keyboard
	s_mode <= Detected when row /= "1111" else Scanning;
	
	key_code <= row & column;
	
	with key_code select
		key_pressed <= 	'1' when "11101110",
								'2' when "11101101",
								'3' when "11101011",
								'A' when "11100111",
								'4' when "11011110",
								'5' when "11011101",
								'6' when "11011011",
								'B' when "11010111",
								'7' when "10111110",
								'8' when "10111101",
								'9' when "10111011",
								'C' when "10110111",
								'*' when "01111110",
								'0' when "01111101",
								'#' when "01111011",
								'D' when "01110111",
								nul when others;
end architecture;