library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.State_Condition.ALL;
use work.Memory.ALL;

entity Receptionist_tb is
end entity Receptionist_tb;

architecture tb_arch of Receptionist_tb is
    -- Signals for the testbench
    signal clk_tb       : STD_LOGIC := '0';
    signal mode_tb      : STD_LOGIC := '0';
    signal room_condition_tb : STD_LOGIC := '0';
    signal username_tb  : STRING(1 TO 11) := (others => '0');
    signal day_tb       : INTEGER := 0;
    signal password_tb  : INTEGER := 0;
    signal password_in_tb : INTEGER := 0;
    signal overload_out_tb : STD_LOGIC;
    signal header_out_tb   : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Instantiate the Receptionist entity
    COMPONENT Receptionist
        port (
            clk : IN STD_LOGIC;
            mode : IN STD_LOGIC;
            room_condition : IN STD_LOGIC;
            username : IN STRING(1 TO 11);
            day : IN INTEGER;
            password : IN INTEGER;
            password_in : IN INTEGER;
            overload_out : OUT STD_LOGIC;
            header_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    end component;

    -- Clock process for testbench
    process
    begin
        wait for 5 ns; -- Adjust the time period as needed
        clk_tb <= not clk_tb;
    end process;

    -- Stimulus process
    process
    begin
        wait for 10 ns; -- Initial wait before applying inputs

        -- Test case 1: Example input values
        mode_tb <= '1';  -- Set mode to ordering
        room_condition_tb <= '0';
        username_tb <= "JohnDoe123";
        day_tb <= 1;
        password_tb <= 1234;
        password_in_tb <= 1234;

        wait for 10 ns;

        -- Test case 2: Another example input values
        mode_tb <= '0';  -- Set mode to accessing room
        password_in_tb <= 5678;

        wait;
    end process;

    -- Instantiate the Receptionist entity with testbench signals
    uut : Receptionist
        port map (
            clk => clk_tb,
            mode => mode_tb,
            room_condition => room_condition_tb,
            username => username_tb,
            day => day_tb,
            password => password_tb,
            password_in => password_in_tb,
            overload_out => overload_out_tb,
            header_out => header_out_tb
        );

end architecture tb_arch;
