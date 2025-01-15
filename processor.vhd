library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY processor IS
PORT(
	CLK : IN  STD_LOGIC;
	RST: IN  STD_LOGIC;
	INPORT:IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
	OUTPORT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE arch_processor OF processor IS
	COMPONENT F_D IS
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
	END COMPONENT F_D;
	COMPONENT D_E IS
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
	END COMPONENT D_E;
	COMPONENT EXECUTE IS 
	PORT(
		 CLK_EX: IN STD_LOGIC;
	 ALU_OPCODE_CU: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	 ALU_SRC2: IN STD_LOGIC;
	 CCR_OR_Enablee: IN STD_LOGIC; ------LESAAAAAAAAAAAAAAA
	 CCR_RST_Z: IN STD_LOGIC;
	 CCR_RST_N: IN STD_LOGIC;
	 CCR_RST_C: IN STD_LOGIC;
	 TRI_STATE_CCR: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
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
	);
	END COMPONENT EXECUTE;
	COMPONENT E_M IS
	PORT (
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
	END COMPONENT E_M;
	COMPONENT MEMORY IS
    PORT(
    CLK_MEM: IN STD_LOGIC;
		 RST_MEM: IN STD_LOGIC;
		 INC_CU:IN STD_LOGIC;
		 DEC_CU:IN STD_LOGIC;
		 Enablee_SP:IN STD_LOGIC;
		 SEL_ALU_IMM: IN STD_LOGIC;
		 SEL_STORE: IN STD_LOGIC;
		 SEL_SP_MUX: IN STD_LOGIC;
		 FLAG_SEL: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 AND_PU: IN STD_LOGIC;
		 MEM_READ: IN STD_LOGIC;
		 MEM_WRITE: IN STD_LOGIC;
       EM_o_pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       EM_o_pc_1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);--PC+1
       EM_o_InPort: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       EM_o_Ardst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
       EM_o_Vrsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       EM_o_immediate: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       EM_o_flags: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
       EM_o_alu: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 EXCEPTION_IN: IN STD_LOGIC_VECTOR(15 DOWNTO 0);

       MW_i_InPort: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
       MW_i_Ardst : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
       MW_i_Vrsrc1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);--value of Rsrc1
       MW_i_alu: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
       MW_i_MemOut: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 MUX_OUT_TO_EXCEPTION:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_FU: OUT STD_LOGIC;
		 STACK_FLAG: OUT STD_LOGIC
    );
	END COMPONENT;
	COMPONENT M_W IS
	  PORT (
		 --control signals
    -- inputs
    i_clk : IN STD_LOGIC;
    i_reset : IN STD_LOGIC;
--	 i_WB_MW : IN STD_LOGIC;
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
	END COMPONENT M_W;
	COMPONENT WB is
    Port (
        clk               : in std_logic;
        WB_SEL            : in std_logic_vector(1 downto 0); -- 2 bits
        Vsrc1             : in std_logic_vector(15 downto 0); -- 16 bits
        ALUOUT            : in std_logic_vector(15 downto 0); -- 16 bits
        MEMOUT            : in std_logic_vector(15 downto 0); -- 16 bits
        INport            : in std_logic_vector(15 downto 0); -- 16 bits
        OUTPUTPrevDATA    : in std_logic_vector(15 downto 0); -- 16 bits
        OUTPUTEnablteWB   : in std_logic; -- Enablee signal
        SETCCR_Flag_in    : in std_logic; -- Set CCR flag
        WB_Reg_Address_in : in std_logic_vector(2 downto 0); -- 3 bits
        RET_Flag_in       : in std_logic; --
        Reg_WB_Flag_in    : in std_logic;
        RET_Flag_out      : out std_logic; --
        popped_PC         : out std_logic_vector(15 downto 0); -- 16 bits
        SETCCR_Flag_out   : out std_logic; -- Set CCR flag
        WB_Reg_Address_out: out std_logic_vector(2 downto 0); -- 3 bits
        WB_Reg_Data       : out std_logic_vector(15 downto 0); -- 16 bits
        WB_OutPort_Data   : out std_logic_vector(15 downto 0);  -- 16 bits
        Flags_CCR_out     : out std_logic_vector(2 downto 0); -- 4 bits 
        Reg_WB_Flag_out   : out std_logic
    );
	end COMPONENT WB;
	COMPONENT ForwardUnit is
    Port (
        clk : in STD_LOGIC; -- Clock signal
        Rsrc1 : in STD_LOGIC_VECTOR(2 downto 0);
        Rsrc2 : in STD_LOGIC_VECTOR(2 downto 0);
        RdstALU : in STD_LOGIC_VECTOR(2 downto 0);
        RdstMEM : in STD_LOGIC_VECTOR(2 downto 0);
        WbALU : in STD_LOGIC;
        WbMEM : in STD_LOGIC;
        Rsrc1OverWriteFlag : out STD_LOGIC_VECTOR(1 downto 0);
        Rsrc2OverWriteFlag : out STD_LOGIC_VECTOR(1 downto 0)
    );
	end COMPONENT ForwardUnit;
----------------------------------------
COMPONENT ExceptionUnit is
  Port (
      clk : in STD_LOGIC;                     -- Clock signal
      StackSelector : in STD_LOGIC;           -- Stack selection flag
      CheckOnMan : in STD_LOGIC_VECTOR(15 downto 0); -- Address or Stack Pointer check
      Naughty_PC : in std_logic_vector (15 downto 0); 
      FlushFlag : out STD_LOGIC;              -- Flush pipeline flag
      PanicModeON : out STD_LOGIC;            -- Panic mode activation flag
      ExceptionAddress : out STD_LOGIC_VECTOR(15 downto 0); -- Exception address
      EPCVALUE : out STD_LOGIC_VECTOR(15 downto 0)
      
  );
end COMPONENT;

	
  
  
  ----------------------------------------------------MOHANAD(FETCH)-------------------------------------------
	COMPONENT fetch is
		port (
   --FROm GLOBAL MASTER 
                clk: IN std_logic;  
                INPUT_PORT: IN std_logic_vector(15 DOWNTO 0);
                
                --Decode Signals 
                --MUX 2 
                RET_RTI_SEL: IN std_logic;
                RET_RTI_IN: IN std_logic_vector(15 DOWNTO 0);
                -- MUX JMP
                PRED_SEL: IN std_logic; 
                --MUX JMP Dest
                UNCOND_SEL: IN std_logic_vector(1 DOWNTO 0);
                UNCOND_IN1: IN std_logic_vector(15 DOWNTO 0);
                UNCOND_IN2: IN std_logic_vector(15 DOWNTO 0);
                
                --ADDER Enablee 
                HLT_CU_ADDER: IN std_logic;
                HAZARD_DU_ADDER: IN std_logic;
                
                --Stall
                HAZARD_DU_stall: IN std_logic;
                NOP_CU: IN std_logic_vector(31 DOWNTO 0);
                
                --Exception Signals
                --MUX Exception
                EXCEPTION_SEL: IN std_logic;
                EXCEPTION_IN: IN std_logic_vector(15 DOWNTO 0);
                --External 
                RST_SEL: IN std_logic;
                -- F/D Buffer
                REG_INDEX: IN std_logic;

                --OUTPUTS 
                PC_1: OUT std_logic_vector(15 DOWNTO 0);
                PC: OUT std_logic_vector(15 DOWNTO 0);
                Instruction: OUT std_logic_vector(31 DOWNTO 0);
                InputPort_F_D_B: OUT std_logic_vector(15 DOWNTO 0);
					 
					 IMM: OUT std_logic_vector(15 DOWNTO 0);
					 OPCODE:OUT std_logic_vector(4 DOWNTO 0);
					 RDST:OUT std_logic_vector(2 DOWNTO 0);
					 o_Rsrc1:OUT std_logic_vector(2 DOWNTO 0);
					 o_Rsrc2:OUT std_logic_vector(2 DOWNTO 0)

		);

	end COMPONENT;
	
	--SIGNALS FOR FETCH COMPONENT
	SIGNAL PC_1_sig: std_logic_vector(15 DOWNTO 0);
   SIGNAL PC_sig: std_logic_vector(15 DOWNTO 0);
   SIGNAL Instruction_sig: std_logic_vector(31 DOWNTO 0);
   SIGNAL InputPort_F_D_B_sig:  std_logic_vector(15 DOWNTO 0);
					 
	SIGNAL IMM_sig:  std_logic_vector(15 DOWNTO 0);
	SIGNAL OPCODE_sig: std_logic_vector(4 DOWNTO 0);
	SIGNAL RDST_sig: std_logic_vector(2 DOWNTO 0);
	SIGNAL o_Rsrc1_sig: std_logic_vector(2 DOWNTO 0);
	SIGNAL o_Rsrc2_sig: std_logic_vector(2 DOWNTO 0);



	------------------------------------------------------------------------------ MOHANAD (register file)------------------------
COMPONENT Register_File is 
port( 
	clk 	: in std_logic; 
	rst	: in std_logic; 
	reg_write	: in std_logic; 
	write_address	: in std_logic_vector(2 downto 0);
	read1_address	: in std_logic_vector(2 downto 0);
	read2_address 	: in std_logic_vector(2 downto 0);
	
 	data_in	 	: in std_logic_vector(15 downto 0);
	data_out1 	: out std_logic_vector(15 downto 0);	
	data_out2 	: out std_logic_vector(15 downto 0) 
	); 
end COMPONENT; 


--Signals for register file
	SIGNAL data_out1_sig 	: std_logic_vector(15 downto 0);	
	SIGNAL data_out2_sig 	: std_logic_vector(15 downto 0);
----------------------------------------------------------------------------------------------------------	
	
	
	COMPONENT PredictionUnit is
    Port (
        clk : in STD_LOGIC;                  -- Clock signal
        CondJMPMAN : in STD_LOGIC;           -- Conditional jump flag
        UnCondJMPMANRsrc1 : in STD_LOGIC;         -- Unconditional jump flag Rsrc1 
        UnCondJMPMANImm : in STD_LOGIC;         -- Unconditional jump flag Imm
        UnCondJMPMANThree: in STD_LOGIC; -- Unconditional jump flag to 3 
        YouWereWrongBuddyFlag : in STD_LOGIC;-- Mis-prediction flag
        JMPTaken : out STD_LOGIC;            -- Jump taken flag
        FlushFlag : out STD_LOGIC;           -- Flush pipeline flag
        JMPAddressSelector : out std_logic_vector(1 downto 0)   -- Jump address selector
    );
	end COMPONENT PredictionUnit;
	COMPONENT Hazard_Detection IS
    PORT (
        i_Arsc1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_Arsc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_Ardst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_AMemRead : IN STD_LOGIC;   --signal memory fal DE
        o_Hazard : OUT STD_LOGIC --htrg3 lel fetchhhhh (SAD)
    );
	END COMPONENT Hazard_Detection;
	
    COMPONENT ControlUnit is
        Port (
            clk        : in  std_logic;  -- Clock signal
            reset      : in  std_logic;  -- Reset signal   
            -- INPUTS : 
            Instruction: IN std_logic_vector  (31 DOWNTO 0); 
            -- OUTPUTS: 
            NOP_CU: OUT std_logic_vector(31 DOWNTO 0); -- C 
            HLT_CU_ADDER: OUT std_logic;  -- C  
            -- Fetch 
            RegWBFlag : OUT std_logic; 
            --DE E
            ALU_OP1_SEL : OUT std_logic;
            ALU_OP2_SEL : OUT std_logic;
            ALU_OPCODE : OUT std_logic_vector(4 DOWNTO 0);
            SETC_Enablee : OUT std_logic; 
            Reset_FLAGS : OUT std_logic_vector(2 DOWNTO 0);
            InterruptAdder_Enablee : OUT std_logic;
            index                 : OUT std_logic;
            SETC_out :  out STD_LOGIC; 
            -- EM M 
            WB_ALU_Enablee: OUT std_logic;
            CondJMPFlag: OUT std_logic; 
            StackFlag: OUT std_Logic; 
            StackEN : OUT std_logic; 
            StackInc : OUT std_logic; 
            StackDec : OUT std_logic; 
            
            -- MUXS
            ALU_IMM_MUX_SEL_MEM : OUT std_logic; 
            DataMeM_ADDress_SEl  : OUT std_logic;
            DataMeM_WriteData_SEl : OUT std_logic;
            MemoryWriteEnablee : OUT std_logic;
            MemoryReadEnablee : OUT std_logic;
            FlagSelector : OUT std_logic_vector(1 DOWNTO 0);
            -- MW W 
            OUTPORTWRiteEnablee: OUT std_logic; 
            WBSel : OUT std_logic_vector(1 DOWNTO 0);
            SETCCR_FLAG : OUT std_logic;
            RET_SEL_Fetch : Out std_logic; 
            --PredectionUnit 
            CondJMPMAN : out STD_LOGIC;           -- Conditional jump flag
            UnCondJMPMANRsrc1 : out STD_LOGIC;    -- Unconditional jump flag Rsrc1 
            UnCondJMPMANImm : out STD_LOGIC;      -- Unconditional jump flag Imm
            UnCondJMPMANThree: out STD_LOGIC     -- Unconditional jump flag to 3 
            
    
        );
    end COMPONENT;

    
	-- Signals for F_D component
  SIGNAL o_pc_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_pc_1_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_InPort_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_instruction_SIGNAL : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL o_IMM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_OPCODE_SIGNAL : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL o_RDST_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Rsrc1_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Rsrc2_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);

  -- Signals for D_E component
  SIGNAL o_pc_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_pc_1_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_InPort_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_instruction_SIGNAL2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL o_IMM_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_OPCODE_SIGNAL2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL o_RDST_SIGNAL2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Rsrc1_SIGNAL2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Rsrc2_SIGNAL2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Vrsrc1_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_Vrsrc2_SIGNAL2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL ALU_OPCODE_CU_DE_O_SIGNAL : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL ALU_SRC2_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL CCR_OR_Enablee_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL CCR_RST_Z_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL CCR_RST_N_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL CCR_RST_C_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL INPUT_EX_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SETC_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL INC_CU_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL DEC_CU_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL Enablee_SP_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_ALU_IMM_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_STORE_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_SP_MUX_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL FLAG_SEL_DE_O_SIGNAL : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL AND_PU_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_READ_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_WRITE_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_FOR_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL IN_OR_CCR_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL RET_RTI_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL REG_WRITE_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL FETCH_ADDER_EN_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL OUT_MUX_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SET_CCR_EN_DE_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_WB_REG_DE_O_SIGNAL : STD_LOGIC_vector(1 downto 0);
  
  -- Signals for EXECUTE component
  SIGNAL EM_pc_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EM_pc_1_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EM_InPort_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EM_Ardst_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL EM_Vrsrc1_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EM_immediate_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EM_flags_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL EM_alu_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  -- Signals for E_M component
  SIGNAL o_pc_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_pc_1_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_InPort_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_Ardst_EM_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Vrsrc1_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_immediate_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_flags_EM_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_alu_EM_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL INC_CU_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL DEC_CU_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL Enablee_SP_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_ALU_IMM_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_STORE_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_SP_MUX_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL FLAG_SEL_EM_O_SIGNAL : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL AND_PU_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_READ_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_WRITE_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL MEM_FOR_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL IN_OR_CCR_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL RET_RTI_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL REG_WRITE_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL FETCH_ADDER_EN_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL OUT_MUX_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL SET_CCR_EN_EM_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_WB_REG_EM_O_SIGNAL : STD_LOGIC_vector(1 downto 0);
  
    -- Signals for MEMORY component
  SIGNAL MW_i_InPort_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL MW_i_Ardst_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL MW_i_Vrsrc1_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL MW_i_alu_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL MW_i_MemOut_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL MUX_OUT_TO_EXCEPTION_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL OUT_FU_SIGNAL : STD_LOGIC;
  SIGNAL STACK_FLAG_SIGNAL : STD_LOGIC;
  
  -- Signals for M_W component
  SIGNAL o_InPort_MW_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_Ardst_MW_SIGNAL : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL o_Vrsrc1_MW_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_alu_MW_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_MemOut_MW_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL o_WB_MW_SIGNAL : STD_LOGIC;
  SIGNAL IN_OR_CCR_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL RET_RTI_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL REG_WRITE_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL FETCH_ADDER_EN_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL OUT_MUX_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL SET_CCR_EN_MW_O_SIGNAL : STD_LOGIC;
  SIGNAL SEL_WB_REG_MW_O_SIGNAL : STD_LOGIC_vector(1 downto 0);
  
  -- Signals for WB_Stage outputs
	SIGNAL RET_Flag_out_SIGNAL          : std_logic;
	SIGNAL popped_PC_SIGNAL             : std_logic_vector(15 downto 0);
	SIGNAL SETCCR_Flag_out_SIGNAL       : std_logic;
	SIGNAL WB_Reg_Address_out_SIGNAL    : std_logic_vector(2 downto 0);
	SIGNAL WB_Reg_Data_SIGNAL           : std_logic_vector(15 downto 0);
	SIGNAL WB_OutPort_Data_SIGNAL       : std_logic_vector(15 downto 0);
	SIGNAL Flags_CCR_out_SIGNAL         : std_logic_vector(2 downto 0);
	SIGNAL Reg_WB_Flag_out_SIGNAL       : std_logic;
	signal OUTPUT_Saved_Signal : std_logic_vector(15 downto 0);


    -- SIGNALS FOR !!CONTROLUNTI!!    
    signal CU_NOP_INS_O : std_logic_vector(31 downto 0);
    signal CU_HLT_ADD_Dis : std_logic ;
    signal CU_WB_EN_REG : std_logic ;
    signal CU_ALU_SEL1 : std_logic ;
    signal CU_ALU_SEL2 : std_logic ;
    signal CU_ALU_OPCODE : std_logic_vector(4 DOWNTO 0);
    signal CU_SETC_Enablee : std_logic; 
    signal CU_Reset_FLAGS :  std_logic_vector(2 DOWNTO 0);
    signal CU_InterruptAdder_Enablee : std_logic;
    signal CU_index                 :  std_logic;
    signal CU_SETC_out :   STD_LOGIC; 
            -- EM M 
    signal CU_WB_ALU_Enablee: std_logic;
    signal CU_CondJMPFlag:   std_logic; 
    signal CU_StackFlag:   std_Logic; 
    signal CU_StackEN :   std_logic; 
    signal CU_StackInc :   std_logic; 
    signal CU_StackDec :   std_logic; 
            
            -- MUXS
    signal       CU_ALU_IMM_MUX_SEL_MEM :   std_logic; 
    signal       CU_DataMeM_ADDress_SEl  :   std_logic;
    signal       CU_DataMeM_WriteData_SEl :   std_logic;
    signal       CU_MemoryWriteEnablee :   std_logic;
    signal       CU_MemoryReadEnablee :   std_logic;
    signal       CU_FlagSelector :   std_logic_vector(1 DOWNTO 0);
            -- MW W 
    signal      CU_OUTPORTWRiteEnablee:  std_logic; 
    signal      CU_WBSel :  std_logic_vector(1 DOWNTO 0);
    signal      CU_SETCCR_FLAG :  std_logic;
    signal     CU_RET_SEL_Fetch :  std_logic; 
            --PredectionUnit 
    signal     CU_CondJMPMAN :  STD_LOGIC;           -- Conditional jump flag
    signal     CU_UnCondJMPMANRsrc1 :  STD_LOGIC;    -- Unconditional jump flag Rsrc1 
    signal     CU_UnCondJMPMANImm :  STD_LOGIC;      -- Unconditional jump flag Imm
    signal     CU_UnCondJMPMANThree:  STD_LOGIC ;   -- Unconditional jump flag to 3 
    signal DE_o_index : std_logic ;

  

	--forward unit signals----
	SIGNAL Rsrc1OverWriteFlag_SIGNAL : STD_LOGIC_VECTOR(1 downto 0);
  SIGNAL Rsrc2OverWriteFlag_SIGNAL : STD_LOGIC_VECTOR(1 downto 0);
	---prediction unit----
  signal PU_JMPTaken :  STD_LOGIC;            -- Jump taken flag
  signal PU_FlushFlag : STD_LOGIC;           -- Flush pipeline flag
  signal PU_JMPAddressSelector :  std_logic_vector(1 downto 0); 
	---hazard detection---
  signal HD_o_Hazard :  STD_LOGIC; --htrg3 lel fetchhhhh
  --- Exception Unit Signals 
  signal EU_FlushFlag :  STD_LOGIC;              -- Flush pipeline flag
  signal EU_PanicModeON : STD_LOGIC;            -- Panic mode activation flag
  signal EU_ExceptionAddress :  STD_LOGIC_VECTOR(15 downto 0); -- Exception address
  signal EU_EPCVALUE :  STD_LOGIC_VECTOR(15 downto 0);

