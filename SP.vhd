library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SP IS
    PORT(
        clk : IN std_logic;
        reset : IN std_logic;
        input_signal : IN std_logic_vector(15 DOWNTO 0);
        F : OUT std_logic_vector(15 DOWNTO 0)
    );
END SP;

ARCHITECTURE behavioral OF SP IS
    SIGNAL SP_value : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            SP_value <= (OTHERS => '1');
        ELSIF rising_edge(clk) THEN
                SP_value <= input_signal;
        END IF;
    END PROCESS;

    F <= SP_value;
END behavioral;
