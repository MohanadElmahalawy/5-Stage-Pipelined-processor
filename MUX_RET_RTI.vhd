library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_RET_RTI IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(11 DOWNTO 0);--ADDER PC / HLT PC
	B:IN std_logic_vector(11 DOWNTO 0);--DM[SP]
	
	F:OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_RET_RTI;

ARCHITECTURE arch1 OF MUX_RET_RTI IS	
BEGIN
	F<=A WHEN sel='0'
	ELSE B;
	
END arch1;