library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Examen is Port
(
	--Reloj
	clk : in std_logic;
	led : inout std_logic;
	--Segmentos
	D0    : IN  STD_LOGIC_VECTOR(7 downto 0);
	D1    : IN  STD_LOGIC_VECTOR(7 downto 0);
	D2    : IN  STD_LOGIC_VECTOR(7 downto 0);
	D3    : IN  STD_LOGIC_VECTOR(7 downto 0);
	salida: OUT STD_LOGIC_VECTOR(7 downto 0);
	MUX   : OUT STD_LOGIC_VECTOR(3 downto 0);
	--Selectores
	s0 	: in std_logic;
	s1 	: in std_logic;
	--
	ds : out  STD_LOGIC_VECTOR(3 downto 0);
	dis0 : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Examen;

architecture Behavioral of Examen is
	signal digito  : STD_LOGIC_VECTOR(7 downto 0);
	
	COMPONENT Reloj10 IS PORT 
	(
		clk : IN  STD_LOGIC;
		led  : INOUT  STD_LOGIC
	);
	END COMPONENT;
	 
	 COMPONENT SegmentoMux IS
        PORT (
            clk   : IN  STD_LOGIC;
            D0    : IN  STD_LOGIC_VECTOR(7 downto 0);
            D1    : IN  STD_LOGIC_VECTOR(7 downto 0);
            D2    : IN  STD_LOGIC_VECTOR(7 downto 0);
            D3    : IN  STD_LOGIC_VECTOR(7 downto 0);
            salida: OUT STD_LOGIC_VECTOR(7 downto 0);
            MUX   : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT SieteDisplay IS
        PORT (
            entrada: IN  STD_LOGIC_VECTOR(7 downto 0);
            salida : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
begin
	clk10_i: Reloj10 PORT MAP(clk, led);
	Selector: process begin
			if (s0 = '0' and s1 = '0') then
				ds <= "1100";
				dis0 <= "11111001";
			elsif (s0 = '0' and s1 = '1') then
				ds <= "1000";
				dis0 <= "11111001";
			elsif (s0 = '1' and s1 = '0') then
				ds <= "1100";
				dis0 <= "11111001";
			else
				ds <= "1000";
				dis0 <= "11111001";
			end if;
	end process Selector;
	mux_i: SegmentoMux PORT MAP(led, "00000000", "00000001", "00000010", "00000011", digito, MUX);
	seg_i: SieteDisplay PORT MAP(digito, salida);
	
end Behavioral;

