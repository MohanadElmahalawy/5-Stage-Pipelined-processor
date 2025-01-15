library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_UNCON_JMP IS 
	PORT(
		sel: IN std_logic_vector(1 DOWNTO 0);
		A: IN std_logic_vector(11 DOWNTO 0);
		B: IN std_logic_vector(11 DOWNTO 0);
		F: OUT std_logic_vector(11 DOWNTO 0)
	);
END MUX_UNCON_JMP;	

ARCHITECTURE arch1 OF MUX_UNCON_JMP IS
    SIGNAL C_SIGNAL: std_logic_vector(11 DOWNTO 0);
BEGIN
    C_SIGNAL <= "000000000011";  -- Define the value of C_SIGNAL

    F <= A WHEN sel = "00" ELSE
         B WHEN sel = "01" ELSE
         C_SIGNAL;  
END arch1;
