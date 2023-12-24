-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'column_calculator'
entity column_calculator is
	-- Declare the input and output ports
	port (
		input_data : in std_logic_vector(5 downto 0); -- changed from 31 to 5
		output_data : out std_logic_vector(5 downto 0) -- changed from 31 to 5
	);
end column_calculator;

-- Define the architecture of 'column_calculator'
architecture rtl of column_calculator is
	signal temp : std_logic_vector(5 downto 0); -- changed from 7 to 5
	signal temp0 : std_logic_vector(5 downto 0); -- changed from 7 to 5
	signal temp0x2 : std_logic_vector(5 downto 0); -- changed from 7 to 5
begin
	temp <= input_data(5 downto 0);
	temp0 <= input_data(5 downto 0);
	gfmult_by2_inst0 : entity work.gfmult_by2
		port map(
			input_byte  => temp0,
			output_byte => temp0x2
		);
	output_data(5 downto 0) <= input_data(5 downto 0) xor temp0x2 xor temp;	
end architecture rtl;
