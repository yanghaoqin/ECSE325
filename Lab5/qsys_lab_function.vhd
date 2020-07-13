library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity qsys_lab_function is
	PORT (
		clock, resetn : IN STD_LOGIC;
		read, write, chipselect : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end qsys_lab_function;

architecture behavior of qsys_lab_function is
	signal data1, data2:	std_logic_vector(31 downto 0);
	signal output: std_logic_vector(31 downto 0);
begin
	process(clock,resetn) begin
		if resetn = '0' then
			data1 <= (others => '0');
			data2 <= (others => '0');
			output <= (others => '0');
		elsif rising_edge(clock) then
			if write = '1' then
				if address(0) = '1' then
					data1 <= readdata;
				elsif address (0) = '0' then
					data2 <= readdata;
				else
					-- do nothing
				end if;
			elsif read = '1' then
				output <= signed(data1(15 downto 0)) * signed(data2(15 downto 0));
			else
				-- do nothing
			end if;
		else
			-- do nothing
		end if;
	end process;
	writedata <= std_logic_vector(output);
end behavior;

