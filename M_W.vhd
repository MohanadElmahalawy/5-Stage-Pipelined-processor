LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY M_W IS
  PORT (
  
	 --control signals
    -- inputs
    i_clk : IN STD_LOGIC;
    i_reset : IN STD_LOGIC;
	 i_WB_MW : IN STD_LOGIC;
	 i_InPort: In STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_Ardst	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 i_Vrsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc1
	 i_alu: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 i_MemOut: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 IN_OR_CCR_MW_I: IN STD_LOGIC;
	 RET_RTI_MW_I: IN STD_LOGIC;
	 REG_WRITE_MW_I: IN STD_LOGIC;
	 FETCH_ADDER_EN_MW_I: IN STD_LOGIC;
	 OUT_MUX_MW_I: IN STD_LOGIC;
	 SET_CCR_EN_MW_I: IN STD_LOGIC;
	 SEL_WB_REG_MW_I: IN STD_LOGIC_vector(1 downto 0);
    -- outputs
	 o_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_Ardst	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 o_Vrsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_alu: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_MemOut: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 o_WB_MW : OUT STD_LOGIC;
	 IN_OR_CCR_MW_O: OUT STD_LOGIC;
	 RET_RTI_MW_O: OUT STD_LOGIC;
	 REG_WRITE_MW_O: OUT STD_LOGIC;
	 FETCH_ADDER_EN_MW_O: OUT STD_LOGIC;
	 OUT_MUX_MW_O: OUT STD_LOGIC;
	 SET_CCR_EN_MW_O: OUT STD_LOGIC;
	 SEL_WB_REG_MW_O: OUT STD_LOGIC_vector(1 downto 0)
  );
END ENTITY M_W;

ARCHITECTURE Behavioral OF M_W IS
BEGIN
  PROCESS (i_reset,i_clk)
  BEGIN
    IF i_reset = '1' THEN 
      o_InPort <= (OTHERS => '0');
		o_Ardst	<= (OTHERS => '0');
		o_Vrsrc1 <= (OTHERS => '0');
		o_alu <= (OTHERS => '0');
		o_MemOut <= (OTHERS => '0');
    ELSIF rising_edge(i_clk) THEN
      o_InPort <= i_InPort;
		o_Ardst	<= i_Ardst;
		o_Vrsrc1 <= i_Vrsrc1;
		o_alu <= i_alu;
		o_MemOut <= i_MemOut;
		o_WB_MW <= i_WB_MW;
		IN_OR_CCR_MW_O <= IN_OR_CCR_MW_I;
		RET_RTI_MW_O <= RET_RTI_MW_I;
		REG_WRITE_MW_O <= REG_WRITE_MW_I;
		FETCH_ADDER_EN_MW_O <= FETCH_ADDER_EN_MW_I;
		OUT_MUX_MW_O <= OUT_MUX_MW_I;
		SET_CCR_EN_MW_O <= SET_CCR_EN_MW_I;
		SEL_WB_REG_MW_O <= SEL_WB_REG_MW_I;
	 END IF;	
  END PROCESS;
END ARCHITECTURE Behavioral;