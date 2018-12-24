library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Marquesina is Port
(
	--Reloj
	clk, x : inout std_logic;
	ledP, ledM : inout std_logic;
	--VerifcaEstados
	z, y : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Marquesina;

architecture MarquesinaArq of Marquesina is
	type estados is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo, presente, futuro : estados;
	signal cntPasos: std_logic_vector(0 to 25);
	signal cntMensaje: std_logic_vector(0 to 18);
begin
	RelojPasos: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cntPasos = 2500000) then
				ledP <= '1';
			else
				cntPasos <= (cntPasos + 1);
			end if;
			if(cntPasos = 50000000) then
				ledP <= '0';
				cntPasos <= "00000000000000000000000000";
			else
				cntPasos <= (cntPasos + 1);
			end if;
		end if;
	end Process RelojPasos;
	
	RelojMensaje: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cntMensaje = 166667) then
				ledM <= '1';
			else
				cntMensaje <= (cntMensaje + 1);
			end if;
			if(cntMensaje = 333333) then
				ledM <= '0';
				cntMensaje <= "0000000000000000000";
			else
				cntMensaje <= (cntMensaje + 1);
			end if;
		end if;
	end Process RelojMensaje;
	
	VerificaPaso:Process(edoPresente, x) begin
		case edoPresente is
			when d0 => z <= "00";
				if(x = '0') then 
					edoFuturo <= d1;
				else
					edoFuturo <= d3;
				end if;
			when d1 => z <= "01";
				if(x = '0') then
					edoFuturo <= d2;
				else
					edoFuturo <= d0;
				end if; 
			when d2 => z <= "10";
				if(x = '0') then
					edoFuturo <= d3;
				else
					edoFuturo <= d1;
				end if; 
			when d3 => z <= "11";
				if(x = '0') then
					edoFuturo <= d0;
				else
					edoFuturo <= d2;
				end if; 
		end case;
	end Process VerificaPaso;
	
	VerificaPresente:Process(presente)begin
		case presente is
			when d0 => y <= "00";
				futuro <= d1;
			when d1 => y <= "01";
				futuro <= d2;
			when d2 => y <= "10";
				futuro <= d3;
			when d3 => y <= "11";
				futuro <= d0;
		end case;
	end process VerificaPresente;
	
	SelectorDisplay: process (y, z) begin
		if(z = "00") then
			if (y = "00")then
				ds <= "1110";
			elsif (y = "01") then
				ds <= "1101";
			elsif (y = "10") then
				ds <= "1011";
			else
				ds <= "0111";
			end if;
		elsif(z = "01") then
			if (y = "00")then
				ds <= "1101";
			elsif (y = "01") then
				ds <= "1011";
			elsif (y = "10") then
				ds <= "0111";
			else
				ds <= "1111";
			end if;
		elsif(z = "10") then
			if (y = "00")then
				ds <= "1011";
			elsif (y = "01") then
				ds <= "0111";
			elsif (y = "10") then
				ds <= "1111";
			else
				ds <= "1111";
			end if;
		else
			if (y = "00")then
				ds <= "0111";
			elsif (y = "01") then
				ds <= "1111";
			elsif (y = "10") then
				ds <= "1111";
			else
				ds <= "1111";
			end if;
		end if;
	end process SelectorDisplay;
	
	Display:Process(y) begin
		if(y = "00") then
			dis0 <= "10001001";
		elsif(y = "01") then
			dis0 <= "11000000";
		elsif(y = "10") then
			dis0 <= "11000111";
		else
			dis0 <= "10001000";
		end if;
	end process Display;
	
	CambioPaso:Process(ledP) begin
		if(ledP 'event and ledP = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioPaso;
	
	CambioMensaje:Process(ledM) begin
		if(ledM 'event and ledM = '1') then
			presente <= futuro;
		end if;
	end Process CambioMensaje;

end MarquesinaArq;