----- -!@FETCH Signals 
  --OUTPUTS 
  signal FE_PC_1:  std_logic_vector(15 DOWNTO 0);
  signal FE_PC:   std_logic_vector(15 DOWNTO 0);
  signal FE_Instruction:   std_logic_vector(31 DOWNTO 0);
  signal FE_InputPort_F_D_B:   std_logic_vector(15 DOWNTO 0);
  signal FE_IMM:   std_logic_vector(15 DOWNTO 0);
  signal FE_OPCODE:  std_logic_vector(4 DOWNTO 0);
  signal FE_RDST:  std_logic_vector(2 DOWNTO 0);
  signal FE_o_Rsrc1:  std_logic_vector(2 DOWNTO 0);
  signal FE_o_Rsrc2:  std_logic_vector(2 DOWNTO 0);



BEGIN
-----------------------------MOHANAD------------------------------------------------
  
  FD_INSTANCE: F_D
  PORT MAP (
  i_clk => CLK,-- MOHANAD
    i_reset => RST,--MOHANAD
	 
    i_pc => FE_PC, -- MOHANAD
    i_pc_1 => FE_PC_1, -- MOHANAD
    i_InPort => FE_InputPort_F_D_B, -- MOHANAD
    i_instruction => FE_Instruction, -- MOHANAD
    i_IMM => FE_IMM, -- MOHANAD
    i_OPCODE => FE_OPCODE, -- MOHANAD
    i_RDST => FE_RDST, -- MOHANAD
    i_Rsrc1 => FE_o_Rsrc1, -- MOHANAD
    i_Rsrc2 => FE_o_Rsrc2, -- MOHANAD
	 
    o_pc => o_pc_SIGNAL,
    o_pc_1 => o_pc_1_SIGNAL,
    o_InPort => o_InPort_SIGNAL,
    o_instruction => o_instruction_SIGNAL,
    o_IMM => o_IMM_SIGNAL,
    o_OPCODE => o_OPCODE_SIGNAL,
    o_RDST => o_RDST_SIGNAL,
    o_Rsrc1 => o_Rsrc1_SIGNAL,
    o_Rsrc2 => o_Rsrc2_SIGNAL
    
  );
  
  
    --------------------------------MOHANAD-----------------------


      
    new_fetch : fetch
      PORT MAP (
     --FROm GLOBAL MASTER 
                  clk => CLK,  
                  INPUT_PORT => INPORT,
                  
                  --MUX 2  @@00
                  RET_RTI_SEL => RET_RTI_MW_O_SIGNAL,
                  RET_RTI_IN=> popped_PC_SIGNAL,
                  -- MUX JMP
                  PRED_SEL => PU_JMPTaken,  -- Predection  
                  --MUX JMP Dest
                  UNCOND_SEL =>PU_JMPAddressSelector, -- Predection Unit 
                  UNCOND_IN1 => o_IMM_SIGNAL, -- IMM 
                  UNCOND_IN2 =>o_Vrsrc1_EM_SIGNAL, -- RSRC1
                  
                  --ADDER Enablee 
                  HLT_CU_ADDER => CU_HLT_ADD_Dis,
                  HAZARD_DU_ADDER => HD_o_Hazard,-- HAZARDMAN
                  
                  --Stall
                  HAZARD_DU_stall => HD_o_Hazard, --HazardMAN
                  NOP_CU=> CU_NOP_INS_O,
                  --Exception Signals
                  --MUX Exception
                  EXCEPTION_SEL=> EU_PanicModeON, --Excep Unit 
                  EXCEPTION_IN => EU_ExceptionAddress, -- Excep Unit
                  --External 
                  RST_SEL => RST,
                  -- F/D Buffer
                  REG_INDEX => DE_o_index,
  
                  --OUTPUTS 
                  PC_1 => FE_PC_1,
                  PC => FE_PC,
                  Instruction => FE_Instruction,
                  InputPort_F_D_B => FE_InputPort_F_D_B,
                  IMM => FE_IMM,
                  OPCODE => FE_OPCODE,
                  RDST => FE_RDST,
                  o_Rsrc1 => FE_o_Rsrc1,
                  o_Rsrc2 => FE_o_Rsrc2
  
      );
  
    
  
  
    NEW_Register_File: Register_File
  PORT MAP (
   clk =>CLK,
	rst	=>RST,
	reg_write=>  Reg_WB_Flag_out_SIGNAL,
	write_address	=>WB_Reg_Address_out_SIGNAL,
	read1_address	=>o_Rsrc1_SIGNAL,
	read2_address 	=>o_Rsrc2_SIGNAL,
	
  data_in	 	=>WB_Reg_Data_SIGNAL,
	data_out1 	=>	data_out1_sig, 	
	data_out2 	=> data_out2_sig
  );
