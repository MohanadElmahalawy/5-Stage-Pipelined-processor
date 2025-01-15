library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is
    Signal  Opcode : std_logic_vector(4 downto 0);
    -- Internal signals with default value of '0'
    signal NOP_CU_Sig                : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal HLT_CU_ADDER_Sig          : std_logic := '0';
    signal RET_SEL_Fetch_Sig             : std_logic:= '0';
    signal SETC_Enablee_Sig           : std_logic := '0';
    signal SETC_out_Sig           : std_logic := '0';
    signal ALU_OP1_SEL_Sig : std_logic := '0';
    signal ALU_OP2_SEL_Sig : std_logic := '0';
    signal Reset_FLAGS_Sig           : std_logic_vector(2 downto 0) := (others => '0');
    signal ALU_OPCODE_Sig            : std_logic_vector(4 downto 0) := (others => '0');
    signal InterruptAdder_Enablee_Sig : std_logic := '0';
    signal index_Sig : std_logic := '0';
    signal WB_ALU_Enablee_Sig         : std_logic := '0';
    signal CondJMPFlag_Sig           : std_logic := '0';    
    signal StackFlag_Sig             : std_logic := '0';
    signal StackEN_Sig               : std_logic := '0';
    signal StackInc_Sig           : std_logic := '0';
    signal StackDec_Sig           : std_logic := '0';
    signal MemoryWriteEnablee_Sig     : std_logic := '0';
    signal MemoryReadEnablee_Sig      : std_logic := '0';
    signal ALU_IMM_MUX_SEL_MEM_Sig              : std_logic := '0';
    signal DataMeM_ADDress_SEl_Sig               : std_logic := '0';
    signal DataMeM_WriteData_SEl_Sig               : std_logic := '0';
    signal FlagSelector_Sig          : std_logic_vector(1 downto 0) := (others => '0');
    signal OUTPORTWRiteEnablee_Sig    : std_logic := '0';
    signal RegWBFlag_Sig             :  std_logic := '0'; 
    signal WBSel_Sig : std_logic_vector (1 downto 0) := (others => '0');
    signal SETCCR_FLAG_Sig : std_logic := '0';
    signal CondJMPMAN_Sig : std_logic := '0';
    signal UnCondJMPMANRsrc1_Sig : std_logic := '0';
    signal UnCondJMPMANImm_Sig : std_logic := '0';
    signal UnCondJMPMANThree_Sig : std_logic := '0';
    begin
    process(clk, reset)
    begin 
       
        -- ALU OPCODES
        -- 1. `00011` - NOT  
        -- 2. `01010` - AND  
        -- 3. `00100` - INC  
        -- 4. `01000` - ADD  
        -- 5. `01001` - SUB  
        -- 6. `01011` - IADD  
        -- 7. `01111` - LDD  
        -- 8. `10000` - STD  
        -- 9. `00010` - SETC  
        -- 10. Others - OTHERS
        if rising_edge(clk) then
			 NOP_CU_Sig                <= (others => '0');
            HLT_CU_ADDER_Sig          <= '0';
            RET_SEL_Fetch_Sig         <= '0';
            SETC_Enablee_Sig           <= '0';
            SETC_out_Sig              <= '0';
            ALU_OP1_SEL_Sig           <= '0';
            ALU_OP2_SEL_Sig           <= '0';
            Reset_FLAGS_Sig           <= (others => '0');
            ALU_OPCODE_Sig            <= (others => '0');
            InterruptAdder_Enablee_Sig <= '0';
            index_Sig                 <= '0';
            WB_ALU_Enablee_Sig         <= '0';
            CondJMPFlag_Sig           <= '0';    
            StackFlag_Sig             <= '0';
            StackEN_Sig               <= '0';
            StackInc_Sig              <= '0';
            StackDec_Sig              <= '0';
            MemoryWriteEnablee_Sig     <= '0';
            MemoryReadEnablee_Sig      <= '0';
            ALU_IMM_MUX_SEL_MEM_Sig   <= '0';
            DataMeM_ADDress_SEl_Sig   <= '0';
            DataMeM_WriteData_SEl_Sig <= '0';
            FlagSelector_Sig          <= (others => '0');
            OUTPORTWRiteEnablee_Sig    <= '0';
            RegWBFlag_Sig             <= '0'; 
            WBSel_Sig                 <= (others => '0');
            SETCCR_FLAG_Sig           <= '0';
            CondJMPMAN_Sig            <= '0';
            UnCondJMPMANRsrc1_Sig     <= '0';
            UnCondJMPMANImm_Sig       <= '0';
            UnCondJMPMANThree_Sig     <= '0';

        FlagSelector_Sig          (1 downto 0) <= (others => '0');
        OUTPORTWRiteEnablee_Sig    <= '0';
			
			------------------------------
            Opcode <= Instruction(15 downto 11);
        case Opcode is
            when "00000" =>
            ALU_OPCODE_Sig <= "01000";
            RegWBFlag_Sig <= '0';
                --NOP 
            when "00010" =>
            SETC_Enablee_Sig <= '1';
            SETC_out_Sig <= '1';
            --SETC
            when "00011" =>
            ALU_OPCODE_Sig <= "00011";
            ALU_OP1_SEL_Sig <='0';
            WBSel_Sig <="00";
            RegWBFlag_Sig <= '1';    
                --NOT
            when "00100" =>
                ALU_OPCODE_Sig <= "01011";
                ALU_OP1_SEL_Sig <='0';
                ALU_OP2_SEL_Sig <='1';
                RegWBFlag_Sig <= '1';    
                WBSel_Sig <="01";
                -- INC
            when "00111" =>
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "00";
                --MOV
            when "01000" =>
                ALU_OPCODE_Sig <= "01000";
                ALU_OP1_SEL_Sig <='0';
                ALU_OP2_SEL_Sig <= '0';
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "01";
                --ADD
            when "01001" =>
                ALU_OPCODE_Sig <= "01001";
                ALU_OP1_SEL_Sig <='0';
                ALU_OP2_SEL_Sig <= '0';
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "01";
                --SUB
            when "01010" =>
                ALU_OPCODE_Sig <= "01010";
                ALU_OP1_SEL_Sig <='0';
                ALU_OP2_SEL_Sig <= '0';
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "00";
                --AND
            when "00101" =>
                WBSel_Sig <= "00";
                OUTPORTWRiteEnablee_Sig <='1';
                -- OUT 
            when "00110" =>
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "11";
                -- IN Rdst
            when "01011" =>
                ALU_OPCODE_Sig <= "01011";
                ALU_OP2_SEL_Sig <= '0';
                ALU_OP2_SEL_Sig <= '1';
                RegWBFlag_Sig <= '1'; 
                WBSel_Sig <= "00";
                -- IADD
            when "01100" =>
                StackFlag_Sig <= '1';
                StackInc_Sig <= '1';
                DataMeM_ADDress_SEl_Sig <='1';
                DataMeM_WriteData_SEl_Sig <='1';
                ALU_IMM_MUX_SEL_MEM_Sig <='1';
                MemoryWriteEnablee_Sig <= '1';
                -- PUSH
            when "01101" =>
            StackFlag_Sig <= '1';
            StackDec_Sig <= '1';
            DataMeM_ADDress_SEl_Sig <='1';
            DataMeM_WriteData_SEl_Sig <='1';
            ALU_IMM_MUX_SEL_MEM_Sig <='1';
            MemoryReadEnablee_Sig <= '1';
                --POP
            when "01110" =>
            MemoryReadEnablee_Sig <='1'; 
            DataMeM_ADDress_SEl_Sig <='0';
            ALU_IMM_MUX_SEL_MEM_Sig <='1';
                --LDM 
            when "01111" =>
                ALU_OP1_SEL_Sig <='0';
                ALU_OP2_SEL_Sig <='1';
                ALU_OPCODE_Sig <="01011";
                ALU_IMM_MUX_SEL_MEM_Sig <='0';
                DataMeM_WriteData_SEl_Sig <='1';
                MemoryReadEnablee_Sig <='1';
                RegWBFlag_Sig <='1';
                -- LDD
            when "10000" =>
                ALU_OP1_SEL_Sig <='1';
                ALU_OP2_SEL_Sig <='1';
                ALU_OPCODE_Sig <="01011";
                ALU_IMM_MUX_SEL_MEM_Sig <='0';
                DataMeM_ADDress_SEl_Sig <='1';
                MemoryWriteEnablee_Sig<='1';
                RegWBFlag_Sig <='1';
                -- STD
            when "10001" =>
                CondJMPFlag_Sig <='1';
                CondJMPMAN_Sig <='1';
                CondJMPFlag_Sig <='1';
                FlagSelector_Sig<="00";
                --JZ
            when "10010" =>
                CondJMPFlag_Sig <='1';
                CondJMPMAN_Sig <='1';
                CondJMPFlag_Sig <='1';
                FlagSelector_Sig<="01";
                --JN
            when "10011" =>
                CondJMPFlag_Sig <='1';
                CondJMPMAN_Sig <='1';
                CondJMPFlag_Sig <='1';
                FlagSelector_Sig<="10";
                -- JC
            when "11111" =>
                UnCondJMPMANImm_Sig <='1';
                --JMP Addr
            when "10101" =>
                UnCondJMPMANRsrc1_Sig <='0';
                StackFlag_Sig <= '1';
                StackInc_Sig <= '1';
                DataMeM_ADDress_SEl_Sig <='1';
                DataMeM_WriteData_SEl_Sig <='1';
                ALU_IMM_MUX_SEL_MEM_Sig <='1';
                MemoryWriteEnablee_Sig <= '1';
                -- Call
            when "10110" =>
                StackFlag_Sig <= '1';
                StackDec_Sig <= '1';
                DataMeM_ADDress_SEl_Sig <='1';
                DataMeM_WriteData_SEl_Sig <='1';
                ALU_IMM_MUX_SEL_MEM_Sig <='1';
                MemoryReadEnablee_Sig <= '1';
                RET_SEL_Fetch_Sig <='1';
            -- RET
            when "10111" =>
                UnCondJMPMANThree_Sig <='1';
                index_Sig <= Instruction(1);
                InterruptAdder_Enablee_Sig <='1';
                -- INT Index
            when "11000" =>
                StackFlag_Sig <= '1';
                StackDec_Sig <= '1';
                DataMeM_ADDress_SEl_Sig <='1';
                DataMeM_WriteData_SEl_Sig <='1';
                ALU_IMM_MUX_SEL_MEM_Sig <='1';
                MemoryReadEnablee_Sig <= '1';
                RET_SEL_Fetch_Sig <='1';
                SETCCR_FLAG_Sig <='1' ;
                -- RTI
            when "00001" =>
                HLT_CU_ADDER<= '1';
                ALU_OPCODE_Sig <= "01000";
                RegWBFlag_Sig <= '0';
                --HLT
            when others =>

            

        end case;
            NOP_CU                  <= NOP_CU_Sig;
            HLT_CU_ADDER            <= HLT_CU_ADDER_Sig;
            RET_SEL_Fetch           <= RET_SEL_Fetch_Sig;
            SETC_Enablee             <= SETC_Enablee_Sig;
            SETC_out                <= SETC_out_Sig;
            ALU_OP1_SEL             <= ALU_OP1_SEL_Sig;
            ALU_OP2_SEL             <= ALU_OP2_SEL_Sig;
            Reset_FLAGS             <= Reset_FLAGS_Sig;
            ALU_OPCODE              <= ALU_OPCODE_Sig;
            InterruptAdder_Enablee   <= InterruptAdder_Enablee_Sig;
            index                   <= index_Sig;
            WB_ALU_Enablee           <= WB_ALU_Enablee_Sig;
            CondJMPFlag             <= CondJMPFlag_Sig;    
            StackFlag               <= StackFlag_Sig;
            StackEN                 <= StackEN_Sig;
            StackInc                <= StackInc_Sig;
            StackDec                <= StackDec_Sig;
            MemoryWriteEnablee       <= MemoryWriteEnablee_Sig;
            MemoryReadEnablee        <= MemoryReadEnablee_Sig;
            ALU_IMM_MUX_SEL_MEM     <= ALU_IMM_MUX_SEL_MEM_Sig;
            DataMeM_ADDress_SEl     <= DataMeM_ADDress_SEl_Sig;
            DataMeM_WriteData_SEl   <= DataMeM_WriteData_SEl_Sig;
            FlagSelector            <= FlagSelector_Sig;
            OUTPORTWRiteEnablee      <= OUTPORTWRiteEnablee_Sig;
            RegWBFlag               <= RegWBFlag_Sig; 
            WBSel                   <= WBSel_Sig;
            SETCCR_FLAG             <= SETCCR_FLAG_Sig;
            CondJMPMAN              <= CondJMPMAN_Sig;
            UnCondJMPMANRsrc1       <= UnCondJMPMANRsrc1_Sig;
            UnCondJMPMANImm         <= UnCondJMPMANImm_Sig;
            UnCondJMPMANThree       <= UnCondJMPMANThree_Sig;
        end if;
    end process;
end Behavioral;
