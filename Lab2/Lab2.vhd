library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab2 is
	Port(	x: 		in std_logic_vector(9 downto 0);
			y:			in std_logic_vector(9 downto 0);
			N:			in std_logic_vector(9 downto 0) := (others => '0');
			clk: 		in std_logic;
			rst: 		in std_logic;
			mac:		out std_logic_vector(22 downto 0);
			ready:	out std_logic);
end Lab2;

architecture arch of Lab2 is

signal num: signed(22 downto 0) := (others => '0');

begin

	process(clk,rst)
		variable num_var: signed(22 downto 0);
		variable count: integer := to_integer(unsigned(N));
	begin
		if rst = '1' then
			num_var := (others => '0');
			count := to_integer(unsigned(N));
		elsif rising_edge(clk) and count > 0 then
			num_var := num_var + signed(x) * signed(y);
			count := count - 1;
		else
			-- do nothing
		end if;

		if count = 0 then
			ready <= '1';
		else
			ready <= '0';
		end if;
		num <= num_var;
	end process;
	mac <= std_logic_vector(num);
end arch;




