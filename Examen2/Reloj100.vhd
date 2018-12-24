library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Reloj100 is Port
(
	--Reloj
	clk : in std_logic;
	led : inout std_logic
);
end Reloj100;

architecture Behavioral of Reloj100 is
	--100
	signal cnt100: std_logic_vector(0 to 18);
begin
	Reloj100: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt100 = 250000) then
				led <= '1';
			else
				cnt100 <= (cnt100 + 1);
			end if;
			if(cnt100 = 500000) then
				led <= '0';
				cnt100 <= "0000000000000000000";
			else
				cnt100 <= (cnt100 + 1);
			end if;
		end if;
	end Process Reloj100;
end Behavioral;

