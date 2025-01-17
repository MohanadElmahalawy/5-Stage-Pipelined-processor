LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY D_E IS
  PORT (
  
	 --control signals
    -- inputs
    i_clk : IN STD_LOGIC;
    i_reset : IN STD_LOGIC;
    i_pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_pc_1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 i_InPort: In STD_LOGIC_VECTOR(15 DOWNTO 0);
    i_Arsrc1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);--Address of Rsrc1
	 i_Arsrc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);--Address of Rsrc2
	 i_Ardst	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);--Address of Rdst
	 i_Vrsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc1
	 i_Vrsrc2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc2
	 i_immediate: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_index:IN STD_LOGIC;
	 ALU_OPCODE_CU_DE_I: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 ALU_SRC2_DE_I: IN STD_LOGIC;
	 CCR_OR_Enablee_DE_I: IN STD_LOGIC; ------LESAAAAAAAAAAAAAAA
	 CCR_RST_Z_DE_I: IN STD_LOGIC;
	 CCR_RST_N_DE_I: IN STD_LOGIC;
	 CCR_RST_C_DE_I: IN STD_LOGIC;
	 INPUT_EX_DE_I: IN STD_LOGIC;
	 SETC_DE_I: IN STD_LOGIC;
    INC_CU_DE_I:IN STD_LOGIC;
	 DEC_CU_DE_I:IN STD_LOGIC;
	 Enablee_SP_DE_I:IN STD_LOGIC;
	 SEL_ALU_IMM_DE_I: IN STD_LOGIC;
	 SEL_STORE_DE_I: IN STD_LOGIC;
	 SEL_SP_MUX_DE_I: IN STD_LOGIC;
	 FLAG_SEL_DE_I: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	 AND_PU_DE_I: IN STD_LOGIC;
	 MEM_READ_DE_I: IN STD_LOGIC;
	 MEM_WRITE_DE_I: IN STD_LOGIC;
	 MEM_FOR_DE_I: IN STD_LOGIC;
	 IN_OR_CCR_DE_I: IN STD_LOGIC;
	 RET_RTI_DE_I: IN STD_LOGIC;
	 REG_WRITE_DE_I: IN STD_LOGIC;
	 FETCH_ADDER_EN_DE_I: IN STD_LOGIC;
	 OUT_MUX_DE_I: IN STD_LOGIC;
	 SET_CCR_EN_DE_I: IN STD_LOGIC;
	 SEL_WB_REG_DE_I: IN STD_LOGIC_vector(1 downto 0);
    -- outputs
    o_pc : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_pc_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 o_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    o_Arsrc1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_Arsrc2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_Ardst	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_Vrsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_Vrsrc2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_immediate: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_index:OUT STD_LOGIC;
	 ALU_OPCODE_CU_DE_O: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	 ALU_SRC2_DE_O: OUT STD_LOGIC;
	 CCR_OR_Enablee_DE_O: OUT STD_LOGIC; ------LESAAAAAAAAAAAAAAA
	 CCR_RST_Z_DE_O: OUT STD_LOGIC;
	 CCR_RST_N_DE_O: OUT STD_LOGIC;
	 CCR_RST_C_DE_O: OUT STD_LOGIC;
	 INPUT_EX_DE_O: OUT STD_LOGIC;
	 SETC_DE_O: OUT STD_LOGIC;
	 INC_CU_DE_O:OUT STD_LOGIC;
	 DEC_CU_DE_O:OUT STD_LOGIC;
	 Enablee_SP_DE_O:OUT STD_LOGIC;
	 SEL_ALU_IMM_DE_O: OUT STD_LOGIC;
	 SEL_STORE_DE_O: OUT STD_LOGIC;
	 SEL_SP_MUX_DE_O: OUT STD_LOGIC;
	 FLAG_SEL_DE_O: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 AND_PU_DE_O: OUT STD_LOGIC;
	 MEM_READ_DE_O: OUT STD_LOGIC;
	 MEM_WRITE_DE_O: OUT STD_LOGIC;
	 MEM_FOR_DE_O: OUT STD_LOGIC;
	 IN_OR_CCR_DE_O: OUT STD_LOGIC;
	 RET_RTI_DE_O: OUT STD_LOGIC;
	 REG_WRITE_DE_O: OUT STD_LOGIC;
	 FETCH_ADDER_EN_DE_O: OUT STD_LOGIC;
	 OUT_MUX_DE_O: OUT STD_LOGIC;
	 SET_CCR_EN_DE_O: OUT STD_LOGIC;
	 SEL_WB_REG_DE_O: OUT STD_LOGIC_vector(1 downto 0)
  );
