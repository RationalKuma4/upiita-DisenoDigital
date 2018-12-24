library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Bomba is Port
(
	sA, sB, sC, ledM: inout std_logic;
	entrada, salida : out std_logic;
	sResetH : in std_logic;
	--Display
	clk : in std_logic;
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0);
	z : inout std_logic_vector(0 to 1)
);
end Bomba;

architecture BombaArq of Bomba is
	type TipoEstados is (e0, e1, e2, e3);
	signal tEstadoActual, tEstadoSiguiente : TipoEstados;
	---------Display-------------------------------
	signal cntM: std_logic_vector(0 to 18);
	type estadosM is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo : estadosM;
begin
	RelojMensaje: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cntM = 166667) then
				ledM <= '1';
			else
				cntM <= (cntM + 1);
			end if;
			if(cntM = 333333) then
				ledM <= '0';
				cntM <= "0000000000000000000";
			else
				cntM <= (cntM + 1);
			end if;
		end if;
	end Process RelojMensaje;
	
	------------------Estados-----------------------
	VerificaEstado:Process(edoPresente) begin
		case edoPresente is
			when d0 => z <= "00";
				edoFuturo <= d1;
			when d1 => z <= "01";
				edoFuturo <= d2;
			when d2 => z <= "10";
				edoFuturo <= d3;
			when d3 => z <= "11";
				edoFuturo <= d0;
		end case;
	end Process VerificaEstado;
	
	LogicaEstado:Process(tEstadoActual, sA, sB, sC) begin
		case(tEstadoActual) is
			when e0 =>
				if(sA = '0' and sB = '0' and sC = '1') then 
					tEstadoSiguiente <= e1;
					entrada <= '1';
					salida <= '0';
				else
					tEstadoSiguiente <= e0;
					entrada <= '1';
				salida <= '0';
				end if;
			when e1 =>
				if(sA = '0' and sB = '1' and sC = '1') then 
					tEstadoSiguiente <= e2;
					entrada <= '1';
					salida <= '1';
				else
					tEstadoSiguiente <= e1;
					entrada <= '1';
				salida <= '1';
				end if;
			when e2 =>
				if(sA = '1' and sB = '1' and sC = '1') then 
					tEstadoSiguiente <= e3;
					entrada <= '0';
					salida <= '1';
				else
					tEstadoSiguiente <= e2;
					entrada <= '0';
					salida <= '1';
				end if;
			when e3 =>
				if(sA = '0' and sB = '0' and sC = '0') then 
					tEstadoSiguiente <= e0;
					entrada <= '0';
					salida <= '1';
				else
					tEstadoSiguiente <= e3;
					entrada <= '0';
					salida <= '1';
				end if;
		end case;
	end process LogicaEstado;

	-------Display-------------------------------------
	SelectorDisplay: process (z) begin
		if (z = "00")then
			ds <= "1110";
		elsif (z = "01")then
			ds <= "1101";
		elsif (z = "10")then
			ds <= "1011";
		else 
			ds <= "0111";
		end if;
	end process SelectorDisplay;
	
	Display:Process(tEstadoActual, z) begin
		if (z = "00")then
			if(tEstadoActual = e0) then
				dis0 <= "11000001";
			elsif(tEstadoActual = e1) then
				dis0 <= "10101011";
			elsif(tEstadoActual = e2) then
				dis0 <= "11111001";
			else
				dis0 <= "10001000";
			end if;
		elsif (z = "01")then
			if(tEstadoActual = e0) then
				dis0 <= "11000110";
			elsif(tEstadoActual = e1) then
				dis0 <= "11000000";
			elsif(tEstadoActual = e2) then
				dis0 <= "11111001";
			else
				dis0 <= "11000111";
			end if;
		elsif (z = "10")then
			if(tEstadoActual = e0) then
				dis0 <= "11111001";
			elsif(tEstadoActual = e1) then
				dis0 <= "10101111";
			elsif(tEstadoActual = e2) then
				dis0 <= "10101011";
			else
				dis0 <= "10101111";
			end if;
		else 
			if(tEstadoActual = e0) then
				dis0 <= "11000000";
			elsif(tEstadoActual = e1) then
				dis0 <= "11111001";
			elsif(tEstadoActual = e2) then
				dis0 <= "11000000";
			else
				dis0 <= "10000110";
			end if;
		end if;
	
--		if(z = "00") then
--			dis0 <= "10000110";
--		else
--			if(tEstadoActual = e0) then
--				dis0 <= "11000000";
--			elsif(tEstadoActual = e1) then
--				dis0 <= "11111001";
--			elsif(tEstadoActual = e2) then
--				dis0 <= "10100100";
--			else
--				dis0 <= "10110000";
--			end if;
--		end if;
	end process Display;
	
	-------Cambio estados----------------------------
	MemoriaEstado:Process(sResetH, tEstadoSiguiente) begin
		if(sResetH = '1') then
			tEstadoActual <= e0;
		else
			tEstadoActual <= tEstadoSiguiente;
		end if;
	end process MemoriaEstado;
	
	CambioEstado:Process(ledM) begin
		if(ledM 'event and ledM = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;
		
end BombaArq;

