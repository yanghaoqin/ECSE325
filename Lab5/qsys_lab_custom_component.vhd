library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY qsys_lab_custom_component IS
	PORT (
		clock, resetn : IN STD_LOGIC;
		read, write, chipselect : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END qsys_lab_custom_component;

ARCHITECTURE Structure OF qsys_lab_custom_component IS
	SIGNAL to_component, from_component : STD_LOGIC_VECTOR(31 DOWNTO 0);

COMPONENT qsys_lab_function
	PORT ( 	clock, resetn : IN STD_LOGIC;
				read, write, chipselect : IN STD_LOGIC;
				address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				in_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				out_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

BEGIN
	to_component <= writedata;
	component_inst: qsys_lab_function PORT MAP (clock, resetn, read, write, chipselect, address, to_component, from_component);
	readdata <= from_component;
END Structure;

