library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.State_Condition.ALL;
use work.Memory.ALL;

entity Receptionist is
    port (
        -- guest : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        mode : IN STD_LOGIC;
        room_condition : STD_LOGIC;
        username : IN STRING(1 TO 11);
        day : IN INTEGER;
        password : IN INTEGER;
        password_in : IN INTEGER;
        overload_out : OUT STD_LOGIC; -- untuk menampilkan overload
        header_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- untuk menentukan ruangan        
    );
end entity Receptionist;

architecture rtl of Receptionist is
    -- Component untuk menampilkan tampilan
    COMPONENT sevenSegment IS
        PORT (
            Bin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Outer : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Controller IS 
        PORT (
            clk : IN STD_LOGIC;
            position_header : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
            enable : IN STD_LOGIC := '0';
            mode : IN STD_LOGIC := '0';
            ready : INOUT STD_LOGIC := '0'
        );  
    END COMPONENT Controller;

    -- Deklarasi sinyal
    SIGNAL present_state, next_state : state_type;
    SIGNAL password_sig : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL header : STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Added signal declaration for 'header'
begin
    -- Start process
    start : PROCESS (clk, next_state)
    BEGIN
        IF rising_edge(clk) THEN
            present_state <= next_state; -- masih rada ragu
        END IF;
    END PROCESS;

    -- All process
    all_process : PROCESS (present_state)
        VARIABLE overload_var : STD_LOGIC;
    BEGIN
        CASE mode is -- .1
            WHEN '1' =>
                -- Kode saat mode memesan
                CASE present_state IS -- .2
                    WHEN IDLE =>
                        -- Kode
                        IF room_condition = '0' THEN 
                            next_state <= GUESTIN;
                        ELSE
                            next_state <= GUESTOUT;
                        END IF;

                    WHEN GUESTIN =>
                        IF (room_array(0,0).status = '0') THEN
                            header <= "0100"; 
                        ELSIF (room_array(0,1).status = '0') THEN
                            header <= "0101";
                        ELSIF (room_array(0,2).status = '0') THEN
                            header <= "0110";
                        ELSIF (room_array(0,3).status = '0') THEN
                            header <= "0111";
                        ELSIF (room_array(1,0).status = '0') THEN
                            header <= "1000";
                        ELSIF (room_array(1,1).status = '0') THEN
                            header <= "1001";
                        ELSIF (room_array(1,2).status = '0') THEN
                            header <= "1010";
                        ELSIF (room_array(1,3).status = '0') THEN
                            header <= "1011";
                        ELSIF (room_array(2,0).status = '0') THEN
                            header <= "1100";
                        ELSIF (room_array(2,1).status = '0') THEN
                            header <= "1101";
                        ELSIF (room_array(2,2).status = '0') THEN
                            header <= "1110";
                        ELSIF (room_array(2,3).status = '0') THEN
                            header <= "1111";
                        ELSE
                            overload_var := '1';
                            overload_out <= overload_var;
                        END IF;

                        IF overload_var = '1' THEN
                            next_state <= OVERLOAD;
                        ELSE
                            next_state <= INPUT_USER;
                        END IF;

                    WHEN INPUT_USER =>
                        room(to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).status := '1';
                        room(to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).username := username;
                        room(to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).day := day;
                        password_sig <= hash (password); -- belum ada implementasinya
                        room(to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).password := password_sig;

                        next_state <= IDLE;

                    WHEN OVERLOAD =>
                        report "There is no room available";

                        next_state <= IDLE;

                    WHEN GUESTOUT =>
                        room (to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).status := '0';
                        room (to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).username := "00000000000";
                        room (to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).day := 0;
                        room (to_integer(unsigned(header(3 DOWNTO 2))), to_integer(unsigned(header(1 DOWNTO 0)))).password := "00000000";

                        next_state <= IDLE;
                END CASE; -- .2
                
            WHEN '0' =>
                -- Kode saat ingin masuk kamar
                CASE present_state IS
                    WHEN IDLE =>
                        next_state <= ACCESS_ROOM;

                    WHEN ACCESS_ROOM =>
                        IF (room_array(0,0).password = password_in) THEN
                            header <= "0100";
                            report "Access Granted";    
                        ELSIF (room_array(0,1).password = password_in) THEN
                            header <= "0101";
                            report "Access Granted";
                        ELSIF (room_array(0,2).password = password_in) THEN
                            header <= "0110";
                            report "Access Granted";
                        ELSIF (room_array(0,3).password = password_in) THEN
                            header <= "0111";
                            report "Access Granted";
                        ELSIF (room_array(1,0).password = password_in) THEN
                            header <= "1000";
                            report "Access Granted";
                        ELSIF (room_array(1,1).password = password_in) THEN
                            header <= "1001";
                            report "Access Granted";
                        ELSIF (room_array(1,2).password = password_in) THEN
                            header <= "1010";
                            report "Access Granted";
                        ELSIF (room_array(1,3).password = password_in) THEN
                            header <= "1011";
                            report "Access Granted";
                        ELSIF (room_array(2,0).password = password_in) THEN
                            header <= "1100";
                            report "Access Granted";
                        ELSIF (room_array(2,1).password = password_in) THEN
                            header <= "1101";
                            report "Access Granted";
                        ELSIF (room_array(2,2).password = password_in) THEN
                            header <= "1110";
                            report "Access Granted";
                        ELSIF (room_array(2,3).password = password_in) THEN
                            header <= "1111";
                            report "Access Granted";
                        ELSE
                            report "Access Denied";
                        END IF;
                        
                        next_state <= IDLE;
                END CASE; -- .1
        END CASE;
    END PROCESS;
end architecture rtl;
