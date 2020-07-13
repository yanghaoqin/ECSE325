library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab1 is
	Port(	clk: in std_logic;
			direction: in std_logic;
			rst: in std_logic;
			enable: in std_logic;
			output: out bit_vector(7 downto 0) := (others => '0'));

end Lab1;

architecture struct of Lab1 is
	signal count: bit_vector(7 downto 0) := "00000000";
begin
	process(clk)
	begin
		
		if rising_edge(clk) then
			if rst = '1' then
				count <= (others => '0');
			else
				
				if enable = '1' then
					if direction = '0' then
						count <= count + 1;
					else
						count <= count - 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	output <= count;
end struct;