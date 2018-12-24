library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Reloj1k is Port
(
	--Reloj
	clk : in std_logic;
	led : inout std_logic
);
end Reloj1k;

architecture Behavioral of Reloj1k is
	--1k
	signal cnt1k: std_logic_vector(0 to 15);
begin
	Reloj1k: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt1k = 25000) then
				led <= '1';
			else
				cnt1k <= (cnt1k + 1);
			end if;
			if(cnt1k = 50000) then
				led <= '0';
				cnt1k <= "0000000000000000";
			else
				cnt1k <= (cnt1k + 1);
			end if;
		end if;
	end Process Reloj1k;
end Behavioral;

