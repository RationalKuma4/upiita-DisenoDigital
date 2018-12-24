library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.all;

entity Relojes is Port
(
	--Reloj
	clk, x : inout std_logic;
	led : inout std_logic;
	salida : inout std_logic;
	seg : inout std_logic_vector(0 to 1);
	--VerifcaEstados
	z : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0);
	--Selectores
	s0 : in std_logic;
	s1 : in std_logic
);
end Relojes;

architecture RelojesArq of Relojes is
	type estados is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo : estados;
	signal cnt: std_logic_vector(0 to 25);
	signal cntDisplay: std_logic_vector(0 to 18);
	signal contadorTope: integer range 0 to 50000000;
	signal contadorMedio: integer range 0 to 25000000;
begin
	AsignaFrecuencia:Process begin
		if(s0 = '0' and s1 = '0') then
			seg <= "00";
--			contadorTope <= 50000000;
--			contadorMedio <= 25000000;
			if(clk 'event and clk = '1') then
				if(cnt = 25000000) then
					salida  <= '1';
				else
					cnt <= (cnt + 1);
				end if;
				if(cnt = 50000000) then
					salida  <= '0';
					cnt <= "00000000000000000000000000";
				else
					cnt <= (cnt + 1);
				end if;
			end if;
		elsif(s0 = '0' and s1 = '1') then
			if(clk 'event and clk = '1') then
				if(cnt = 2500000) then
					salida  <= '1';
				else
					cnt <= (cnt + 1);
				end if;
				if(cnt = 5000000) then
					salida  <= '0';
					cnt <= "00000000000000000000000000";
				else
					cnt <= (cnt + 1);
				end if;
			end if;
			seg <= "01";
--			contadorTope <= 5000000;
--			contadorMedio <= 2500000;
		elsif(s0 = '1' and s1 = '0') then
			if(clk 'event and clk = '1') then
				if(cnt = 250000) then
					salida  <= '1';
				else
					cnt <= (cnt + 1);
				end if;
				if(cnt = 500000) then
					salida  <= '0';
					cnt <= "00000000000000000000000000";
				else
					cnt <= (cnt + 1);
				end if;
			end if;
			seg <= "10";
--			contadorTope <= 500000;
--			contadorMedio <= 250000;
		else
			if(clk 'event and clk = '1') then
				if(cnt = 25000) then
					salida  <= '1';
				else
					cnt <= (cnt + 1);
				end if;
				if(cnt = 50000) then
					salida  <= '0';
					cnt <= "00000000000000000000000000";
				else
					cnt <= (cnt + 1);
				end if;
			end if;
			seg <= "11";
--			contadorTope <= 50000;
--			contadorMedio <= 25000;
		end if;
	end Process AsignaFrecuencia;

--	RelojSalida: Process (clk) begin
--		if(clk 'event and clk = '1') then
--			if(cnt = contadorMedio) then
--				salida  <= '1';
--			else
--				cnt <= (cnt + 1);
--			end if;
--			if(cnt = contadorTope) then
--				salida  <= '0';
--				cnt <= "00000000000000000000000000";
--			else
--				cnt <= (cnt + 1);
--			end if;
--		end if;
--	end Process RelojSalida;
	
	RelojDisplay: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cntDisplay = 166667) then
				led <= '1';
			else
				cntDisplay <= (cntDisplay + 1);
			end if;
			if(cntDisplay = 333334) then
				led <= '0';
				cntDisplay <= "0000000000000000000";
			else
				cntDisplay <= (cntDisplay+ 1);
			end if;
		end if;
	end Process RelojDisplay;
	
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
		if(s0 = '0' and s1 = '0') then
			if(z = "00") then
				dis0 <= "11111001";
			elsif(z = "01") then
				dis0 <= "10001001";
			elsif(z = "10") then
				dis0 <= "11111111";
			else
				dis0 <= "11111111";
			end if;
		elsif(s0 = '0' and s1 = '1') then
			if(z = "00") then
				dis0 <= "11111001";
			elsif(z = "01") then
				dis0 <= "11000000";
			elsif(z = "10") then
				dis0 <= "10001001";
			else
				dis0 <= "11111111";
			end if;
		elsif(s0 = '1' and s1 = '0') then
			if(z = "00") then
				dis0 <= "11111001";
			elsif(z = "01") then
				dis0 <= "11000000";
			elsif(z = "10") then
				dis0 <= "11000000";
			else
				dis0 <= "10001001";
			end if;
		else
			if(z = "00") then
				dis0 <= "11111001";
			elsif(z = "01") then
				dis0 <= "10001011";
			elsif(z = "10") then
				dis0 <= "10001001";
			else
				dis0 <= "11111111";
			end if;
		end if;
	end process Display;
	
	CambioEstado:Process(led) begin
		if(led 'event and led = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;

end RelojesArq;

