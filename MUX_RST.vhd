library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_RST IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(11 DOWNTO 0);--PC
	
	F:OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_RST;	

ARCHITECTURE arch1 OF MUX_RST IS	
SIGNAL B_internal: std_logic_vector(11 DOWNTO 0) := "000000000000";
BEGIN
	F<=A WHEN sel='0' 
	ELSE B_internal;
	
END arch1;