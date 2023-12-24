library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Enkripsi_Dekripsi is
    port (
        inp : in integer;
        START : in std_logic;
        MODE : in std_logic; -- 0 untuk enkripsi dan 1 untuk dekripsi
        KEY : in std_logic_vector(3 downto 0);
        CLK : in std_logic;
        outp : out integer
    );
end entity Enkripsi_Dekripsi;

architecture rtl of Enkripsi_Dekripsi is
    signal INPUT : std_logic_vector(19 downto 0);
    signal OUTPUT : std_logic_vector(19 downto 0) := (others => '0');
    type state is (init, add, s_xor, swap, sub, done);
    signal temp : std_logic_vector(19 downto 0) := (others => '0');
    
    signal present_state, next_state : state := init;
begin

    process(present_state, input, mode, start, inp) is
        variable result : std_logic_vector(19 downto 0) := (others => '0');
    begin
        INPUT <= std_logic_vector(to_unsigned(inp, 20));
        if present_state = init then
            if start = '0' then
                next_state <= init;
            else 
                next_state <= add;
                result := input;
            end if;
        elsif present_state = add then
            result := std_logic_vector(unsigned(temp(19 downto 16)) + unsigned(key)) & std_logic_vector(unsigned(temp(15 downto 12)) + unsigned(key)) & std_logic_vector(unsigned(temp(11 downto 8)) + unsigned(key)) & std_logic_vector(unsigned(temp(7 downto 4)) + unsigned(key)) & std_logic_vector(unsigned(temp(3 downto 0)) + unsigned(key));
            
            if mode = '0' then
                next_state <= s_xor;
            elsif mode = '1'  then
                next_state <= swap;
            end if;
        elsif present_state = s_xor then
            result := temp xor (key & key & key & key & key);
            
            if mode = '0' then
                next_state <= swap;
            elsif mode = '1' then
                next_state <= sub;
            end if;
        elsif present_state = swap then
            result := temp(9 downto 0) & temp(19 downto 10);
            
            if mode = '0' then
                next_state <= sub;
            elsif mode = '1' then
                next_state <= s_xor;
            end if;
        elsif present_state = sub then
            result := std_logic_vector(unsigned(temp(19 downto 16)) - unsigned(key)) & std_logic_vector(unsigned(temp(15 downto 12)) - unsigned(key)) & std_logic_vector(unsigned(temp(11 downto 8)) - unsigned(key)) & std_logic_vector(unsigned(temp(7 downto 4)) - unsigned(key)) & std_logic_vector(unsigned(temp(3 downto 0)) - unsigned(key));
            next_state <= done;
            
        else
            OUTPUT <= temp;
            next_state <= init;
	end if;
        temp <= result;
    end process;

    outp <= to_integer(unsigned(temp));

    process (CLK) is
    begin
        if (rising_edge(CLK)) then
            present_state <= next_state;
        end if;
    end process;
    
end architecture rtl;
