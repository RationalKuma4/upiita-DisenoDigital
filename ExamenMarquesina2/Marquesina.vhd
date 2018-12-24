library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Marquesina is Port
(
	--Reloj
	clk : inout std_logic;
	led, ledM : inout std_logic;
	--VerifcaEstados
	z, y : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0);
	s1 : inout std_logic
);
end Marquesina;

architecture MarquesinaArq of Marquesina is
	type estados is (d0, d1, d2, d3);
	type estadosPaso is (e0, e1, e2, e3);
	signal edoPresente, edoFuturo :  estados; 
	signal pasoPresente, pasoFuturo : estadosPaso;
	--signal cnt: std_logic_vector(0 to 25);
	signal cnt: std_logic_vector(0 to 18);
	--signal cntMensaje: std_logic_vector(0 to 18);
	signal cntMensaje: std_logic_vector(0 to 25);
begin

	Reloj: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt = 166667) then
			--if(cnt = 2500000) then
				led <= '1';
			else
				cnt <= (cnt + 1);
			end if;
			if(cnt = 333333) then
			--if(cnt = 50000000) then
				led <= '0';
				--cnt <= "00000000000000000000000000";
				cnt <= "0000000000000000000";
			else
				cnt <= (cnt + 1);
			end if;
		end if;
	end Process Reloj;
	
	RelojMensaje: Process (clk) begin
		if(clk 'event and clk = '1') then
			--if(cntMensaje = 166667) then
			if(cntMensaje = 2500000) then
				ledM <= '1';
			else
				cntMensaje <= (cntMensaje + 1);
			end if;
			--if(cntMensaje = 333333) then
			if(cntMensaje = 5000000) then
				ledM <= '0';
				cntMensaje <= "00000000000000000000000000";
				--cntMensaje <= "0000000000000000000";
			else
				cntMensaje <= (cntMensaje + 1);
			end if;
		end if;
	end Process RelojMensaje;
	
	MuestraMensaje:Process(pasoPresente)begin
		case pasoPresente is
			when e0 => y <= "00";
				pasoFuturo <= e1;
			when e1 => y <= "01";
				pasoFuturo <= e2;
			when e2 => y <= "10";
				pasoFuturo <= e3;
			when e3 => y <= "11";
				pasoFuturo <= e0;
		end case;
	end process MuestraMensaje;
	
	VerificaEstado:Process(edoPresente, s1) begin
		case edoPresente is
			when d0 => z <= "00";
				if(s1 = '0') then 
					edoFuturo <= d1;
				else
					edoFuturo <= d3;
				end if;
			when d1 => z <= "01";
				if(s1 = '0') then
					edoFuturo <= d2;
				else
					edoFuturo <= d0;
				end if; 
			when d2 => z <= "10";
				if(s1 = '0') then
					edoFuturo <= d3;
				else
					edoFuturo <= d1;
				end if; 
			when d3 => z <= "11";
				if(s1 = '0') then
					edoFuturo <= d0;
				else
					edoFuturo <= d2;
				end if; 
		end case;
	end Process VerificaEstado;
	
	SelectorDisplay: process (z) begin
		if (z = "00")then
			ds <= "0000";
		elsif (z = "01") then
			ds <= "0001";
		elsif (z = "10") then
			ds <= "0011";
		else
			ds <= "0111";
		end if;
--		if(z = "00") then 
--			if (y = "00")then
--				ds <= "1110";
--			elsif (y = "01") then
--				ds <= "1101";
--			elsif (y = "10") then
--				ds <= "1011";
--			else
--				ds <= "0111";
--			end if;
--		elsif(z = "01") then
--			if (y = "00")then
--				ds <= "1101";
--			elsif (y = "01") then
--				ds <= "1011";
--			elsif (y = "10") then
--				ds <= "0111";
--			else
--				ds <= "1110";
--			end if;
--		elsif(z = "10") then
--			if (y = "00")then
--				ds <= "1011";
--			elsif (y = "01") then
--				ds <= "0111";
--			elsif (y = "10") then
--				ds <= "1110";
--			else
--				ds <= "1101";
--			end if;
--		else
--			if (y = "00")then
--				ds <= "0111";
--			elsif (y = "01") then
--				ds <= "1110";
--			elsif (y = "10") then
--				ds <= "1101";
--			else
--				ds <= "1011";
--			end if;
--		end if;
	end process SelectorDisplay;
	
	Display:Process(y) begin
		if(y = "00") then
			dis0 <= "11110000";
		elsif(y = "01") then
			dis0 <= "10000110";
		elsif(y = "10") then
			dis0 <= "10010010";
		else
			dis0 <= "10010010";
		end if;
			
--		if(z = "00") then 
--			if(y = "00") then
--				dis0 <= "11110000";
--			elsif(y = "01") then
--				dis0 <= "10000110";
--			elsif(y = "10") then
--				dis0 <= "10010010";
--			else
--				dis0 <= "10010010";
--			end if;
--		elsif(z = "01") then
--			if(y = "00") then
--				dis0 <= "10010010";
--			elsif(y = "01") then
--				dis0 <= "11110000";
--			elsif(y = "10") then
--				dis0 <= "10000110";
--			else
--				dis0 <= "10010010";
--			end if;
--		elsif(z = "10") then
--			if(y = "00") then
--				dis0 <= "10010010";
--			elsif(y = "01") then
--				dis0 <= "10010010";
--			elsif(y = "10") then
--				dis0 <= "11110000";
--			else
--				dis0 <= "10000110";
--			end if;
--		else
--			if(y = "00") then
--				dis0 <= "10000110";
--			elsif(y = "01") then
--				dis0 <= "10010010";
--			elsif(y = "10") then
--				dis0 <= "10010010";
--			else
--				dis0 <= "11110000";
--			end if;
--		end if;
	end process Display;
	
	CambioEstado:Process(led) begin
		if(led 'event and led = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;
	
	CambioPaso:Process(ledM) begin
		if(ledM 'event and ledM = '1') then
			pasoPresente <= pasoFuturo;
		end if;
	end Process CambioPaso;

end MarquesinaArq;

