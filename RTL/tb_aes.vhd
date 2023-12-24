-- Import the IEEE library and the standard logic package
library ieee;
use ieee.std_logic_1164.all;

-- Define an entity named 'tb_aes'
entity tb_aes is 
end tb_aes;

architecture behavior of tb_aes is
	component aes_enc
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;
			key        : in  std_logic_vector(5 downto 0);
			plaintext  : in  std_logic_vector(5 downto 0);
			ciphertext : out std_logic_vector(5 downto 0);
			done       : out std_logic
		);		
	end component aes_enc;	
	-- Input signals
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal plaintext : std_logic_vector(5 downto 0);
	signal key : std_logic_vector(5 downto 0);	
	
	-- Output signals
	signal done : std_logic;
	signal ciphertext : std_logic_vector(5 downto 0);	
	
	-- Clock period definition
	constant clk_period : time := 10 ns;
	
begin
	enc_inst : aes_enc
		port map(
			clk        => clk,
			rst        => rst,
			key        => key,
			plaintext  => plaintext,
			ciphertext => ciphertext,
			done       => done
		);	
	-- clock process definitions
	clk_process : process is
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process clk_process;
	
	-- Simulation process
	sim_proc : process is
	begin
		plaintext <= "110100";
		key <= "111100";
		rst <= '0';
		-- Hold reset state for one cycle		
		wait for clk_period * 1;
		rst <= '1';
		wait until done = '1';
		wait for clk_period/2;
		if (ciphertext = "110010") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;
	
		plaintext <= "000000";
		key <= "000000";
		rst <= '0';
		-- Hold reset state for one cycle		
		wait for clk_period * 1;
		rst <= '1';
		wait until done = '1';
		wait for clk_period/2;			
		if (ciphertext = "101110") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;
		report "---------- Output must be: -------";
		report "101110";
	
		plaintext <= "101010";
		key <= "111100";
		rst <= '0';
		-- Hold reset state for one cycle		
		wait for clk_period * 1;
		rst <= '1';
		wait until done = '1';
		wait for clk_period/2;			
		if (ciphertext = "100111") then
			report "---------- Passed ----------";
		else
			report "---------- Failed ----------";
		end if;
		report "---------- Output must be: -------";
		report "100111";
		wait;
	end process sim_proc;
	
end architecture behavior;
