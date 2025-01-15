LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY F_D IS
  PORT (
    -- inputs
    i_clk : IN STD_LOGIC;
    i_reset : IN STD_LOGIC; 
	 
    i_pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_pc_1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 i_InPort: In STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	 i_IMM: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_OPCODE:IN std_logic_vector(4 DOWNTO 0);
	 i_RDST:IN std_logic_vector(2 DOWNTO 0);
	 i_Rsrc1:IN std_logic_vector(2 DOWNTO 0);
	 i_Rsrc2:IN std_logic_vector(2 DOWNTO 0);
	 
    -- outputs
    o_pc : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_pc_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 o_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    o_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	 o_IMM: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_OPCODE:OUT std_logic_vector(4 DOWNTO 0);
	 o_RDST:OUT std_logic_vector(2 DOWNTO 0);
	 o_Rsrc1:OUT std_logic_vector(2 DOWNTO 0);
	 o_Rsrc2:OUT std_logic_vector(2 DOWNTO 0)
  );
END ENTITY F_D;

ARCHITECTURE Behavioral OF F_D IS
BEGIN
  PROCESS (i_reset,i_clk)
  BEGIN
    IF i_reset = '1' THEN 
      o_pc <= (OTHERS => '0');
		o_pc_1 <= (OTHERS => '0');
      o_InPort <= (OTHERS => '0');
      o_instruction <= (OTHERS => '0');
		o_IMM<=(OTHERS => '0');
		o_OPCODE<= (OTHERS => '0');
		o_RDST<= (OTHERS => '0');
		o_Rsrc1<= (OTHERS => '0');
		o_Rsrc2<= (OTHERS => '0');
    ELSIF rising_edge(i_clk) THEN
      o_pc <= i_pc;
		o_pc_1 <= i_pc_1;
		o_InPort <= i_InPort;
      o_instruction <= i_instruction;
		o_IMM<=i_IMM;
		o_OPCODE<=i_OPCODE;
		o_RDST<= i_RDST;
		o_Rsrc1<= i_Rsrc1;
		o_Rsrc2<= i_Rsrc2;
	 END IF;	
  END PROCESS;
END ARCHITECTURE Behavioral;