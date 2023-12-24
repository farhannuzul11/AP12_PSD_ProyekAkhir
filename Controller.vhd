library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEe.math_real.all;

USE work.Memory.ALL;

entity Memory is
    port(
        clk : IN STD_LOGIC;
        position_header : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
        enable : IN STD_LOGIC := '0';
        mode : IN STD_LOGIC := '0';
        ready : INOUT STD_LOGIC := '0'
    );
end Memory;

architecture rtl of Controller is
    TYPE states IS (base_floor, search_floor, search_room, book_room);
    SIGNAL present_state, next_state : states := base_floor;

    SIGNAL number_of_floor : INTEGER := 0;
    SIGNAL number_of_room : INTEGER := 0;
    SIGNAL current_floor : INTEGER := 1;
    SIGNAL current_room : INTEGER := 0;
    SIGNAL lifting_state : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out_park : parking_lot := parking_array;
    
begin
    start : PROCESS(clk, next_state)
    BEGIN
        IF rising_edge(clk) THEN
            present_state <= next_state;
        END IF;
    END PROCESS start;
    
    combination_process : PROCESS(present_state, current_floor, current_room, lifting_state, mode, enable, position_header)
    BEGIN
        number_of_floor <= to_integer(unsigned(position_header(3 downto 2)));
        number_of_room <= to_integer(unsigned(position_header(1 downto 0)));
        out_park <= room_array; --ganti dari parking array

        CASE present_state IS
            WHEN base_floor =>
            IF (ready = '1') THEN
                ready <= '0';
            END IF;

            IF enable = '1' THEN
                next_state <= search_floor;
            ELSE
                next_state <= base_floor;
            END IF;

            WHEN search_floor =>
                IF (current_floor = number_of_floor) THEN
                    next_state <= search_room;
                ELSE
                    current_floor <= current_floor + 1;
                END IF;
            
            WHEN search_room =>
                IF current_room = number_of_room THEN
                    next_state <= book_room;
                ELSE
                    current_room <= current_room + 1;
                END IF;

            WHEN book_room =>
                ready <= '1';
                next_state <= base_floor;
                current_floor <= 1;
                current_room <= 0;
        END CASE;

        -- IF (ready = '1') THEN
        --     lifting_state <= "01";
        -- ELSE
        --     lifting_state <= "00";
        -- END IF;
    END PROCESS combination_process;
end architecture rtl;