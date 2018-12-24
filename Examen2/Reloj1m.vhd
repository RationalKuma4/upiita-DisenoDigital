library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Reloj1m is Port
(
	--Reloj
	clk : in std_logic;
	led : inout std_logic
);
end Reloj1m;

architecture Behavioral of Reloj1m is
	--1m
	signal cnt1m: std_logic_vector(0 to 5);
begin
	Reloj1m: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt1m = 25) then
				led <= '1';
			else
				cnt1m <= (cnt1m + 1);
			end if;
			if(cnt1m = 50) then
				led <= '0';
				cnt1m <= "000000";
			else
				cnt1m <= (cnt1m + 1);
			end if;
		end if;
	end Process Reloj1m;
end Behavioral;

