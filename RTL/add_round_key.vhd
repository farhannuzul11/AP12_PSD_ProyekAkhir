library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity add_round_key is
	
	port (
		in1 : in std_logic_vector(5 downto 0);
		in2 : in std_logic_vector(5 downto 0);
		out1 : out std_logic_vector(5 downto 0)
	);
end add_round_key;


architecture logic_design of add_round_key is
begin
	out1 <= in1 xor in2;		
end architecture logic_design;
