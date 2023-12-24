-- Impor library IEEE dan paket logika standar
library ieee;
use ieee.std_logic_1164.all;

-- Definisikan entitas bernama 'control_unit'
entity control_unit is
	-- Deklarasikan port input dan output
	port (
		clk : in std_logic; -- sinyal clock
		rst : in std_logic; -- sinyal reset
		round_const : out std_logic_vector(5 downto 0); -- konstanta putaran, diubah dari 7 ke 5 bit
		final_round : out std_logic; -- sinyal putaran final
		done : out std_logic -- sinyal selesai
	);
end control_unit;

-- Definisikan arsitektur dari 'control_unit'
architecture behavior of control_unit is
	signal register_input : std_logic_vector(5 downto 0); -- input register, diubah dari 7 ke 5 bit
	signal register_output : std_logic_vector(5 downto 0); -- output register, diubah dari 7 ke 5 bit
	signal feedback_signal : std_logic_vector(5 downto 0); -- sinyal feedback, diubah dari 7 ke 5 bit
begin
	register_input <= "000001" when rst = '0' else feedback_signal; -- jika reset, input register adalah "000001", jika tidak, input register adalah feedback_signal
	register_instance : entity work.reg -- instansiasi entitas register
		generic map(
			size => 6 -- ukuran register, diubah dari 8 ke 6 bit
		)
		port map(
			clk => clk, -- sambungkan clk
			d   => register_input, -- sambungkan input register
			q   => register_output -- sambungkan output register
		);

	gfmult_by2_instance : entity work.gfmult_by2 -- instansiasi entitas penggandaan Galois Field
		port map(
			input_byte  => register_output, -- sambungkan output register ke input_byte
			output_byte => feedback_signal -- sambungkan feedback_signal ke output_byte
		);
	round_const <= register_output; -- round_const adalah output register
	final_round <= '1' when register_output = "110110" else '0'; -- jika output register adalah "110110", final_round adalah '1', jika tidak, final_round adalah '0'
	done <= '1' when register_output = "1101100" else '0'; -- jika output register adalah "1101100", done adalah '1', jika tidak, done adalah '0'
end architecture behavior;
