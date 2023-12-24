-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'mix_columns'
entity mix_columns is
	-- Declare the input and output ports
	port (
		input_data : in std_logic_vector(5 downto 0); -- changed from 127 to 5
		output_data : out std_logic_vector(5 downto 0) -- changed from 127 to 5
	);
end mix_columns;

-- Define the architecture of 'mix_columns'
architecture rtl of mix_columns is
	
begin
	mix_columns_inst : entity work.column_calculator
		port map(
			input_data  => input_data,
			output_data => output_data
		);
end architecture rtl;
