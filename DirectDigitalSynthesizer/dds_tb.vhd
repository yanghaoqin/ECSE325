library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dds_tb is
end dds_tb;

architecture test of dds_tb is

component dds is
    Port (  clk:        in  std_logic;
            reset_n:    in  std_logic;
            Fword:      in  std_logic_vector(31 downto 0);
            Pword:      in  std_logic_vector(10 downto 0);
            DA_data:     out std_logic_vector(9 downto 0));
end component dds;


constant T_clk: time := 100 ns;

signal	clk_in: 	std_logic;
signal	reset_n_in: 	std_logic;
signal  Fword_in:   std_logic_vector(31 downto 0);
signal  Pword_In:   std_logic_vector(10 downto 0);
signal  DA_data_out:    std_logic_vector(9 downto 0);

begin
dds_inst: dds
	port map(
        clk => clk_in,
        reset_n => reset_n_in,
        Fword => Fword_in,
        Pword => Pword_in,
        DA_data => DA_data_out);

clk_gen: process
begin
	clk_in <= '1';
	wait for T_clk / 2;
	clk_in <= '0';
	wait for T_clk / 2;
end process clk_gen;

feeding_instr: process

begin
      --reset the circuit
    reset_n_in <= '0';
    Fword_in <= x"00200000";
    Pword_in <= (others => '0');
    wait for T_clk*2;
    reset_n_in <= '1';

wait;
end process feeding_instr;

end test;