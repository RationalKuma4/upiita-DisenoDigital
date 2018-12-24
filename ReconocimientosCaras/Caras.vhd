library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Caras is Port 
( 
	clk : in  STD_LOGIC;
	led: inout STD_LOGIC;
	a : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	b : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	c : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	d : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	e : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	h : out  STD_LOGIC_VECTOR(4 DOWNTO 0)
);
end Caras;

architecture CarasArq of Caras is
	signal cnt: std_logic_vector(0 to 25);
	TYPE estados is (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11);
	signal edo_presente, edo_futuro : estados;
begin
	RelojMensaje: Process (clk) begin
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
	end Process RelojMensaje;
	
	Reconocimiento: Process (edo_presente) begin
		case edo_presente is 
			when d0 => 
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d1;
			when d1 => 
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d2;
			when d2 => 
				a <= "11110";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "11110";
				h <= "00000";
				edo_futuro <= d3;
			when d3 => 
				a <= "00000";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d4;
			when d4 => 
				a <= "01111";
				b <= "01111";
				c <= "01111";
				d <= "01111";
				e <= "01111";
				h <= "00000";
				edo_futuro <= d5;
			-----niveles------
			when d5 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "01111";
				edo_futuro <= d6;
			when d6 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "10111";
				edo_futuro <= d7;
			when d7 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "11011";
				edo_futuro <= d8;
			when d8 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "11101";
				edo_futuro <= d9;
			when d9 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "11110";
				edo_futuro <= d10;
			when d10 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d11;
			when d11 => 
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d0;
		end case;
	end Process Reconocimiento;
	
	CambioPaso: process (led) begin
		if(led 'event and led='1') then
			edo_presente <= edo_futuro;
		end if;
	end process CambioPaso;
end CarasArq;

