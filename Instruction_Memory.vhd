LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY Instruction_Memory IS
  PORT (
    -- inputs
    i_address : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    -- outputs
    o_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	 o_index : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
  );
END ENTITY Instruction_Memory;	

ARCHITECTURE behavioral OF Instruction_Memory IS
  TYPE t_memory IS ARRAY (0 TO 2 ** 12 - 1) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL r_mem : t_memory;
  
  
--  COMPONENT my_nadder IS
--PORT (
	--a, b : IN std_logic_vector(11 DOWNTO 0) ;
	--cin : IN std_logic;
	--s : OUT std_logic_vector(11 DOWNTO 0);
	--cout : OUT std_logic
	--);
	--END COMPONENT;
	
	--signal cin: std_logic;--cin=0
	--signal cout: std_logic;--cout=0
	signal i_address_1: std_logic_vector(15 DOWNTO 0);--I_ADDRESS +1
	--signal o_address_1: std_logic_vector(11 DOWNTO 0);

BEGIN
	--cin<='0';
	--cout<='0';
	i_address_1<="0000000000000001";
	--NEW_ADDER: my_nadder port map(i_address,i_address_1, cin, o_address_1, cout);

  o_instruction <= (r_mem(TO_INTEGER(UNSIGNED(i_address_1))) & r_mem(TO_INTEGER(UNSIGNED(i_address))));
  o_index <= i_address;
END ARCHITECTURE behavioral;