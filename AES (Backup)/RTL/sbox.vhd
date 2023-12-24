library ieee;
use ieee.std_logic_1164.all;

entity sbox is
    port (
        input_byte : in std_logic_vector(5 downto 0);
        output_byte : out std_logic_vector(5 downto 0)
    );
end sbox;

architecture behavioral of sbox is

begin
    lut : process (input_byte) is
    begin
        case input_byte is
            when "000000" => output_byte <= "110001";
            when "000001" => output_byte <= "111100";
            when "000010" => output_byte <= "110111";
            when "000011" => output_byte <= "111011";
            when "000100" => output_byte <= "111100";
            when "000101" => output_byte <= "110101";
            when "000110" => output_byte <= "110111";
            when "000111" => output_byte <= "110001";
            when "001000" => output_byte <= "110000";
            when "001001" => output_byte <= "000001";
            when "001010" => output_byte <= "110011";
            when "001011" => output_byte <= "101011";
            -- Continue with the rest of the cases...
            when others => null; -- GHDL complains without this statement
        end case;
    end process lut;

end architecture behavioral;
