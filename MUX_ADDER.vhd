library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MUX_ADDER IS 
    PORT(
        sel: IN std_logic;                            
        F: OUT std_logic_vector(11 DOWNTO 0)       
    );
END MUX_ADDER;    

ARCHITECTURE arch1 OF MUX_ADDER IS
    -- Internal signals to hold the default values
    SIGNAL A_internal: std_logic_vector(11 DOWNTO 0) := "000000000001"; -- Default value for A
    SIGNAL B_internal: std_logic_vector(11 DOWNTO 0) := "000000000010"; -- Default value for B
BEGIN
    -- MUX logic to select A or B based on sel
    F <= A_internal WHEN sel = '0' ELSE B_internal;
END arch1;