--------------------------------------------------------------------
    


  -- D_E component instantiation
  DE_INSTANCE: D_E
  PORT MAP (
    i_clk => CLK,
    i_reset => RST,

    i_pc => o_pc_SIGNAL,
    i_pc_1 => o_pc_1_SIGNAL,
    i_InPort => o_InPort_SIGNAL,
    i_Arsrc1 => o_Rsrc1_SIGNAL, -- Example inputs
    i_Arsrc2 => o_Rsrc2_SIGNAL,
    i_Ardst => o_RDST_SIGNAL,
	 
   i_Vrsrc1 => data_out1_sig, --mohanad	
    i_Vrsrc2 => data_out2_sig,--mohanad
	 
    i_immediate => o_IMM_SIGNAL,
	 
    i_index => CU_index,
	 
    ALU_OPCODE_CU_DE_I => CU_ALU_OPCODE,
    ALU_SRC2_DE_I => CU_ALU_SEL2,
    CCR_OR_Enablee_DE_I => CU_SETC_Enablee, --Q 
    CCR_RST_Z_DE_I => CU_Reset_FLAGS(0),
    CCR_RST_N_DE_I => CU_Reset_FLAGS(1),
    CCR_RST_C_DE_I => CU_Reset_FLAGS(2),
    INPUT_EX_DE_I => '0', -- Input Exception Unit 
    SETC_DE_I => CU_SETC_out,
    INC_CU_DE_I => CU_StackInc,
    DEC_CU_DE_I => CU_StackDec,
    Enablee_SP_DE_I => CU_StackEN,
    SEL_ALU_IMM_DE_I => CU_ALU_SEL2,
    SEL_STORE_DE_I => CU_DataMeM_WriteData_SEl,
    SEL_SP_MUX_DE_I => CU_DataMeM_ADDress_SEl,
    FLAG_SEL_DE_I => CU_FlagSelector,
    AND_PU_DE_I => CU_CondJMPFlag,
    MEM_READ_DE_I => CU_MemoryReadEnablee,
    MEM_WRITE_DE_I => CU_MemoryWriteEnablee,
    MEM_FOR_DE_I => '0', -- FORward Unit --Q CHeck up if no then Remove 
    IN_OR_CCR_DE_I => CU_SETCCR_FLAG, --Q 
    RET_RTI_DE_I => CU_RET_SEL_Fetch,
    REG_WRITE_DE_I => CU_WB_EN_REG,
    FETCH_ADDER_EN_DE_I => CU_InterruptAdder_Enablee,
    OUT_MUX_DE_I => CU_OUTPORTWRiteEnablee,
    SET_CCR_EN_DE_I => '0',-- Q Remove 
    SEL_WB_REG_DE_I =>CU_WBSel, 
    
    o_pc => o_pc_SIGNAL2,
    o_pc_1 => o_pc_1_SIGNAL2,
    o_InPort => o_InPort_SIGNAL2,
    o_Arsrc1 => o_Rsrc1_SIGNAL2,
    o_Arsrc2 => o_Rsrc2_SIGNAL2,
    o_Ardst => o_RDST_SIGNAL2,
    o_Vrsrc1 => o_Vrsrc1_SIGNAL2,     
    o_Vrsrc2 => o_Vrsrc2_SIGNAL2, 
    o_immediate => o_IMM_SIGNAL2,
    o_index => DE_o_index, 
    ALU_OPCODE_CU_DE_O => ALU_OPCODE_CU_DE_O_SIGNAL,
    ALU_SRC2_DE_O => ALU_SRC2_DE_O_SIGNAL,
    CCR_OR_Enablee_DE_O => CCR_OR_Enablee_DE_O_SIGNAL,
    CCR_RST_Z_DE_O => CCR_RST_Z_DE_O_SIGNAL,
    CCR_RST_N_DE_O => CCR_RST_N_DE_O_SIGNAL,
    CCR_RST_C_DE_O => CCR_RST_C_DE_O_SIGNAL,
    INPUT_EX_DE_O => INPUT_EX_DE_O_SIGNAL,
    SETC_DE_O => SETC_DE_O_SIGNAL,
    INC_CU_DE_O => INC_CU_DE_O_SIGNAL,
    DEC_CU_DE_O => DEC_CU_DE_O_SIGNAL,
    Enablee_SP_DE_O => Enablee_SP_DE_O_SIGNAL,
    SEL_ALU_IMM_DE_O => SEL_ALU_IMM_DE_O_SIGNAL,
    SEL_STORE_DE_O => SEL_STORE_DE_O_SIGNAL,
    SEL_SP_MUX_DE_O => SEL_SP_MUX_DE_O_SIGNAL,
    FLAG_SEL_DE_O => FLAG_SEL_DE_O_SIGNAL,
    AND_PU_DE_O => AND_PU_DE_O_SIGNAL,
    MEM_READ_DE_O => MEM_READ_DE_O_SIGNAL,
    MEM_WRITE_DE_O => MEM_WRITE_DE_O_SIGNAL,
    MEM_FOR_DE_O => MEM_FOR_DE_O_SIGNAL,
    IN_OR_CCR_DE_O => IN_OR_CCR_DE_O_SIGNAL,
    RET_RTI_DE_O => RET_RTI_DE_O_SIGNAL,
    REG_WRITE_DE_O => REG_WRITE_DE_O_SIGNAL,
    FETCH_ADDER_EN_DE_O => FETCH_ADDER_EN_DE_O_SIGNAL,
    OUT_MUX_DE_O => OUT_MUX_DE_O_SIGNAL,
    SET_CCR_EN_DE_O => SET_CCR_EN_DE_O_SIGNAL,
    SEL_WB_REG_DE_O => SEL_WB_REG_DE_O_SIGNAL
  );
  
  -- EXECUTE component instantiation
  EXECUTE_INSTANCE: EXECUTE
  PORT MAP (
    CLK_EX => CLK,
    ALU_OPCODE_CU => ALU_OPCODE_CU_DE_O_SIGNAL,
    ALU_SRC2 => ALU_SRC2_DE_O_SIGNAL,
    CCR_OR_Enablee => CCR_OR_Enablee_DE_O_SIGNAL,
    CCR_RST_Z => CCR_RST_Z_DE_O_SIGNAL,
    CCR_RST_N => CCR_RST_N_DE_O_SIGNAL,
    CCR_RST_C => CCR_RST_C_DE_O_SIGNAL,
	 
    TRI_STATE_CCR => o_MemOut_MW_SIGNAL(2 DOWNTO 0), -- Q -- WB 
	 
    INPUT_EX => INPUT_EX_DE_O_SIGNAL,
	 
    WB_SIGNAL => '0', -- Q 

    SETC => SETC_DE_O_SIGNAL,
    DE_pc => o_pc_SIGNAL,
    DE_pc_1 => o_pc_1_SIGNAL,
    DE_InPort => o_InPort_SIGNAL,
    DE_Arsrc1 => o_Rsrc1_SIGNAL,
    DE_Arsrc2 => o_Rsrc2_SIGNAL,
    DE_Ardst => o_RDST_SIGNAL,
    DE_Vrsrc1 => o_Vrsrc1_SIGNAL2,
    DE_Vrsrc2 => o_Vrsrc2_SIGNAL2,
    DE_immediate => o_IMM_SIGNAL2,
	 
    SEL_FU1 => Rsrc1OverWriteFlag_SIGNAL,
    SEL_FU2 => Rsrc2OverWriteFlag_SIGNAL,
	 
    EM_pc => EM_pc_SIGNAL,
    EM_pc_1 => EM_pc_1_SIGNAL,
    EM_InPort => EM_InPort_SIGNAL,
    EM_Ardst => EM_Ardst_SIGNAL,
    EM_Vrsrc1 => EM_Vrsrc1_SIGNAL,
    EM_immediate => EM_immediate_SIGNAL,
    EM_flags => EM_flags_SIGNAL,
    EM_alu => EM_alu_SIGNAL
  );
  
  -- E_M component instantiation
  EM_INSTANCE: E_M
  PORT MAP (
    i_clk => CLK,
    i_reset => RST,
    i_pc => EM_pc_SIGNAL,
    i_pc_1 => EM_pc_1_SIGNAL,
    i_InPort => EM_InPort_SIGNAL,
    i_Ardst => EM_Ardst_SIGNAL,
    i_Vrsrc1 => EM_Vrsrc1_SIGNAL,
    i_immediate => EM_immediate_SIGNAL,
    i_flags => EM_flags_SIGNAL,
    i_alu => EM_alu_SIGNAL,
	 
    INC_CU_EM_I => INC_CU_DE_O_SIGNAL,
    DEC_CU_EM_I => DEC_CU_DE_O_SIGNAL,
    Enablee_SP_EM_I => Enablee_SP_DE_O_SIGNAL,
    SEL_ALU_IMM_EM_I => SEL_ALU_IMM_DE_O_SIGNAL,
    SEL_STORE_EM_I => SEL_STORE_DE_O_SIGNAL,
    SEL_SP_MUX_EM_I => SEL_SP_MUX_DE_O_SIGNAL,
    FLAG_SEL_EM_I => FLAG_SEL_DE_O_SIGNAL,
    AND_PU_EM_I => AND_PU_DE_O_SIGNAL,
    MEM_READ_EM_I => MEM_READ_DE_O_SIGNAL,
    MEM_WRITE_EM_I => MEM_WRITE_DE_O_SIGNAL,
    MEM_FOR_EM_I => MEM_FOR_DE_O_SIGNAL,
    IN_OR_CCR_EM_I => IN_OR_CCR_DE_O_SIGNAL,
    RET_RTI_EM_I => RET_RTI_DE_O_SIGNAL,
	REG_WRITE_EM_I=>REG_WRITE_DE_O_SIGNAL,
	FETCH_ADDER_EN_EM_I=>FETCH_ADDER_EN_DE_O_SIGNAL,
	OUT_MUX_EM_I=>OUT_MUX_DE_O_SIGNAL,
	SET_CCR_EN_EM_I=>SET_CCR_EN_DE_O_SIGNAL,
	SEL_WB_REG_EM_I=>SEL_WB_REG_DE_O_SIGNAL,
	 
	o_pc => o_pc_EM_SIGNAL,
    o_pc_1 => o_pc_1_EM_SIGNAL,
    o_InPort => o_InPort_EM_SIGNAL,
    o_Ardst => o_Ardst_EM_SIGNAL,
    o_Vrsrc1 => o_Vrsrc1_EM_SIGNAL,
    o_immediate => o_immediate_EM_SIGNAL,
    o_flags => o_flags_EM_SIGNAL,
    o_alu => o_alu_EM_SIGNAL,
    
    
    INC_CU_EM_O => INC_CU_EM_O_SIGNAL,
    DEC_CU_EM_O => DEC_CU_EM_O_SIGNAL,
    Enablee_SP_EM_O => Enablee_SP_EM_O_SIGNAL,
    SEL_ALU_IMM_EM_O => SEL_ALU_IMM_EM_O_SIGNAL,
    SEL_STORE_EM_O => SEL_STORE_EM_O_SIGNAL,
    SEL_SP_MUX_EM_O => SEL_SP_MUX_EM_O_SIGNAL,
    FLAG_SEL_EM_O => FLAG_SEL_EM_O_SIGNAL,
    AND_PU_EM_O => AND_PU_EM_O_SIGNAL,
    MEM_READ_EM_O => MEM_READ_EM_O_SIGNAL,
    MEM_WRITE_EM_O => MEM_WRITE_EM_O_SIGNAL,
    MEM_FOR_EM_O => MEM_FOR_EM_O_SIGNAL,
    
    IN_OR_CCR_EM_O => IN_OR_CCR_EM_O_SIGNAL,
    RET_RTI_EM_O => RET_RTI_EM_O_SIGNAL,
    REG_WRITE_EM_O => REG_WRITE_EM_O_SIGNAL,
    FETCH_ADDER_EN_EM_O => FETCH_ADDER_EN_EM_O_SIGNAL,
    OUT_MUX_EM_O => OUT_MUX_EM_O_SIGNAL,
    SET_CCR_EN_EM_O => SET_CCR_EN_EM_O_SIGNAL,
    SEL_WB_REG_EM_O => SEL_WB_REG_EM_O_SIGNAL
);
-- MEMORY component instantiation
  MEMORY_INSTANCE: MEMORY
  PORT MAP (
    CLK_MEM => CLK,
    RST_MEM => RST,
    INC_CU => INC_CU_EM_O_SIGNAL,
    DEC_CU => DEC_CU_EM_O_SIGNAL,
    Enablee_SP => Enablee_SP_EM_O_SIGNAL,
    SEL_ALU_IMM => SEL_ALU_IMM_EM_O_SIGNAL,
    SEL_STORE => SEL_STORE_EM_O_SIGNAL,
    SEL_SP_MUX => SEL_SP_MUX_EM_O_SIGNAL,
    FLAG_SEL => FLAG_SEL_EM_O_SIGNAL,
    AND_PU => AND_PU_EM_O_SIGNAL,
    MEM_READ => MEM_READ_EM_O_SIGNAL,
    MEM_WRITE => MEM_WRITE_EM_O_SIGNAL,
    EM_o_pc => o_pc_EM_SIGNAL,
    EM_o_pc_1 => o_pc_1_EM_SIGNAL,
    EM_o_InPort => o_InPort_EM_SIGNAL,
    EM_o_Ardst => o_Ardst_EM_SIGNAL,
    EM_o_Vrsrc1 => o_Vrsrc1_EM_SIGNAL,
    EM_o_immediate => o_immediate_EM_SIGNAL,
    EM_o_flags => o_flags_EM_SIGNAL,
    EM_o_alu => o_alu_EM_SIGNAL,
    EXCEPTION_IN => (OTHERS => '0'),
    MW_i_InPort => MW_i_InPort_SIGNAL,
    MW_i_Ardst => MW_i_Ardst_SIGNAL,
    MW_i_Vrsrc1 => MW_i_Vrsrc1_SIGNAL,
    MW_i_alu => MW_i_alu_SIGNAL,
    MW_i_MemOut => MW_i_MemOut_SIGNAL,
    MUX_OUT_TO_EXCEPTION => MUX_OUT_TO_EXCEPTION_SIGNAL,
    OUT_FU => OUT_FU_SIGNAL,
    STACK_FLAG => STACK_FLAG_SIGNAL
  );
  
  -- M_W component instantiation
  MW_INSTANCE: M_W
  PORT MAP (
    i_clk => CLK,
    i_reset => RST,
--    i_WB_MW => '0',
    i_InPort => MW_i_InPort_SIGNAL,
    i_Ardst => MW_i_Ardst_SIGNAL,
    i_Vrsrc1 => MW_i_Vrsrc1_SIGNAL,
    i_alu => MW_i_alu_SIGNAL,
    i_MemOut => MW_i_MemOut_SIGNAL,
	 
    IN_OR_CCR_MW_I => IN_OR_CCR_EM_O_SIGNAL,
    RET_RTI_MW_I => RET_RTI_EM_O_SIGNAL,
    REG_WRITE_MW_I => REG_WRITE_EM_O_SIGNAL,
    FETCH_ADDER_EN_MW_I => FETCH_ADDER_EN_EM_O_SIGNAL,
    OUT_MUX_MW_I => OUT_MUX_EM_O_SIGNAL,
    SET_CCR_EN_MW_I => SET_CCR_EN_EM_O_SIGNAL,
    SEL_WB_REG_MW_I => SEL_WB_REG_EM_O_SIGNAL,
	 
    o_InPort => o_InPort_MW_SIGNAL,
    o_Ardst => o_Ardst_MW_SIGNAL,
    o_Vrsrc1 => o_Vrsrc1_MW_SIGNAL,
    o_alu => o_alu_MW_SIGNAL,
    o_MemOut => o_MemOut_MW_SIGNAL,
    o_WB_MW => o_WB_MW_SIGNAL,
	 IN_OR_CCR_MW_O=>IN_OR_CCR_MW_O_SIGNAL,
	 RET_RTI_MW_O=>RET_RTI_MW_O_SIGNAL,
	 REG_WRITE_MW_O=>REG_WRITE_MW_O_SIGNAL,
	 FETCH_ADDER_EN_MW_O=>FETCH_ADDER_EN_MW_O_SIGNAL,
	 OUT_MUX_MW_O=>OUT_MUX_MW_O_SIGNAL,
	 SET_CCR_EN_MW_O=>SET_CCR_EN_MW_O_SIGNAL,
	 SEL_WB_REG_MW_O=>SEL_WB_REG_MW_O_SIGNAL
  );

    
  OUTPUT_Saved_Signal <= (OUTPUT_Saved_Signal);
  ----------- Belal --------------- 
  WB_Stage_Inst : WB
  PORT MAP (
    clk => CLK,
    WB_SEL => SEL_WB_REG_MW_O_SIGNAL,
    Vsrc1             => o_Vrsrc1_MW_SIGNAL,
    ALUOUT            => o_alu_MW_SIGNAL,
    MEMOUT            => o_MemOut_MW_SIGNAL,
    INport            => o_InPort_MW_SIGNAL,
    OUTPUTPrevDATA    => OUTPUT_Saved_Signal,  
    OUTPUTEnablteWB   => OUT_MUX_MW_O_SIGNAL, -- From Control Unit coming from M/W 
    SETCCR_Flag_in    => IN_OR_CCR_MW_O_SIGNAL,
    WB_Reg_Address_in => o_Ardst_MW_SIGNAL, -- RDST from M/W 
    RET_Flag_in       => RET_RTI_MW_O_SIGNAL,
    Reg_WB_Flag_in    => REG_WRITE_MW_O_SIGNAL,
    RET_Flag_out      => RET_RTI_MW_O_SIGNAL,
    popped_PC         => popped_PC_SIGNAL,
    SETCCR_Flag_out   => SETCCR_Flag_out_SIGNAL,
    WB_Reg_Address_out => WB_Reg_Address_out_SIGNAL,
    WB_Reg_Data       => WB_Reg_Data_SIGNAL,
    WB_OutPort_Data   => WB_OutPort_Data_SIGNAL,
    Flags_CCR_out     => Flags_CCR_out_SIGNAL,
    Reg_WB_Flag_out   => Reg_WB_Flag_out_SIGNAL
	);
    OUTPORT <=  OUTPUT_Saved_Signal;
