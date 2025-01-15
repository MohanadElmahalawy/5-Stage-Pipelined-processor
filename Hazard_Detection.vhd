LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Hazard_Detection IS
    PORT (
        i_Arsc1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_Arsc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_Ardst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_AMemRead : IN STD_LOGIC;
        o_Hazard : OUT STD_LOGIC
    );
END Hazard_Detection;

ARCHITECTURE Behavioral OF Hazard_Detection IS
BEGIN
    o_Hazard <= '1' WHEN (i_Arsc1 = i_Ardst OR i_Arsc2 = i_Ardst) AND i_AMemRead = '1' 
	 ELSE '0';
        
END Behavioral;