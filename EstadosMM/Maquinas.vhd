library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL; 

entity Maquinas is Port
(
	sEntrada, sResetH, clk : in std_logic;
	sSalida1, sSalida2 : out std_logic;
	led : inout std_logic
	--Display
	--ds : out  STD_LOGIC_VECTOR(3 downto 0);
	--dis0 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Maquinas;

architecture MaquinasArq of Maquinas is
	type TipoEstados is (e0, e1, e2, e3, e4);
	signal tEstadoActual, tEstadoSiguiente : TipoEstados;
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

	LogicaEstado:Process(tEstadoActual, sEntrada) begin
		case(tEstadoActual) is
			when e0 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e1;
				else
					tEstadoSiguiente <= e4;
				end if;
			when e1 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e2;
				else
					tEstadoSiguiente <= e0;
				end if;
			when e2 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e3;
				else
					tEstadoSiguiente <= e1;
				end if;
			when e3 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e4;
				else
					tEstadoSiguiente <= e2;
				end if;
			when e4 =>
				if(sEntrada = '1') then 
					tEstadoSiguiente <= e0;
				else
					tEstadoSiguiente <= e3;
				end if;
		end case;
	end process LogicaEstado;
	
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
		
--	SelectorDisplay: process (z) begin
--			if (z = "00")then
--				ds <= "1110";
--			elsif (z = "01") then
--				ds <= "1101";
--			elsif (z = "10") then
--				ds <= "1011";
--			else
--				ds <= "0111";
--			end if;
--	end process SelectorDisplay;
--	
--	Display:Process(z) begin
--		if(z = "00") then
--			dis0 <= "10001001";
--		elsif(z = "01") then
--			dis0 <= "11000000";
--		elsif(z = "10") then
--			dis0 <= "11000111";
--		else
--			dis0 <= "10001000";
--		end if;
--	end process Display;
		
end MaquinasArq;

