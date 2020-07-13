library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CmplxSquare is
    Port(
        i_clk       :   in  std_logic;
        i_rstb      :   in  std_logic;
        i_x, i_y    :   in  std_logic_vector(31 downto 0);
        o_xx, o_yy  :   out std_logic_vector(64 downto 0));
end CmplxSquare;

architecture behavior of CmplxSquare is
    signal r_x, r_y :   signed(31 downto 0);
begin
    p_mult: process(i_clk,i_rstb) begin
        if i_rstb = '0' then
            o_xx <= (others => '0');
            o_yy <= (others => '0');
            r_x <= (others => '0');
            r_y <= (others => '0');

        elsif(rising_edge(i_clk)) then
            r_x <= signed(i_x);
            r_y <= signed(i_y);
            o_xx <= std_logic_vector(('0' & (r_x * r_x)) - r_y * r_y);
            o_yy <= std_logic_vector(r_x*r_y & '0');
        else
            -- do nothing
        end if;
    end process p_mult;
end behavior;




