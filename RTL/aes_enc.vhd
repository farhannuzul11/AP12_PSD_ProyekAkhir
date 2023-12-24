-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'aes_encrypt'
entity aes_encrypt is 
	-- Declare the input and output ports
	port (
		clock : in std_logic;
		reset : in std_logic;
		encryption_key : in std_logic_vector(5 downto 0);
		plain_text : in std_logic_vector(5 downto 0);
		cipher_text : out std_logic_vector(5 downto 0);
		completion_signal : out std_logic		
	);
end aes_encrypt;

-- Define the architecture of 'aes_encrypt'
architecture behavior of aes_encrypt is
	signal register_input : std_logic_vector(5 downto 0);
	signal register_output : std_logic_vector(5 downto 0);
	signal sub_box_input : std_logic_vector(5 downto 0);
	signal sub_box_output : std_logic_vector(5 downto 0);
	signal shift_rows_output : std_logic_vector(5 downto 0);
	signal mix_columns_output : std_logic_vector(5 downto 0);
	signal feedback_signal : std_logic_vector(5 downto 0);
	signal round_key_signal : std_logic_vector(5 downto 0);
	signal round_constant_signal : std_logic_vector(5 downto 0);
	signal select_signal : std_logic;
begin
	register_input <= plain_text when reset = '0' else feedback_signal;
	register_instance : entity work.reg
		generic map(
			size => 6
		)
		port map(
			clk => clock,
			d   => register_input,
			q   => register_output
		);
	-- Encryption body
	add_round_key_instance : entity work.add_round_key
		port map(
			in1 => register_output,
			in2 => round_key_signal,
			out1 => sub_box_input
		);
	sub_byte_instance : entity work.sub_byte
		port map(
			input_data  => sub_box_input,
			output_data => sub_box_output
			
		);
	shift_rows_instance : entity work.shift_rows
		port map(
			input  => sub_box_output,
			output => shift_rows_output
		);
	mix_columns_instance : entity work.mix_columns
		port map(
			input_data  => shift_rows_output,
			output_data => mix_columns_output
		);
	feedback_signal <= mix_columns_output when select_signal = '0' else shift_rows_output;
	cipher_text <= sub_box_input;	
	-- Controller
	controller_instance : entity work.control_unit
		port map(
			clk            => clock,
			rst            => reset,
			round_const    => round_constant_signal,
			final_round    => select_signal,
			done           => completion_signal
		);
	-- Keyschedule
	key_schedule_instance : entity work.key_sched
		port map(
			clk         => clock,
			rst         => reset,
			key         => encryption_key,
			round_const => round_constant_signal,
			round_key   => round_key_signal
		);	
end architecture behavior;
