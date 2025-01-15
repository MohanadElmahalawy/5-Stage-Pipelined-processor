library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_HLT IS 
	PORT(
	sel:IN std_logic;
	A:IN std_logic_vector(11 DOWNTO 0);--ADDER
	B:IN std_logic_vector(11 DOWNTO 0);--HLT PC
	
	F:OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_HLT;

ARCHITECTURE arch1 OF MUX_HLT IS	
BEGIN
	F<=A WHEN sel='0'
	ELSE B;
	
END arch1;