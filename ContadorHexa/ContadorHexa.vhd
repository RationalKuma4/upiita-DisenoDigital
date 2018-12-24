----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:03 11/11/2016 
-- Design Name: 
-- Module Name:    ContadorHexa - Arq_ContadorHexa 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ContadorHexa is Port(
	clk : in  STD_LOGIC;
	ledSal : inout  STD_LOGIC;
	y : inout STD_LOGIC_VECTOR(7 DOWNTO 0);
	ds : out  STD_LOGIC_VECTOR(3 downto 0)
);
end ContadorHexa;

architecture Arq_ContadorHexa of ContadorHexa is
	signal a: std_logic_vector(3 downto 0);
	signal cnt: std_logic_vector(0 to 25);
begin
	CntReloj:Process(clk) begin
		if(clk 'event and clk = '1') then
			if(cnt = 25000000) then 
				ledSal <= '1';
			else
				cnt <= cnt + 1;
			end if;
			if(cnt = 50000000) then 
				ledSal <= '0';
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end Process CntReloj;
	
	ContadorBinario: process (ledSal)
	begin
		if (ledSal 'event and ledSal = '1') then
			if(a < "1111") then
				a <= (a + 1);
			else
				a <= "0000";
			end if;
		end if;
	end process ContadorBinario;
	
	SelectorDisplay: process (a) begin
			if (a<"00110")then
				ds<="0111";
			elsif (a<"01010") then
				ds<="1011";
			elsif (a<"01100") then
				ds<="1101";
			else
				ds<="1110";
			end if;
	end process SelectorDisplay;
	
	Display:Process(a) begin
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
	end process Display;

end Arq_ContadorHexa;

