-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'gfmult_by2'
entity gfmult_by2 is
	-- Declare the input and output ports
	port (
		input_byte : in std_logic_vector(5 downto 0); -- changed from 7 to 5
		output_byte : out std_logic_vector(5 downto 0) -- changed from 7 to 5
	);
end gfmult_by2;

-- Define the architecture of 'gfmult_by2'
architecture behavioral of gfmult_by2 is
	signal shifted_byte : std_logic_vector(5 downto 0); -- changed from 7 to 5
	signal conditional_xor : std_logic_vector(5 downto 0); -- changed from 7 to 5
begin
	shifted_byte <= input_byte(4 downto 0) & "0";
	conditional_xor <= "0" & input_byte(5) & input_byte(5) & "0" & input_byte(5) & input_byte(5);
	output_byte <= shifted_byte xor conditional_xor;
end architecture behavioral;
