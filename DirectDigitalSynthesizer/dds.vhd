----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Raymond Yang
-- 
-- Create Date: 08/11/2020 03:36:45 PM
-- Design Name: DDS
-- Module Name: dds - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dds is
    Port (  clk:        in  std_logic;
            reset_n:    in  std_logic;
            Fword:      in  std_logic_vector(31 downto 0);
            Pword:      in  std_logic_vector(10 downto 0);
            DA_data:     out std_logic_vector(9 downto 0));
end dds;

architecture Behavioral of dds is

    signal  r_Fword:    std_logic_vector(31 downto 0);
    signal  r_Pword:    std_logic_vector(10 downto 0);
    signal  Fcnt:       std_logic_vector(31 downto 0) := x"00000000";
    signal  rom_addr:   std_logic_vector(10 downto 0);    
        
begin


    process(clk)
    begin
        r_Fword <= Fword;
        r_Pword <= Pword;
    end process;

    process(clk,reset_n) 
    begin
        if(reset_n = '0') then
            Fcnt <= (others => '0');
        else
            Fcnt <= std_logic_vector(unsigned(Fcnt) + unsigned(r_Fword));
        end if;                                          
    end process;
    
    rom_addr <= std_logic_vector(unsigned(Fcnt(31 downto 21)) + unsigned(r_Pword));
    DA_data <= rom_addr(9 downto 0);

end Behavioral;
