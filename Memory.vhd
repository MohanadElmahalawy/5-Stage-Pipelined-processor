library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY MEMORY IS
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
END ENTITY;

ARCHITECTURE arch_MEMORY OF MEMORY IS

    SIGNAL OUT_MUX_IMM_ALUOUT_SIGNAL: std_logic_vector(15 DOWNTO 0);
                             
    SIGNAL OUT_MUX_SP_MX1_SIGNAL: std_logic_vector(15 DOWNTO 0);
                        
    SIGNAL PC_FLAGS: std_logic_vector(15 DOWNTO 0);
    SIGNAL OUT_MEM_WRITE: std_logic_vector(15 DOWNTO 0);

    SIGNAL SEL_FLAGS_MUX_SIGNAL: std_logic_vector(1 DOWNTO 0);                      
    SIGNAL OUT_FLAGS_MUX_SIGNAL: std_logic;  
	 
	 SIGNAL SP_INC_DEC:std_logic_vector(15 downto 0);
	 SIGNAL INC_DEC_SP:std_logic_vector(15 downto 0);

    COMPONENT Data_Memory IS
        PORT (
            clk        : IN STD_LOGIC;                          
            i_address  : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); 
            i_data     : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');    
            mem_read   : IN STD_LOGIC;                    
            mem_write  : IN STD_LOGIC;                   
            o_data     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')       
        );
    END COMPONENT;
	 
	COMPONENT SP IS
	PORT(
	  clk : IN std_logic;
	  reset : IN std_logic;
	  input_signal : IN std_logic_vector(15 DOWNTO 0);
	  F : OUT std_logic_vector(15 DOWNTO 0)
	);
	END COMPONENT SP;

	COMPONENT IncrementDecrementUnit is
	port (
		clk          : in  std_logic;  
		inc_signal   : in  std_logic;  
		dec_signal   : in  std_logic;  
		Enablee       : in  std_logic;  
		input_value  : in  std_logic_vector(15 downto 0); 
		output_value : out std_logic_vector(15 downto 0)  
	);
	end COMPONENT IncrementDecrementUnit;
	
    TYPE t_memory IS ARRAY (0 TO 4095) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL r_mem : t_memory;
    SIGNAL mem_out_signal: STD_LOGIC_VECTOR(15 DOWNTO 0); -- Temporary signal for Data_Memory output

BEGIN

    -- Combine PC+1 and flags
    PC_FLAGS <= EM_o_pc_1 OR ("000000000000" & EM_o_flags);

    -- Replace MUX_IMM_ALUOUT
    PROCESS(SEL_ALU_IMM, EM_o_alu, EM_o_immediate)
    BEGIN
        IF SEL_ALU_IMM = '0' THEN
            OUT_MUX_IMM_ALUOUT_SIGNAL <= EM_o_alu;
        ELSE
            OUT_MUX_IMM_ALUOUT_SIGNAL <= EM_o_immediate;
        END IF;
    END PROCESS;

    -- Replace MUX_SP_MX1
    PROCESS(SEL_SP_MUX, OUT_MUX_IMM_ALUOUT_SIGNAL, SP_INC_DEC)
    BEGIN
        IF SEL_SP_MUX = '0' THEN
            OUT_MUX_SP_MX1_SIGNAL <= OUT_MUX_IMM_ALUOUT_SIGNAL;
        ELSE
            OUT_MUX_SP_MX1_SIGNAL <= SP_INC_DEC;
        END IF;
    END PROCESS;

    -- Replace MUX_STORE
    PROCESS(SEL_STORE, EM_o_Vrsrc1, PC_FLAGS)
    BEGIN
        IF SEL_STORE = '1' THEN
            OUT_MEM_WRITE <= EM_o_Vrsrc1;
        ELSE
            OUT_MEM_WRITE <= PC_FLAGS;
        END IF;
    END PROCESS;

    -- Replace MUX_FLAGS
    PROCESS(FLAG_SEL, EM_o_flags)
    BEGIN
        CASE FLAG_SEL IS
            WHEN "00" => OUT_FLAGS_MUX_SIGNAL <= EM_o_flags(2); -- z
            WHEN "01" => OUT_FLAGS_MUX_SIGNAL <= EM_o_flags(1); -- n
            WHEN "10" => OUT_FLAGS_MUX_SIGNAL <= EM_o_flags(0); -- c
            WHEN OTHERS => OUT_FLAGS_MUX_SIGNAL <= '0';
        END CASE;
    END PROCESS;

    -- Data Memory Component
    u3: Data_Memory PORT MAP(
        clk => CLK_MEM,
        i_address => EXCEPTION_IN,
        i_data => OUT_MEM_WRITE,
        mem_read => MEM_READ,
        mem_write => MEM_WRITE,
        o_data => mem_out_signal -- Use temporary signal for Data_Memory output
    );

	 
	 u4:SP PORT MAP(CLK_MEM,RST_MEM,INC_DEC_SP,SP_INC_DEC);
	 u5:IncrementDecrementUnit PORT MAP(CLK_MEM,INC_CU,DEC_CU,Enablee_SP,SP_INC_DEC,INC_DEC_SP);
    -- Output Signals Assignment
    PROCESS(CLK_MEM)
    BEGIN
        IF falling_edge(CLK_MEM) THEN
            MW_i_alu <= OUT_MUX_IMM_ALUOUT_SIGNAL;
            MW_i_MemOut <= mem_out_signal; -- Assign from temporary signal
            MW_i_Vrsrc1 <= EM_o_Vrsrc1;
            MW_i_Ardst <= EM_o_Ardst;
            MW_i_InPort <= EM_o_InPort;
				MUX_OUT_TO_EXCEPTION <= OUT_MUX_SP_MX1_SIGNAL;
				OUT_FU <= OUT_FLAGS_MUX_SIGNAL AND AND_PU;
        END IF;
    END PROCESS;

END ARCHITECTURE;
