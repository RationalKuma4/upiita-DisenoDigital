library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Examen is Port
(
	--Reloj
	clk, x : inout std_logic;
	led : inout std_logic;
	--VerifcaEstados
	z : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0);
	dis1 : inout STD_LOGIC_VECTOR(7 downto 0);
	dis2 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Examen;

architecture Behavioral of Examen is
	type estados is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo : estados;
	--10
	signal cnt10: std_logic_vector(0 to 22);
	--100
	signal cnt100: std_logic_vector(0 to 18);
	--1k
	signal cnt1k: std_logic_vector(0 to 15);
	--1m
	signal cnt1m: std_logic_vector(0 to 5);
	
	--1
	signal cnt_1: std_logic_vector(0 to 25);
	--3
	signal cnt_3: std_logic_vector(0 to 23);
	--5
	signal cnt_5: std_logic_vector(0 to 22);
	--10
	signal cnt_10: std_logic_vector(0 to 22);
begin
	VerificaEstado:Process(edoPresente, x) begin
		case edoPresente is
			when d0 => z <= "00";
				if(x = '1') then 
					edoFuturo <= d1;
				else
					edoFuturo <= d0;
				end if;
			when d1 => z <= "01";
				if(x = '1') then
					edoFuturo <= d2;
				else
					edoFuturo <= d1;
				end if; 
			when d2 => z <= "10";
				if(x = '1') then
					edoFuturo <= d3;
				else
					edoFuturo <= d2;
				end if; 
			when d3 => z <= "11";
				if(x = '1') then
					edoFuturo <= d0;
				else
					edoFuturo <= d3;
				end if; 
		end case;
	end Process VerificaEstado;
	
	SelectorDisplay: process (z) begin
			if (z = "00")then
				ds <= "1100";
			elsif (z = "01") then
				ds <= "1000";
			elsif (z = "10") then
				ds <= "1100";
			else
				ds <= "1000";
			end if;
	end process SelectorDisplay;
	
	DisplayWrite:Process(z) begin
		if(z = "00") then
			dis0 <= "11111001";
			--dis1 <= "11000000";
		elsif(z = "01") then
			dis0 <= "11111001";
			--dis1 <= "11000000";
			--dis2 <= "11000000";
		elsif(z = "10") then
			dis0 <= "11111001";
			--dis1 <= "11000000";
		else
			dis0 <= "11111001";
			--dis1 <= "11000000";
			--dis2 <= "11000000";
		end if;
	end process DisplayWrite;
	
	CambioEstado:Process(led) begin
		if(led 'event and led = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;
	
	Reloj10: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt10 = 2500000) then
				led <= '1';
			else
				cnt10 <= (cnt10 + 1);
			end if;
			if(cnt10 = 5000000) then
				led <= '0';
				cnt10 <= "00000000000000000000000";
			else
				cnt10 <= (cnt10 + 1);
			end if;
		end if;
	end Process Reloj10;
	
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
	-----------------------------------------------------------
	Reloj_1: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt_1 = 25) then
				led <= '1';
			else
				cnt_1 <= (cnt_1 + 1);
			end if;
			if(cnt_1 = 50) then
				led <= '0';
				cnt_1 <= "00000000000000000000000000";
			else
				cnt_1 <= (cnt_1 + 1);
			end if;
		end if;
	end Process Reloj_1;
	
	Reloj_3: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt_3 = 25) then
				led <= '1';
			else
				cnt_3 <= (cnt_3 + 1);
			end if;
			if(cnt_3 = 50) then
				led <= '0';
				cnt_3 <= "000000000000000000000000";
			else
				cnt_3 <= (cnt_3 + 1);
			end if;
		end if;
	end Process Reloj_3;
	
	Reloj_5: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt_5 = 25) then
				led <= '1';
			else
				cnt_5 <= (cnt_5 + 1);
			end if;
			if(cnt_5 = 50) then
				led <= '0';
				cnt_5 <= "00000000000000000000000";
			else
				cnt_5 <= (cnt_5 + 1);
			end if;
		end if;
	end Process Reloj_5;
	
	Reloj_10: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt_10 = 25) then
				led <= '1';
			else
				cnt_10 <= (cnt_10 + 1);
			end if;
			if(cnt_10 = 50) then
				led <= '0';
				cnt_10<= "00000000000000000000000";
			else
				cnt_10 <= (cnt_10 + 1);
			end if;
		end if;
	end Process Reloj_10;
	
end Behavioral;

