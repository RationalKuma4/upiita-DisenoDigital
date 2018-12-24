library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Animacion is Port 
( 
	clk : in  STD_LOGIC;
	led, led2, led3: inout STD_LOGIC;
	a : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	b : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	c : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	d : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	e : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	h : out  STD_LOGIC_VECTOR(4 DOWNTO 0)
);
end Animacion;

architecture AnimacionArq of Animacion is
	signal cnt, cnt2, cnt3: std_logic_vector(0 to 25);
	TYPE estados is 
	(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, 
	d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, d32, d33, d34,
	d35, d36, d37, d38, d39, d40, d41, d42, d43, d44, d45, d46, d47, d48, d49, d50, d51,
	d52, d53, d54, d55, d56, d57, d58, d59, d60, d61, d62, d63, d64, d65, d66, d67, d68,
	d69, d70, d71, d72, d73, d74, d75, d76, d77, d78, d79, d80, d81, d82, d83);
	signal edo_presente, edo_futuro : estados;
	signal I : std_logic_vector(0 to 2);
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
	
	RelojConteo: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt2 = 3000000) then
				led2 <= '1';
			else
				cnt2 <= (cnt2 + 1);
			end if;
			if(cnt2 = 10000000) then
				led2 <= '0';
				cnt2 <= "00000000000000000000000000";
			else
				cnt2 <= (cnt2 + 1);
			end if;
		end if;
	end Process RelojConteo;
	
	RelojConteo3: Process (clk) begin
		if(clk 'event and clk = '1') then
			if(cnt3 = 2500000) then
				led3 <= '1';
			else
				cnt3 <= (cnt3 + 1);
			end if;
			if(cnt3 = 5000000) then
				led3 <= '0';
				cnt3 <= "00000000000000000000000000";
			else
				cnt3 <= (cnt3 + 1);
			end if;
		end if;
	end Process RelojConteo3;
	
	Reconocimiento: Process (edo_presente) begin
		case edo_presente is 
			----1-----
			when d0 => I <= "000";
				a <= "11011";
				b <= "11011";
				c <= "11011";
				d <= "11011";
				e <= "11011";
				h <= "01111";
				edo_futuro <= d1;
			when d1 => I <= "000";
				a <= "11011";
				b <= "11011";
				c <= "11011";
				d <= "11011";
				e <= "11011";
				h <= "10111";
				edo_futuro <= d2;
			when d2 => I <= "000";
				a <= "11011";
				b <= "11011";
				c <= "11011";
				d <= "11011";
				e <= "11011";
				h <= "11011";
				edo_futuro <= d3;
			when d3 => I <= "000";
				a <= "11011";
				b <= "11011";
				c <= "11011";
				d <= "11011";
				e <= "11011";
				h <= "11101";
				edo_futuro <= d4;
			when d4 => I <= "000";
				a <= "11011";
				b <= "11011";
				c <= "11011";
				d <= "11011";
				e <= "11011";
				h <= "11110";
				edo_futuro <= d5;
			-----2------
			when d5 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11110";
				edo_futuro <= d6;
			when d6 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11101";
				edo_futuro <= d7;
			when d7 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11011";
				edo_futuro <= d8;
			when d8 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "10111";
				edo_futuro <= d9;
			when d9 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "01111";
				edo_futuro <= d10;
			----3----
			when d10 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "01111";
				edo_futuro <= d11;
			when d11 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "10111";
				edo_futuro <= d12;
			when d12 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11011";
				edo_futuro <= d13;
			when d13 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11101";
				edo_futuro <= d14;
			when d14 => 
				a <= "00000";
				b <= "11110";
				c <= "00000";
				d <= "01111";
				e <= "00000";
				h <= "11110";
				edo_futuro <= d15;
			----4------------
			when d15 => 
				a <= "01110";
				b <= "01110";
				c <= "00000";
				d <= "11110";
				e <= "11110";
				h <= "11110";
				edo_futuro <= d16;
			when d16 => 
				a <= "01110";
				b <= "01110";
				c <= "00000";
				d <= "11110";
				e <= "11110";
				h <= "11101";
				edo_futuro <= d17;
			when d17 => 
				a <= "01110";
				b <= "01110";
				c <= "00000";
				d <= "11110";
				e <= "11110";
				h <= "11011";
				edo_futuro <= d18;
			when d18 => 
				a <= "01110";
				b <= "01110";
				c <= "00000";
				d <= "11110";
				e <= "11110";
				h <= "10111";
				edo_futuro <= d19;
			when d19 => 
				a <= "01110";
				b <= "01110";
				c <= "00000";
				d <= "11110";
				e <= "11110";
				h <= "01111";
				edo_futuro <= d20;
			-------5-------------
			when d20 => 
				a <= "00000";
				b <= "01111";
				c <= "00000";
				d <= "11110";
				e <= "00000";
				h <= "01111";
				edo_futuro <= d21;
				when d21 => 
				a <= "00000";
				b <= "01111";
				c <= "00000";
				d <= "11110";
				e <= "00000";
				h <= "10111";
				edo_futuro <= d22;
			when d22 => 
				a <= "00000";
				b <= "01111";
				c <= "00000";
				d <= "11110";
				e <= "00000";
				h <= "11011";
				edo_futuro <= d23;
			when d23 => 
				a <= "00000";
				b <= "01111";
				c <= "00000";
				d <= "11110";
				e <= "00000";
				h <= "11101";
				edo_futuro <= d24;
			when d24 => 
				a <= "00000";
				b <= "01111";
				c <= "00000";
				d <= "11110";
				e <= "00000";
				h <= "11110";
				edo_futuro <= d25;
			-----cubo derecho----------
			when d25 => I <= "001";
				a <= "00111";
				b <= "00111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00111";
				edo_futuro <= d26;
			when d26 => I <= "001";
				a <= "00011";
				b <= "01011";
				c <= "00011";
				d <= "11111";
				e <= "11111";
				h <= "00011";
				edo_futuro <= d27;
			when d27 => I <= "001";
				a <= "00001";
				b <= "01101";
				c <= "01101";
				d <= "00001";
				e <= "11111";
				h <= "00001";
				edo_futuro <= d28;
			when d28 => I <= "001";
				a <= "00000";
				b <= "01110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d29;
			-----cubo izquierdo--------
			when d29 => I <= "001";
				a <= "11100";
				b <= "11100";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "11100";
				edo_futuro <= d30;
			when d30 => I <= "001";
				a <= "11000";
				b <= "11010";
				c <= "11000";
				d <= "11111";
				e <= "11111";
				h <= "11000";
				edo_futuro <= d31;
			when d31 => I <= "001";
				a <= "10000";
				b <= "10110";
				c <= "10110";
				d <= "10000";
				e <= "11111";
				h <= "10000";
				edo_futuro <= d32;
			when d32 => I <= "001";
				a <= "00000";
				b <= "01110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d33;
			------cuboo atras derecho
			when d33 => I <= "001";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "00111";
				e <= "00111";
				h <= "00111";
				edo_futuro <= d34;
			when d34 => I <= "001";
				a <= "11111";
				b <= "11111";
				c <= "00011";
				d <= "01011";
				e <= "00011";
				h <= "00011";
				edo_futuro <= d35;
			when d35 => I <= "001";
				a <= "11111";
				b <= "00001";
				c <= "01101";
				d <= "01101";
				e <= "01101";
				h <= "00001";
				edo_futuro <= d36;
			when d36 => I <= "001";
				a <= "00000";
				b <= "01110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d37;
			----cubo atras izquierdo
			when d37 => I <= "001";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11100";
				e <= "11100";
				h <= "11100";
				edo_futuro <= d38;
			when d38 => I <= "001";
				a <= "11111";
				b <= "11111";
				c <= "11000";
				d <= "11010";
				e <= "11000";
				h <= "11000";
				edo_futuro <= d39;
			when d39 => I <= "001";
				a <= "11111";
				b <= "10000";
				c <= "10110";
				d <= "10110";
				e <= "10000";
				h <= "10000";
				edo_futuro <= d40;
			when d40 => I <= "001";
				a <= "00000";
				b <= "01110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d41;
			----figura-------------
			when d41 => I <= "000";
				a <= "00000";
				b <= "10000";
				c <= "11000";
				d <= "11100";
				e <= "11110";
				h <= "00000";
				edo_futuro <= d42;
			when d42 => I <= "000";
				a <= "00000";
				b <= "00001";
				c <= "00011";
				d <= "00111";
				e <= "01111";
				h <= "00000";
				edo_futuro <= d43;
			when d43 => I <= "000";
				a <= "11110";
				b <= "11100";
				c <= "11000";
				d <= "10000";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d44;
			when d44 => I <= "000";
				a <= "01111";
				b <= "00111";
				c <= "00011";
				d <= "00001";
				e <= "00000";
				h <= "00000";
				edo_futuro <= d45;
			when d45 => I <= "000";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "11111";
				edo_futuro <= d46;
			------columnas--------
			when d46 => I <= "010";
				a <= "00111";
				b <= "00111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d47;
			when d47 => I <= "010";
				a <= "11111";
				b <= "00111";
				c <= "00111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d48;
			when d48 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "00111";
				d <= "00111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d49;
			when d49 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "00111";
				e <= "00111";
				h <= "00000";
				edo_futuro <= d50;
			when d50 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "10011";
				e <= "10011";
				h <= "00000";
				edo_futuro <= d51;
			when d51 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11001";
				e <= "11001";
				h <= "00000";
				edo_futuro <= d52;
			when d52 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "11111";
				d <= "11100";
				e <= "11100";
				h <= "00000";
				edo_futuro <= d53;
			when d53 => I <= "010";
				a <= "11111";
				b <= "11111";
				c <= "11100";
				d <= "11100";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d54;
			when d54 => I <= "010";
				a <= "11111";
				b <= "11100";
				c <= "11100";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d55;
			when d55 => I <= "010";
				a <= "11100";
				b <= "11100";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d56;
			when d56 => I <= "010";
				a <= "11001";
				b <= "11001";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d57;
			when d57 => I <= "010";
				a <= "10011";
				b <= "10011";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d58;
			when d58 => I <= "010";
				a <= "00111";
				b <= "00111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "00000";
				edo_futuro <= d59;
			---vertical-----
			when d59 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "01111";
				edo_futuro <= d60;
			when d60 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "10111";
				edo_futuro <= d61;
			when d61 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "11011";
				edo_futuro <= d62;
			when d62 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "11101";
				edo_futuro <= d63;
			when d63 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "11110";
				edo_futuro <= d64;
			when d64 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "11101";
				edo_futuro <= d65;
			when d65 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "11011";
				edo_futuro <= d66;
			when d66 => I <= "010";
				a <= "10001";
				b <= "10001";
				c <= "01110";
				d <= "10001";
				e <= "10001";
				h <= "10111";
				edo_futuro <= d67;
			when d67 => I <= "010";
				a <= "01111";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "01010";
				edo_futuro <= d68;
			----espiral----
			when d68 => I <= "010";
				a <= "00111";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "01010";
				edo_futuro <= d69;
			when d69 => I <= "010";
				a <= "00011";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "10101";
				edo_futuro <= d70;
			when d70 => I <= "010";
				a <= "00001";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "01010";
				edo_futuro <= d71;
			when d71 => I <= "010";
				a <= "00000";
				b <= "11111";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "10101";
				edo_futuro <= d72;
			when d72 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11111";
				d <= "11111";
				e <= "11111";
				h <= "01010";
				edo_futuro <= d73;
			when d73 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11111";
				e <= "11111";
				h <= "10101";
				edo_futuro <= d74;
			when d74 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "11111";
				h <= "01010";
				edo_futuro <= d75;
			when d75 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "11110";
				h <= "10101";
				edo_futuro <= d76;
			when d76 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "11100";
				h <= "01010";
				edo_futuro <= d77;
			when d77 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "11000";
				h <= "10101";
				edo_futuro <= d78;
			when d78 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "10000";
				h <= "01010";
				edo_futuro <= d79;
			when d79 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "11110";
				e <= "00000";
				h <= "10101";
				edo_futuro <= d80;
			when d80 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "11110";
				d <= "01110";
				e <= "00000";
				h <= "01010";
				edo_futuro <= d81;
			when d81 => I <= "010";
				a <= "00000";
				b <= "11110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "10101";
				edo_futuro <= d82;
			when d82 => I <= "010";
				a <= "00000";
				b <= "01110";
				c <= "01110";
				d <= "01110";
				e <= "00000";
				h <= "01010";
				edo_futuro <= d83;
			when d83 => I <= "010";
				a <= "00000";
				b <= "00000";
				c <= "00000";
				d <= "00000";
				e <= "00000";
				h <= "01010";
				edo_futuro <= d0;
		end case;
	end Process Reconocimiento;
	
	CambioPaso: process (led, led2, led3, I) begin
		if(I = "000") then
			if(led2 'event and led2 ='1') then
				edo_presente <= edo_futuro;
			end if;
		elsif(I = "010") then 
			if(led3 'event and led3 ='1') then
				edo_presente <= edo_futuro;
			end if;
		else
			if(led 'event and led='1') then
				edo_presente <= edo_futuro;
			end if;
		end if;
	end process CambioPaso;

end AnimacionArq;

