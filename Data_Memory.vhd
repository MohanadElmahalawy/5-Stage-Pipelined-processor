LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
  PORT (
    -- inputs
    clk        : IN STD_LOGIC;                          
    i_address  : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); 
    i_data     : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');    
    mem_read   : IN STD_LOGIC;                    
    mem_write  : IN STD_LOGIC;                   
    -- outputs
    o_data     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')       
  );
END ENTITY Data_Memory;

ARCHITECTURE behavioral OF Data_Memory IS
  CONSTANT MEM_SIZE : INTEGER := 4095;  -- Maximum memory address
  TYPE t_memory IS ARRAY (0 TO MEM_SIZE) OF STD_LOGIC_VECTOR(15 DOWNTO 0); 
  SIGNAL r_mem : t_memory;   
BEGIN

  PROCESS (clk)
  BEGIN
--   IF TO_INTEGER(UNSIGNED(i_address)) <= MEM_SIZE THEN
--          o_exception<='0';
--	ELSE 
--			o_exception<='1';
--   END IF;
    IF rising_edge(clk) THEN
      -- Read operation
      IF mem_read = '1' THEN
        IF TO_INTEGER(UNSIGNED(i_address)) <= MEM_SIZE THEN
          o_data <= r_mem(TO_INTEGER(UNSIGNED(i_address)));  
        END IF;
      END IF;
    END IF;

    IF falling_edge(clk) THEN
      -- Write operation
      IF mem_write = '1' THEN
        IF TO_INTEGER(UNSIGNED(i_address)) <= MEM_SIZE THEN
          r_mem(TO_INTEGER(UNSIGNED(i_address))) <= i_data;  
        END IF;
      END IF;
    END IF;

  END PROCESS;

END ARCHITECTURE behavioral;
