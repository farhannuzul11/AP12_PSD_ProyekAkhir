-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'shift_rows'
entity shift_rows is
	-- Declare the input and output ports
	port (
		input : in std_logic_vector(5 downto 0); -- changed from 17 to 5
		output : out std_logic_vector(5 downto 0) -- changed from 17 to 5
	);
end shift_rows;

-- Define the architecture of 'shift_rows'
architecture rtl of shift_rows is
	
begin
	output(5 downto 4) <= input(3 downto 2);
	output(3 downto 2) <= input(1 downto 0);
	output(1 downto 0) <= input(5 downto 4); 	
end architecture rtl;
