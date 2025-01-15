library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PC_comp IS
    PORT(
        clk : IN std_logic;
        reset : IN std_logic;
        input_signal : IN std_logic_vector(15 DOWNTO 0);
        F : OUT std_logic_vector(15 DOWNTO 0)
    );
END PC_comp;

ARCHITECTURE behavioral OF PC_comp IS
    SIGNAL pc_value : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            pc_value <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
                pc_value <= input_signal;
        END IF;
    END PROCESS;

    F <= pc_value;
END behavioral;
