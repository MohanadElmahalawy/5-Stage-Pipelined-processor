library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_PRED IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(11 DOWNTO 0);--ADDER PC / HLT PC/ DM[SP]
	B:IN std_logic_vector(11 DOWNTO 0);--R[RSRC1]
	
	F:OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_PRED;

ARCHITECTURE arch1 OF MUX_PRED IS	
BEGIN
	F<=A WHEN sel='0'
	ELSE B;
	
END arch1;