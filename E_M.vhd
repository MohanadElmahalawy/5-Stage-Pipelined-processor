LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY E_M IS
  PORT (
  
	 --control signals
	 
	 
	 
    -- inputs
    i_clk : IN STD_LOGIC;
    i_reset : IN STD_LOGIC;
    i_pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_pc_1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 i_InPort: In STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_Ardst	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);--Address of Rdst
	 i_Vrsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc1
	 i_immediate: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_flags: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 i_alu: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 
	 INC_CU_EM_I:IN STD_LOGIC;
	 DEC_CU_EM_I:IN STD_LOGIC;
	 Enablee_SP_EM_I:IN STD_LOGIC;
	 SEL_ALU_IMM_EM_I: IN STD_LOGIC;
	 SEL_STORE_EM_I: IN STD_LOGIC;
	 SEL_SP_MUX_EM_I: IN STD_LOGIC;
	 FLAG_SEL_EM_I: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	 AND_PU_EM_I: IN STD_LOGIC;
	 MEM_READ_EM_I: IN STD_LOGIC;
	 MEM_WRITE_EM_I: IN STD_LOGIC;
	 MEM_FOR_EM_I: IN STD_LOGIC;
	 
	 IN_OR_CCR_EM_I: IN STD_LOGIC;
	 RET_RTI_EM_I: IN STD_LOGIC;
	 REG_WRITE_EM_I: IN STD_LOGIC;
	 FETCH_ADDER_EN_EM_I: IN STD_LOGIC;
	 OUT_MUX_EM_I: IN STD_LOGIC;
	 SET_CCR_EN_EM_I: IN STD_LOGIC;
	 SEL_WB_REG_EM_I: IN STD_LOGIC_vector(1 downto 0);
    -- outputs
    o_pc : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_pc_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 o_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_Ardst	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_Vrsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_immediate: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_flags: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_alu: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

	 INC_CU_EM_O:OUT STD_LOGIC;
	 DEC_CU_EM_O:OUT STD_LOGIC;
	 Enablee_SP_EM_O:OUT STD_LOGIC;
	 SEL_ALU_IMM_EM_O: OUT STD_LOGIC;
	 SEL_STORE_EM_O: OUT STD_LOGIC;
	 SEL_SP_MUX_EM_O: OUT STD_LOGIC;
	 FLAG_SEL_EM_O: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	 AND_PU_EM_O: OUT STD_LOGIC;
	 MEM_READ_EM_O: OUT STD_LOGIC;
	 MEM_WRITE_EM_O: OUT STD_LOGIC;
	 MEM_FOR_EM_O: OUT STD_LOGIC;
	 
	 IN_OR_CCR_EM_O: OUT STD_LOGIC;
	 RET_RTI_EM_O: OUT STD_LOGIC;
	 REG_WRITE_EM_O: OUT STD_LOGIC;
	 FETCH_ADDER_EN_EM_O: OUT STD_LOGIC;
	 OUT_MUX_EM_O: OUT STD_LOGIC;
	 SET_CCR_EN_EM_O: OUT STD_LOGIC;
	 SEL_WB_REG_EM_O: OUT STD_LOGIC_vector(1 downto 0)
  );
END ENTITY E_M;

ARCHITECTURE Behavioral OF E_M IS
BEGIN
  PROCESS (i_reset,i_clk)
  BEGIN
    IF i_reset = '1' THEN 
      o_pc <= (OTHERS => '0');
		o_pc_1 <= (OTHERS => '0');
      o_InPort <= (OTHERS => '0');
		o_Ardst	<= (OTHERS => '0');
		o_Vrsrc1 <= (OTHERS => '0');
		o_immediate <= (OTHERS => '0');
		o_flags <= (OTHERS => '0');
		o_alu <= (OTHERS => '0');
    ELSIF rising_edge(i_clk) THEN
      o_pc <= i_pc;
		o_pc_1 <= i_pc_1;
      o_InPort <= i_InPort;
		o_Ardst	<= i_Ardst;
		o_Vrsrc1 <= i_Vrsrc1;
		o_immediate <= i_immediate;
		o_flags <= i_flags;
		o_alu <= i_alu;
		INC_CU_EM_O <= INC_CU_EM_I;
		DEC_CU_EM_O <= DEC_CU_EM_I;
		Enablee_SP_EM_O <= Enablee_SP_EM_I;
		SEL_ALU_IMM_EM_O <= SEL_ALU_IMM_EM_I;
		SEL_STORE_EM_O <= SEL_STORE_EM_I;
		SEL_SP_MUX_EM_O <= SEL_SP_MUX_EM_I;
		FLAG_SEL_EM_O <= FLAG_SEL_EM_I;
		AND_PU_EM_O <= AND_PU_EM_I;
		MEM_READ_EM_O <= MEM_READ_EM_I;
		MEM_WRITE_EM_O <= MEM_WRITE_EM_I;
		MEM_FOR_EM_O <= MEM_FOR_EM_I;
		IN_OR_CCR_EM_O <= IN_OR_CCR_EM_I;
		RET_RTI_EM_O <= RET_RTI_EM_I;
		REG_WRITE_EM_O <= REG_WRITE_EM_I;
		FETCH_ADDER_EN_EM_O <= FETCH_ADDER_EN_EM_I;
		OUT_MUX_EM_O <= OUT_MUX_EM_I;
		SET_CCR_EN_EM_O <= SET_CCR_EN_EM_I;
		SEL_WB_REG_EM_O <= SEL_WB_REG_EM_I;
	 END IF;	
  END PROCESS;
END ARCHITECTURE Behavioral;