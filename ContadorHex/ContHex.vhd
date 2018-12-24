----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:10:34 10/27/2016 
-- Design Name: 
-- Module Name:    ContHex - Arq_ContHex 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ContHex is Port(
	clk : in std_logic;
	o: inout std_logic;
	led : inout std_logic;
	y : inout STD_LOGIC_VECTOR(7 DOWNTO 0);
	ds : out STD_LOGIC_VECTOR(3 DOWNTO 0)
);
end ContHex;

architecture Arq_ContHex of ContHex is
	signal a: std_logic_vector(4 downto 0);
	signal cnt: std_logic_vector(0 to 25);
begin
	reloj: process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt = 25000000) then
				led <= '1';
				o <= '1';
			else
				cnt <= (cnt + 1);
			end if;
			if(cnt = 50000000) then
				led <= '0';
				o <= '0';
				cnt <= "00000000000000000000000000";
			else
				cnt <= (cnt + 1);
			end if;
		end if;
	end process reloj;
	
	selector: process (a) begin
		if (a < "00110") then
			ds <= "0111";
		elsif (a < "01010") then
			ds <= "1011";
		elsif (a < "01100") then
			ds <= "1101";
		else
			ds <= "1110";
		end if;
	end process selector;
	
	Deco:Process(a) begin
	begin
		if(a="00000") then
			y <= "11000000";
		elsif(a="00001") then
			y <= "11111001";
		elsif(a="00010") then
			y <= "10100100";
		elsif(a="00011") then
			y <= "10110000";
		elsif(a="00100") then
			y <= "10011001";
		elsif(a="00101") then
			y <= "10010010";
		elsif(a="00110") then
			y <= "10000010";
		elsif(a="00111") then
			y <= "11111000";
		elsif(a="01000") then
			y <= "10000000";
		elsif(a="01001") then
			y <= "10011000";
		elsif(a="01010") then
			y <= "10001000";
		elsif(a="01011") then
			y <= "10000011";
		elsif(a="01100") then
			y <= "11000110";
		elsif(a="01101") then
			y <= "10100001";
		elsif(a="01110") then
			y <= "10000110";
		else
			y <= "10001110";
		end if;
	end process Deco;
	end process Deco;
end Arq_ContHex;

