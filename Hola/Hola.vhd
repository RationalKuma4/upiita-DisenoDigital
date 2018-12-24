library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Hola is Port
(
	--Reloj
	clk, x : inout std_logic;
	led : inout std_logic;
	--VerifcaEstados
	z : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Hola;

architecture Arq_Hola of Hola is 
	type estados is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo : estados;
	signal cnt: std_logic_vector(0 to 25);
	--signal cnt: std_logic_vector(0 to 18);
begin

	Reloj: Process (clk) begin
		if(clk 'event and clk = '1') then
			--if(cnt = 166667) then
			if(cnt = 2500000) then
				led <= '1';
			else
				cnt <= (cnt + 1);
			end if;
			--if(cnt = 333333) then
			if(cnt = 50000000) then
				led <= '0';
				cnt <= "00000000000000000000000000";
				--cnt <= "0000000000000000000";
			else
				cnt <= (cnt + 1);
			end if;
		end if;
	end Process Reloj;
	 
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
				ds <= "1110";
			elsif (z = "01") then
				ds <= "1101";
			elsif (z = "10") then
				ds <= "1011";
			else
				ds <= "0111";
			end if;
	end process SelectorDisplay;
	
	Display:Process(z) begin
		if(z = "00") then
			dis0 <= "10001001";
		elsif(z = "01") then
			dis0 <= "11000000";
		elsif(z = "10") then
			dis0 <= "11000111";
		else
			dis0 <= "10001000";
		end if;
	end process Display;
	
	CambioEstado:Process(led) begin
		if(led 'event and led = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;

end Arq_Hola;

