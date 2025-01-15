library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_NOP IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(31 DOWNTO 0);--NORMAL INSTRUCTION
	B:IN std_logic_vector(31 DOWNTO 0);--NOP
	
	F:OUT std_logic_vector(31 DOWNTO 0)
	);
END MUX_NOP;	

ARCHITECTURE arch1 OF MUX_NOP IS	
BEGIN
	F<=A WHEN sel='0' 
	ELSE B;
	
END arch1;		