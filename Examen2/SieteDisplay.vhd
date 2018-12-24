library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SieteDisplay is
PORT (
        entrada: IN  STD_LOGIC_VECTOR(7 downto 0);
        salida : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end SieteDisplay;

architecture Behavioral of SieteDisplay is
begin
	visualizador: process (entrada) begin
        case entrada is
            when "11000000" =>  salida <= x"C0"; -- 0
            when "11000001" =>  salida <= x"F9"; -- 1
            when "11100010" =>  salida <= x"A4"; -- 2
            when "11000011" =>  salida <= x"B0"; -- 3
            when "11000100" =>  salida <= x"99"; -- 4
            when "11000101" =>  salida <= x"92"; -- 5
            when others   =>  salida <= x"FF"; -- Nada
        end case;
    end process;
end Behavioral;

