library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab1_tb is
end Lab1_tb;

architecture test of Lab1_tb is

component Lab1 is
	Port(	clk: in std_logic;
		direction: in std_logic;
		rst: in std_logic;
		enable: in std_logic;
		output: out std_logic_vector(7 downto 0));
end component Lab1;

	constant T_clk: time := 100 ps;
	signal	clk: std_logic;
	signal	direction: std_logic;
	signal	rst: std_logic;
	signal	enable: std_logic;
	signal	output: std_logic_vector(7 downto 0);

begin
Lab1_inst: Lab1
	port map(
		clk => clk,
		direction => direction,
		rst => rst,
		enable => enable,
		output => output);

clk_gen: process
begin
	clk <= '1';
	wait for T_clk / 2;
	clk <= '0';
	wait for T_clk / 2;
end process clk_gen;

generate_test: process
begin

	rst <= '0';
	enable <= '1';
	direction <= '0'; 

	wait for 10*T_clk;

	rst <= '1';
	
	wait for 2*T_clk;
	
	rst <= '0';

	wait for 10*T_clk;

wait;
end process generate_test;

end test;







