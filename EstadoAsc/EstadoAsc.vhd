library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity EstadoAsc is Port
(
	clk, x : inout std_logic;
	led : inout std_logic;
	z : out std_logic_vector(0 to 1)
);
end EstadoAsc;

architecture Arq_EstadoAsc of EstadoAsc is
	type estados is (d0, d1, d2, d3);
	signal edoPresente, edoFuturo : estados;
	signal cnt: std_logic_vector(0 to 25);
begin
	Proceso1:Process(edoPresente, x) begin
		case edoPresente is
			when d0 => z <= "00";
				if(x = '1') then 
					edoFuturo <= d1;
				else
					--edoFuturo <= d0;
					edoFuturo <= d3;
				end if;
			when d1 => z <= "01";
				if(x = '1') then
					edoFuturo <= d2;
				else
					--edoFuturo <= d1;
					edoFuturo <= d2;
				end if; 
			when d2 => z <= "10";
				if(x = '1') then
					--edoFuturo <= d3;
					edoFuturo <= d0;
				else
					--edoFuturo <= d2;
					edoFuturo <= d0;
				end if; 
			when d3 => z <= "11";
				if(x = '1') then
					edoFuturo <= d0;
				else
					--edoFuturo <= d3;
					edoFuturo <= d0;
				end if; 
		end case;
	end process Proceso1;
	
	reloj: process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt = 25000000) then
				led <= '1';
			else
				cnt <= (cnt + 1);
			end if;
			if(cnt = 50000000) then
				led <= '0';
				cnt <= "00000000000000000000000000";
			else
				cnt <= (cnt + 1);
			end if;
		end if;
	end process reloj;
	
	Proceso2:Process(led) begin
		if(led 'event and led = '1') then
			edoPresente <= edoFuturo;
		end if;
	end process Proceso2;
	
end Arq_EstadoAsc;

