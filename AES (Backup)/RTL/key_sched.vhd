-- Impor library IEEE dan paket logika standar
library ieee;
use ieee.std_logic_1164.all;

-- Definisikan entitas bernama 'key_sched'
entity key_sched is
	-- Deklarasikan port input dan output
	port (
		clk : in std_logic; -- sinyal clock
		rst : in std_logic; -- sinyal reset
		key : in std_logic_vector(5 downto 0); -- kunci input
		round_const : in std_logic_vector(5 downto 0); -- konstanta putaran
		round_key : out std_logic_vector(5 downto 0) -- kunci putaran
	);
end key_sched;

-- Definisikan arsitektur dari 'key_sched'
architecture behavioral of key_sched is
	signal feedback : std_logic_vector(5 downto 0); -- sinyal feedback
	signal reg_input : std_logic_vector(5 downto 0); -- input register
	signal reg_output : std_logic_vector(5 downto 0); -- output register
begin
	reg_input <= key when rst = '0' else feedback; -- jika reset, input register adalah key, jika tidak, input register adalah feedback
	reg_inst : entity work.reg -- instansiasi entitas register
		generic map(
			size => 6 -- ukuran register
		)
		port map(
			clk => clk, -- sambungkan clock
			d   => reg_input, -- sambungkan input register
			q   => reg_output -- sambungkan output register
		);	
	key_sch_round_function_inst : entity work.key_sch_round_function -- instansiasi entitas fungsi putaran jadwal kunci
		port map(
			subkey      => reg_output, -- sambungkan output register ke subkey
			round_const => round_const, -- sambungkan round_const
			next_subkey => feedback -- sambungkan feedback ke next_subkey
		);
	round_key <= reg_output; -- round_key adalah output register
end architecture behavioral;
