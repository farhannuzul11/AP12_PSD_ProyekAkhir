library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package State_Condition is
    
    type state_type is (IDLE, SELECTMODE, GUESTIN, GUESTOUT, INPUT_USER, OVERLOAD, ACCESS_ROOM); --masih ada pengurangan

end package;