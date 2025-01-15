library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_EXCEPTION IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(11 DOWNTO 0);--ADDER PC / HLT PC/ DM[SP]/ R[RSRC1]
	B:IN std_logic_vector(11 DOWNTO 0);--EXCEPTION ADDRESS
	
	F:OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_EXCEPTION;	

ARCHITECTURE arch1 OF MUX_EXCEPTION IS	
BEGIN
	F<=A WHEN sel='0'
	ELSE B;
	
END arch1;