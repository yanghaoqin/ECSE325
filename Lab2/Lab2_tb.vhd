library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Lab2_tb is
end Lab2_tb;

architecture test of Lab2_tb is

component Lab2 is
	Port(	x: 	in std_logic_vector(9 downto 0);
		y:	in std_logic_vector(9 downto 0);
		N:	in std_logic_vector(9 downto 0);
		clk: 	in std_logic;
		rst: 	in std_logic;
		mac:	out std_logic_vector(22 downto 0);
		ready:	out std_logic);
end component Lab2;

file file_VECTORS_X:	text;
file file_VECTORS_Y:	text;
file file_RESULTS:	text;

constant T_clk: time := 10 ns;

signal	x_in:	std_logic_vector(9 downto 0);
signal	y_in:	std_logic_vector(9 downto 0);
signal	N_in:	std_logic_vector(9 downto 0);
signal	clk_in: 	std_logic;
signal	rst_in: 	std_logic;
signal	mac_out:	std_logic_vector(22 downto 0) := (others => '0');
signal	ready_out:	std_logic;

begin
Lab2_inst: Lab2
	port map(
		x => x_in,
		y => y_in,
		N => N_in,
		clk => clk_in,
		rst => rst_in,
		mac => mac_out,
		ready => ready_out);

clk_gen: process
begin
	clk_in <= '1';
	wait for T_clk / 2;
	clk_in <= '0';
	wait for T_clk / 2;
end process clk_gen;

feeding_instr: process
	variable v_Iline1:	line;
	variable v_Iline2:	line;
	variable v_Oline:	line;
	variable v_x_in:	std_logic_vector(9 downto 0);
	variable v_y_in:	std_logic_vector(9 downto 0);
	variable count:		integer := 1000;
begin
      --reset the circuit
	N_in <= "1111101000";  --N = 1000
    rst_in <= '1';
    wait until rising_edge(clk_in);
    wait until rising_edge(clk_in);
    rst_in <= '0';

    file_open(file_VECTORS_X, "C:\Users\Raymond Yang\Desktop\FPGA\Lab2\lab2x.txt", read_mode);
    file_open(file_VECTORS_Y, "C:\Users\Raymond Yang\Desktop\FPGA\Lab2\lab2y.txt", read_mode);
    file_open(file_RESULTS, "C:\Users\Raymond Yang\Desktop\FPGA\Lab2\lab2out.txt", write_mode);

    while not endfile (file_VECTORS_X) loop
   		readline(file_VECTORS_X, v_Iline1);
        read(v_Iline1, v_x_in);
        readline(file_VECTORS_Y, v_Iline2);
        read(v_Iline2, v_y_in);
      
        x_in <= v_x_in;
        y_in <= v_y_in;
    
        wait until rising_edge(clk_in);
		if count = 1 then
			-- do nothing
		else
        	write(v_Oline, mac_out);
        	writeline(file_RESULTS, v_Oline);
		end if;
    end loop;

	wait until rising_edge(clk_in);
    write(v_Oline, mac_out);
    writeline(file_RESULTS, v_Oline);
	
	file_close(file_VECTORS_X);
	file_close(file_VECTORS_Y);
	file_close(file_RESULTS);

wait;
end process feeding_instr;

end test;








