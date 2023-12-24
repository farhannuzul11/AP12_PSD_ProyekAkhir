library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package Memory is
    
    Type room IS RECORD
        status : STD_LOGIC;
        username : STRING(1 TO 11);
        password : INTEGER;
        day : INTEGER;
    END RECORD;
    --parking_lot = all_room, kapasitasnya berbeda 3 lantai masing2 4 kamar
    TYPE all_room IS ARRAY (2 DOWNTO 0, 3 DOWNTO 0) OF room;
    CONSTANT default_username : STRING(1 TO 11) := "DefaultUser";
    CONSTANT default_password : INTEGER := 0;
    CONSTANT default_day : INTEGER := 0;
    
    SHARED VARIABLE room_array : all_room := (
        (('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day)),
        (('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day)),
        (('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day), ('0', default_username, default_password, default_day))
    );

    --note:
    --rekomendsi protected
    --ada error tadi, ga tau bedanya apa, 

end package Memory;