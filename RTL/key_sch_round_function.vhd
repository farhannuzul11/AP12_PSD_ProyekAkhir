library ieee;
use ieee.std_logic_1164.all;

entity key_sch_round_function is
	port (		
		subkey : in std_logic_vector(5 downto 0);
		round_const : in std_logic_vector(5 downto 0);
		next_subkey : out std_logic_vector(5 downto 0)		
	);
end key_sch_round_function;

architecture behavioral of key_sch_round_function is
	signal substitued_sk : std_logic_vector(5 downto 0);
	signal shifted_sk : std_logic_vector(5 downto 0);
	signal w0 : std_logic_vector(5 downto 0);
begin
	sbox_inst : entity work.sbox
		port map(
			input_byte  => subkey,
			output_byte => substitued_sk
		);			
	shifted_sk <= substitued_sk(5 downto 0);
	w0 <= subkey(5 downto 0) xor shifted_sk(5 downto 0) xor round_const;
	next_subkey <= w0;
end architecture behavioral;
