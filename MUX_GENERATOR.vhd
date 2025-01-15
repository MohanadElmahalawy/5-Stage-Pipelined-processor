library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_GENERATOR IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(31 DOWNTO 0);--NORMAL INSTRUCTION
	B:IN std_logic_vector(31 DOWNTO 0);--JMP ADD GENERATOR
	
	F:OUT std_logic_vector(31 DOWNTO 0)
	);
END MUX_GENERATOR;	

ARCHITECTURE arch1 OF MUX_GENERATOR IS	
BEGIN
	F<=A WHEN sel='0' 
	ELSE B;
	
END arch1;