END ENTITY D_E;

ARCHITECTURE Behavioral OF D_E IS
BEGIN
  PROCESS (i_reset,i_clk)
  BEGIN
    IF i_reset = '1' THEN 
      o_pc <= (OTHERS => '0');
		o_pc_1 <= (OTHERS => '0');
      o_InPort <= (OTHERS => '0');
		o_Arsrc1 <= (OTHERS => '0');
		o_Arsrc2 <= (OTHERS => '0');
		o_Ardst	<= (OTHERS => '0');
		o_Vrsrc1 <= (OTHERS => '0');
		o_Vrsrc2 <= (OTHERS => '0');
		o_immediate <= (OTHERS => '0');
		o_index<='0';
    ELSIF rising_edge(i_clk) THEN
      o_pc <= i_pc;
		o_pc_1 <= i_pc_1;
      o_InPort <= i_InPort;
		o_Arsrc1 <= i_Arsrc1;
		o_Arsrc2 <= i_Arsrc2;
		o_Ardst	<= i_Ardst;
		o_Vrsrc1 <= i_Vrsrc1;
		o_Vrsrc2 <= i_Vrsrc2;
		o_immediate <= i_immediate;
		o_index<=i_index;
		ALU_OPCODE_CU_DE_O <= ALU_OPCODE_CU_DE_I;
		ALU_SRC2_DE_O <= ALU_SRC2_DE_I;
		CCR_OR_Enablee_DE_O <= CCR_OR_Enablee_DE_I;
		CCR_RST_Z_DE_O <= CCR_RST_Z_DE_I;
		CCR_RST_N_DE_O <= CCR_RST_N_DE_I;
		CCR_RST_C_DE_O <= CCR_RST_C_DE_I;
		INPUT_EX_DE_O <= INPUT_EX_DE_I;
		SETC_DE_O <= SETC_DE_I;
		INC_CU_DE_O<=INC_CU_DE_I;
		DEC_CU_DE_O <= DEC_CU_DE_I;
		Enablee_SP_DE_O <= Enablee_SP_DE_I;
		SEL_ALU_IMM_DE_O <= SEL_ALU_IMM_DE_I;
		SEL_STORE_DE_O <= SEL_STORE_DE_I;
		SEL_SP_MUX_DE_O <= SEL_SP_MUX_DE_I;
		FLAG_SEL_DE_O <= FLAG_SEL_DE_I;
		AND_PU_DE_O <= AND_PU_DE_I;
		MEM_READ_DE_O <= MEM_READ_DE_I;
		MEM_WRITE_DE_O <= MEM_WRITE_DE_I;
		MEM_FOR_DE_O <= MEM_FOR_DE_I;
		IN_OR_CCR_DE_O <= IN_OR_CCR_DE_I;
		RET_RTI_DE_O <= RET_RTI_DE_I;
		REG_WRITE_DE_O <= REG_WRITE_DE_I;
		FETCH_ADDER_EN_DE_O <= FETCH_ADDER_EN_DE_I;
		OUT_MUX_DE_O <= OUT_MUX_DE_I;
		SET_CCR_EN_DE_O <= SET_CCR_EN_DE_I;
		SEL_WB_REG_DE_O <= SEL_WB_REG_DE_I;
	 END IF;	
  END PROCESS;
END ARCHITECTURE Behavioral;