library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY JMP_ADD_GENERATOR IS 
	PORT(
	A:IN std_logic_vector(31 DOWNTO 0);
	F:OUT std_logic_vector(31 DOWNTO 0)
	);
END JMP_ADD_GENERATOR;	

ARCHITECTURE arch1 OF JMP_ADD_GENERATOR IS
	
signal A_GENERATOR: std_logic_vector(31 DOWNTO 0);
signal B_GENERATOR: std_logic_vector(31 DOWNTO 0);
BEGIN
	A_GENERATOR<=(A(15 DOWNTO 0) & "0000000000000000");

	B_GENERATOR<="00000000000000001111100000000001";--0000 0000 0000 0000 11111 000 0000 0001 (OPCODE=11111, MULTIFLAG=1)
	F<=(A_GENERATOR OR B_GENERATOR);
	
END arch1;		