---forward unit----
v8:ForwardUnit PORT MAP(
  clk =>CLK,
  Rsrc1 =>o_Rsrc1_SIGNAL2,
  Rsrc2  => o_Rsrc2_SIGNAL2,
  RdstALU =>  o_Ardst_EM_SIGNAL,
  RdstMEM => o_Ardst_EM_SIGNAL,
  WbALU =>  REG_WRITE_EM_O_SIGNAL,
  WbMEM => REG_WRITE_EM_O_SIGNAL,    
  Rsrc1OverWriteFlag => Rsrc1OverWriteFlag_SIGNAL, 
  Rsrc2OverWriteFlag => Rsrc2OverWriteFlag_SIGNAL
);


---prediction unit---
v9:PredictionUnit PORT MAP(
  clk =>CLK,
  CondJMPMAN => CU_CondJMPMAN,               -- Conditional jump flag
  UnCondJMPMANRsrc1 => CU_UnCondJMPMANRsrc1,            -- Unconditional jump flag Rsrc1 
  UnCondJMPMANImm => CU_UnCondJMPMANImm,             -- Unconditional jump flag Imm
  UnCondJMPMANThree => CU_UnCondJMPMANThree,
  YouWereWrongBuddyFlag => AND_PU_EM_O_SIGNAL,
  JMPTaken => PU_JMPTaken,
  FlushFlag => PU_FlushFlag,
  JMPAddressSelector => PU_JMPAddressSelector
);
----hazard detection---
v10:Hazard_Detection PORT MAP(
  i_Arsc1 => o_Rsrc1_SIGNAL,
  i_Arsc2 => o_Rsrc2_SIGNAL,   
  i_Ardst => o_RDST_SIGNAL2,
  i_AMemRead =>  '0', -- UPdated CU and shoudl pass till D/E Buffer 
  o_Hazard => HD_o_Hazard
);
------- Exception Unit 
v11: ExceptionUnit 
  PORT MAP (
      clk => CLK,
      StackSelector => Enablee_SP_EM_O_SIGNAL,           -- Stack selection flag
      CheckOnMan => MUX_OUT_TO_EXCEPTION_SIGNAL, -- Address or Stack Po ter check
      Naughty_PC=> (OTHERS=>'0'),
      FlushFlag => EU_FlushFlag,
      PanicModeON => EU_PanicModeON,
      ExceptionAddress => EU_ExceptionAddress,
      EPCVALUE=> EU_EPCVALUE
  );

