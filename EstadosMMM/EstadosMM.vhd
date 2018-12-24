library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity EstadosMM is Port
(
	sEntrada, sResetH, clk : in std_logic;
	sSalida1, sSalida2 : out std_logic;
	led, ata, ledM : inout std_logic;
	z : inout std_logic_vector(0 to 1);
	--Display
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end EstadosMM;

architecture EstadosMMArq of EstadosMM is
	type TipoEstados is (e0, e1, e2, e3, e4);
	signal tEstadoActual, tEstadoSiguiente : TipoEstados;
	signal cnt: std_logic_vector(0 to 25);
	-----------------------------------------------
	signal cntM: std_logic_vector(0 to 18);
	type estadosM is (d0, d1);
	signal edoPresente, edoFuturo : estadosM;
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
	
	VerificaEstado:Process(edoPresente) begin
		case edoPresente is
			when d0 => z <= "00";
				edoFuturo <= d1;
			when d1 => z <= "01";
				edoFuturo <= d0;
		end case;
	end Process VerificaEstado;

	LogicaEstado:Process(tEstadoActual, sEntrada) begin
		case(tEstadoActual) is
			when e0 =>
				ata <= '0';
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e1;
				else
					tEstadoSiguiente <= e4;
				end if;
			when e1 =>
				ata <= '0';
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e2;
				else
					tEstadoSiguiente <= e4;
				end if;
			when e2 =>
				ata <= '0';
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e3;
				else
					tEstadoSiguiente <= e4;
				end if;
			when e3 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e3;
					ata <= '1';
				else
					tEstadoSiguiente <= e3;
					ata <= '1';
				end if;
			when e4 =>
				ata <= '0';
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e1;
				else
					tEstadoSiguiente <= e4;
				end if;
		end case;
	end process LogicaEstado;

	SelectorDisplay: process (z) begin
		if (z = "00")then
			ds <= "1110";
		else 
			ds <= "1101";
		end if;
	end process SelectorDisplay;
	
	Display:Process(tEstadoActual, z) begin
		if(z = "00") then
			dis0 <= "10000110";
		else
			if(tEstadoActual = e0) then
				dis0 <= "11000000";
			elsif(tEstadoActual = e1) then
				dis0 <= "11111001";
			elsif(tEstadoActual = e2) then
				dis0 <= "10100100";
			elsif(tEstadoActual = e3) then
				dis0 <= "10110000";
			else
				dis0 <= "10011001";
			end if;
		end if;
	end process Display;
	
	--------------Cambios Estados
	MemoriaEstado:Process(led, sResetH, tEstadoSiguiente) begin
		if(sResetH = '1') then
			tEstadoActual <= e0;
		elsif(rising_edge(led)) then
			tEstadoActual <= tEstadoSiguiente;
		end if;
	end process MemoriaEstado;
	
	sSalida1 <= '1'
		when (tEstadoActual = e2 and sEntrada = '1') 
		else '0';
	
	sSalida2 <= '1'
		when (tEstadoActual = e2)
		else '0';
	
	CambioEstado:Process(ledM) begin
		if(ledM 'event and ledM = '1') then
			edoPresente <= edoFuturo;
		end if;
	end Process CambioEstado;

end EstadosMMArq;

