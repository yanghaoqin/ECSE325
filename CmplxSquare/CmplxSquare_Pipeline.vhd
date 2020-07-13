library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CmplxSquare_Pipeline is
    Port(
        i_clk       :   in  std_logic;
        i_rstb      :   in  std_logic;
        i_x, i_y    :   in  std_logic_vector(31 downto 0);
        o_xx, o_yy  :   out std_logic_vector(64 downto 0));
end CmplxSquare_Pipeline;

architecture behavior of CmplxSquare_Pipeline is
    signal r_x, r_y :   signed(31 downto 0);
	 signal pr_x, pr_y:	signed(63 downto 0);
begin
    p_mult: process(i_clk,i_rstb) begin
        if i_rstb = '0' then
            o_xx <= (others => '0');
            o_yy <= (others => '0');
            r_x <= (others => '0');
            r_y <= (others => '0');
				pr_x <= (others => '0');
				pr_y <= (others => '0');
        elsif(rising_edge(i_clk)) then
            r_x <= signed(i_x);
            r_y <= signed(i_y);
				pr_x <= r_x * r_x;
				pr_y <= r_y * r_y;
            o_xx <= std_logic_vector(('0' & pr_x) - pr_y);
            o_yy <= std_logic_vector(r_x*r_y & '0');
        else
            -- do nothing
        end if;
    end process p_mult;
end behavior;




