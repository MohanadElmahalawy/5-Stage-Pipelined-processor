library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY my_adder IS
	PORT(A,B,Cin:IN std_logic;
	s,Cout:OUT std_logic);
	
END my_adder;

ARCHITECTURE a_my_adder OF my_adder IS
BEGIN
	s<=A XOR B XOR Cin;
	Cout<=(A AND B) OR (Cin AND (A XOR B));
END a_my_adder;
