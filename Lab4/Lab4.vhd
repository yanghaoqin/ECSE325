library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab4 is
	Port(	x:			in		std_logic_Vector(15 downto 0);
			clk:		in		std_logic;
			rst:		in		std_logic;
			y:			out		std_logic_vector(16 downto 0) := (others => '0')
	);
end Lab4;

architecture arch of Lab4 is

	type ARRAY25_16 is array(24 downto 0) of signed(15 downto 0);
	type ARRAY25_32 is array(24 downto 0) of signed(31 downto 0);
	constant b:		ARRAY25_16 := (0 => "0000001001110010",
											1 => "0000000000010001",
											2 => "1111111111010011",
											3 => "1111111011011110",
											4 => "0000001100011001",
											5 => "1111110110100111",
											6 => "1111110000001110",
											7 => "0000110110111100",
											8 => "1110110001110011",
											9 => "0000110111110111",
											10 => "0000001100000111",
											11 => "1110101000001010",
											12 => "0001111000110011",
											13 => "1110101000001010",
											14 => "0000001100000111",
											15 => "0000110111110111",
											16 => "1110110001110011",
											17 => "0000110110111100",
											18 => "1111110000001110",
											19 => "1111110110100111",
											20 => "0000001100011001",
											21 => "1111111011011110",
											22 => "1111111111010011",
											23 => "0000000000010001",
											24 => "0000001001110010");
	signal y_out:	signed(31 downto 0) := (others => '0');
	
begin

	filter: process(clk,rst)
		variable x_in:		ARRAY25_32 := (others => (others => '0'));
	begin
		if rst = '1' then
			x_in := (others => (others => '0'));
			y_out <= (others => '0');
		elsif rising_edge(clk) then
			conv_loop: for i in 24 downto 1 loop
				x_in(i) := x_in(i-1) + b(24-i) * signed(x);
			end loop conv_loop;
			x_in(0) := b(24) * signed(x);
			y_out <= x_in(24);
		else
			-- do nothing
		end if;		
	end process filter;
	y <= std_logic_vector(y_out(31 downto 15));
end arch;