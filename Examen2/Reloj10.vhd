library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Reloj10 is Port
(
	--Reloj
	clk : in std_logic;
	led : inout std_logic
);
end Reloj10;

architecture Behavioral of Reloj10 is
	--10
	signal cnt10: std_logic_vector(0 to 25);
begin
	Reloj10: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt10 = 25000000) then
				led <= '1';
			else
				cnt10 <= (cnt10 + 1);
			end if;
			if(cnt10 = 50000000) then
				led <= '0';
				cnt10 <= "00000000000000000000000000";
			else
				cnt10 <= (cnt10 + 1);
			end if;
		end if;
	end Process Reloj10;
end Behavioral;

