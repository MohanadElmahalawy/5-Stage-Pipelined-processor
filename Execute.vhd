library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY EXECUTE IS 
PORT(
	 CLK_EX: IN STD_LOGIC;
	 ALU_OPCODE_CU: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 ALU_SRC2: IN STD_LOGIC;
	 CCR_OR_Enablee: IN STD_LOGIC; ------LESAAAAAAAAAAAAAAA
	 CCR_RST_Z: IN STD_LOGIC;
	 CCR_RST_N: IN STD_LOGIC;
	 CCR_RST_C: IN STD_LOGIC;
	 TRI_STATE_CCR: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--	 PU_SEL: IN STD_LOGIC;
	 INPUT_EX: IN STD_LOGIC;
	 WB_SIGNAL:IN STD_LOGIC;
	 SETC: IN STD_LOGIC;
	 DE_pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 DE_pc_1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 DE_InPort: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    DE_Arsrc1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 DE_Arsrc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 DE_Ardst	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 DE_Vrsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 DE_Vrsrc2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 DE_immediate: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 SEL_FU1: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	 SEL_FU2: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	 
	 EM_pc : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 EM_pc_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
	 EM_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 EM_Ardst	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);--Address of Rdst
	 EM_Vrsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc1
	 EM_immediate: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 EM_flags: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	 EM_alu: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
--	 O_MEM_EXECUTE: OUT STD_LOGIC;
	 
);
END EXECUTE;

ARCHITECTURE ARCH_EXECUTE OF EXECUTE IS

	-- Signals for MUX_FORWARDING                              
	SIGNAL MEM_FOR_SIGNAL: std_logic_vector(15 DOWNTO 0);
	SIGNAL ALU_FOR_SIGNAL: std_logic_vector(15 DOWNTO 0);
	SIGNAL OUT_FU1_SIGNAL: std_logic_vector(15 DOWNTO 0);
	
	-- Signals for MUX_RSCR2                         
	SIGNAL OUT_MUXR2_SIGNAL: std_logic_vector(15 DOWNTO 0);
	
	-- Signals for MUX_FORWARDING2                              
	SIGNAL MEM_FOR_SIGNAL2: std_logic_vector(15 DOWNTO 0);
	SIGNAL ALU_FOR_SIGNAL2: std_logic_vector(15 DOWNTO 0);
	SIGNAL OUT_FU2_SIGNAL: std_logic_vector(15 DOWNTO 0);
	
	-- ALU Signals
	SIGNAL ALU_OUTPUT_SIGNAL : std_logic_vector(15 DOWNTO 0);
	SIGNAL FLAGS_SIGNAL: std_logic_vector(2 DOWNTO 0); --- Z N C---
	
	SIGNAL FLAGS_FINAL: std_logic_vector(2 DOWNTO 0); --- Z N C---
--	SIGNAL FLUSH_M: STD_LOGIC;
	-- ALU Component Declaration
	COMPONENT ALU IS
	PORT(
		REG1_ALU, REG2_ALU : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALU_OPCODE : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ALU_OUTPUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		FLAGS : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- Z N C
	);
	END COMPONENT;

	-- CCR Component Declaration
	COMPONENT CCR IS
	PORT(
		CLK : IN STD_LOGIC;
		FLAGS_IN : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Z N C
		Enablee : IN STD_LOGIC;
		FLAGS_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		RESET_Z : IN STD_LOGIC;
		RESET_N : IN STD_LOGIC;
		RESET_C : IN STD_LOGIC;
		RESET : IN STD_LOGIC;
		SET_C : IN STD_LOGIC;
		SET_CCR : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
	END COMPONENT;

BEGIN

	-- MUX_FORWARDING implementation
	PROCESS(SEL_FU1, DE_Vrsrc1, MEM_FOR_SIGNAL, ALU_FOR_SIGNAL)
	BEGIN
		IF SEL_FU1 = "00" THEN
			OUT_FU1_SIGNAL <= DE_Vrsrc1;
		ELSIF SEL_FU1 = "01" THEN
			OUT_FU1_SIGNAL <= ALU_FOR_SIGNAL;
		ELSIF SEL_FU1 = "10" THEN
			OUT_FU1_SIGNAL <= MEM_FOR_SIGNAL;
		ELSE
			OUT_FU1_SIGNAL <= DE_Vrsrc1; -- Default
		END IF;
	END PROCESS;

	-- MUX_RSCR2 implementation
	PROCESS(ALU_SRC2, DE_Vrsrc2, DE_immediate)
	BEGIN
		IF ALU_SRC2 = '0' THEN
			OUT_MUXR2_SIGNAL <= DE_Vrsrc2;
		ELSE
			OUT_MUXR2_SIGNAL <= DE_immediate;
		END IF;
	END PROCESS;

	-- MUX_FORWARDING2 implementation
	PROCESS(SEL_FU2, OUT_MUXR2_SIGNAL, MEM_FOR_SIGNAL2, ALU_FOR_SIGNAL2)
	BEGIN
		IF SEL_FU2 = "00" THEN
			OUT_FU2_SIGNAL <= OUT_MUXR2_SIGNAL;
		ELSIF SEL_FU2 = "01" THEN
			OUT_FU2_SIGNAL <= ALU_FOR_SIGNAL2;
		ELSIF SEL_FU2 = "10" THEN
			OUT_FU2_SIGNAL <= MEM_FOR_SIGNAL2;
		ELSE
			OUT_FU2_SIGNAL <= OUT_MUXR2_SIGNAL; -- Default
		END IF;
	END PROCESS;
	--FLUSH MUX1
--	PROCESS(PU_SEL, FLUSH_M)
--	BEGIN
--		IF PU_SEL = '1' THEN
--			FLUSH_M <= '0';
--		ELSE
--			FLUSH_M <='1';
--		END IF;
--	END PROCESS;
	-- ALU Component Instantiation
	ALU_INST: ALU
	PORT MAP(
		REG1_ALU => OUT_FU1_SIGNAL,
		REG2_ALU => OUT_FU2_SIGNAL,
		ALU_OPCODE => ALU_OPCODE_CU,
		ALU_OUTPUT => ALU_OUTPUT_SIGNAL,
		FLAGS => FLAGS_SIGNAL
	);

	-- CCR Component Instantiation
	CCR_INST: CCR
	PORT MAP(
		CLK => CLK_EX,
		FLAGS_IN => FLAGS_SIGNAL,
		Enablee => WB_SIGNAL OR INPUT_EX, -- Example Enablee Signal
		FLAGS_OUT => FLAGS_FINAL,
		RESET_Z => CCR_RST_Z,
		RESET_N => CCR_RST_N,
		RESET_C => CCR_RST_C,
		RESET => '0',
		SET_C => SETC,
		SET_CCR => TRI_STATE_CCR
	);

	-- Output Signals Assignment
	PROCESS(CLK_EX)
	BEGIN
		IF falling_edge(CLK_EX) THEN
			EM_alu <= ALU_OUTPUT_SIGNAL;
			EM_flags <= FLAGS_FINAL;
			EM_pc <= DE_pc;
			EM_pc_1 <= DE_pc_1;
			EM_InPort <= DE_InPort;
			EM_Ardst <= DE_Ardst;
			EM_Vrsrc1 <= DE_Vrsrc1;
			EM_immediate <= DE_immediate;
--			O_MEM_EXECUTE <= FLUSH_M;
		END IF;
	END PROCESS;

END ARCH_EXECUTE;