------------- Belal ------------------------------
--- Control Unit 

ControlUnit_instance: ControlUnit 
    PORT MAP (
        clk        => clk,
        reset => RST,
        -- INPUTS : 
        Instruction => o_instruction_SIGNAL,
        -- OUTPUTS: 
        NOP_CU => CU_NOP_INS_O,
        HLT_CU_ADDER => CU_HLT_ADD_Dis ,
        -- Fetch 
        RegWBFlag => CU_WB_EN_REG,  
        --DE E
        ALU_OP1_SEL => CU_ALU_SEL1, 
        ALU_OP2_SEL => CU_ALU_SEL2,
        ALU_OPCODE => CU_ALU_OPCODE, 
        SETC_Enablee => CU_SETC_Enablee,  
        Reset_FLAGS => CU_Reset_FLAGS, 
        InterruptAdder_Enablee => CU_InterruptAdder_Enablee,
        index    => CU_index,
        SETC_out => CU_SETC_out,
        -- EM M 
        WB_ALU_Enablee => CU_WB_ALU_Enablee,
        CondJMPFlag => CU_CondJMPFlag,
        StackFlag => CU_StackFlag,
        StackEN => CU_StackEN, 
        StackInc => CU_StackInc,
        StackDec => Cu_StackDec, 
        
        -- MUXS
        ALU_IMM_MUX_SEL_MEM => CU_ALU_IMM_MUX_SEL_MEM,
        DataMeM_ADDress_SEl => CU_DataMeM_ADDress_SEl,
        DataMeM_WriteData_SEl => CU_DataMeM_WriteData_SEl,
        MemoryWriteEnablee => CU_MemoryWriteEnablee,
        MemoryReadEnablee => CU_MemoryReadEnablee,
        FlagSelector => CU_FlagSelector,
        -- MW W 
        OUTPORTWRiteEnablee => CU_OUTPORTWRiteEnablee, 
        WBSel => CU_WBSel,
        SETCCR_FLAG => CU_SETCCR_FLAG,
        RET_SEL_Fetch => CU_RET_SEL_Fetch, 
        --PredectionUnit 
        CondJMPMAN =>CU_CondJMPMAN,           -- Conditional jump flag
        UnCondJMPMANRsrc1 => CU_UnCondJMPMANRsrc1,    -- Unconditional jump flag Rsrc1 
        UnCondJMPMANImm => CU_UnCondJMPMANImm,     -- Unconditional jump flag Imm
        UnCondJMPMANThree => CU_UnCondJMPMANThree    -- Unconditional jump flag to 3 
        

    );


END ARCHITECTURE;