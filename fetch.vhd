	library ieee;
	use ieee.std_logic_1164.all;
	USE ieee.numeric_std.ALL;

	entity fetch is
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

	end entity fetch;



	architecture arch of fetch is

		
	---------------------------------PC--------------------------------------------

	COMPONENT PC_comp IS
		 PORT(
			  clk : IN std_logic;
			  reset : IN std_logic;
			  input_signal : IN std_logic_vector(15 DOWNTO 0);
			  F : OUT std_logic_vector(15 DOWNTO 0)
		 );
	END COMPONENT;
			------------------------------INSTRUCTION MEMORY------------------------------------
		COMPONENT Instruction_Memory IS
		PORT (
		 -- inputs
		 i_address : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
		 -- outputs
		 o_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
		 o_index : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0')
		);
		END COMPONENT;

	----------------------------------JMP_ADDRESS_GENERATOR--------------
		COMPONENT JMP_ADD_GENERATOR IS 
		PORT(
		A:IN std_logic_vector(31 DOWNTO 0);
		F:OUT std_logic_vector(31 DOWNTO 0)
		);
		END COMPONENT;	
	---------------------------------------------------------------------------------------
	
	
	
	

		-------------------------------------SIGNALS--------------------
		signal F_MUX_HLT: std_logic_vector(15 DownTO 0);
		signal F_MUX_RET_RTI: std_logic_vector(15 DownTO 0);
		signal F_MUX_PRED: std_logic_vector(15 DownTO 0);
		signal F_MUX_EXCEPTION: std_logic_vector(15 DownTO 0);
		
		signal F_MUX_UNCOND: std_logic_vector(15 DownTO 0);
		signal I_MUX_UNCOND_3: std_logic_vector(15 DownTO 0) := "0000000000000011";
		
		signal F_MUX_RST: std_logic_vector(15 DownTO 0);
		signal I_MUX_RST: std_logic_vector(15 DownTO 0);

		signal F_ADDER: std_logic_vector(15 DownTO 0);
		signal IN_PLUS_1: std_logic_vector(15 DownTO 0);
		signal IN_PLUS_2: std_logic_vector(15 DownTO 0);
		
		signal F_MUX_GENERATOR: std_logic_vector(31 DownTO 0);
		
		
		signal S_MUX_GENERATOR: std_logic;
		
		signal F_Instruction_Memory: std_logic_vector(31 DownTO 0);-- hatba 32 msh 16
		signal F_Index_Memory: std_logic_vector(15 DownTO 0);
		
		signal ge0:std_logic;
		signal le3:std_logic;
		signal GeneratorSel: std_logic;
		
		signal I_JMP_ADDRESS_GENERATOR: std_logic_vector (31 DOWNTO 0);
		signal O_JMP_ADDRESS_GENERATOR: std_logic_vector (31 DOWNTO 0);
		
		
		
		signal S_MUX_NOP: std_logic;
		signal F_MUX_NOP: std_logic_vector (31 DOWNTO 0);
		
		signal S_MUX_ADDER: std_logic;
		signal F_MUX_ADDER: std_logic_vector (15 DOWNTO 0);
		
		signal cin: std_logic;--cin=0
		signal cout: std_logic;--cout=0
		signal REG_INDEX_ADD: std_logic_vector(31 DOWNTO 0);
		
		signal O_PC:std_logic_vector(15 DOWNTO 0);
		
		signal ADDER_DISABLE:std_logic;
		signal F_ADDER_reg:std_logic_vector(15 DOWNTO 0);
		
		signal OUT_AND_IN_OR:std_logic;
		----------------------------------------------
		--OUTPUT
		SIGNAL O_IMM: std_logic_vector(15 DOWNTO 0);
		SIGNAL O_OPCODE: std_logic_vector(4 DOWNTO 0);
		SIGNAL O_RDST:std_logic_vector(2 DOWNTO 0);
		SIGNAL O_InputPort: std_logic_vector(15 DOWNTO 0);
		
		
	begin
	
	
		-- your component and signal declarations here


		--2
		process(RET_RTI_SEL, F_ADDER, RET_RTI_IN)
			begin
				if RET_RTI_SEL = '1' then
					F_MUX_RET_RTI <= RET_RTI_IN;
				else
					F_MUX_RET_RTI <= F_ADDER;
				end if;
		end process;
	 
		--3
		process(UNCOND_SEL, UNCOND_IN1, UNCOND_IN2)
			begin
				if UNCOND_SEL = "00" then
					F_MUX_UNCOND <= UNCOND_IN1;
				elsif UNCOND_SEL = "01" then
					F_MUX_UNCOND <= UNCOND_IN1;
				else
					F_MUX_UNCOND <= I_MUX_UNCOND_3;
				end if;
		end process;
		
		--4
		process(PRED_SEL, F_MUX_UNCOND,F_MUX_RET_RTI)
			begin
				if PRED_SEL = '1' then
					F_MUX_PRED <= F_MUX_UNCOND;
				else
					F_MUX_PRED <= F_MUX_RET_RTI;
				end if;
		end process;
		
		--5
		process(EXCEPTION_SEL, F_MUX_PRED, EXCEPTION_IN)
			begin
				if EXCEPTION_SEL = '1' then
					F_MUX_EXCEPTION <= EXCEPTION_IN;
				else
					F_MUX_EXCEPTION <= F_MUX_PRED;
        end if;
    end process;
	 ---------------------- PC--------------------------------------------------------------
	
	
	NEW_PC: PC_comp port map(clk, RST_SEL, F_MUX_EXCEPTION,O_PC);


	--------------------------------------------------------------------------------------------
		--6
	 I_MUX_RST<="0000000000000000";
	 process(RST_SEL, O_PC)
    begin
        if RST_SEL = '1' then
            F_MUX_RST <= I_MUX_RST;
        else
            F_MUX_RST <= O_PC;
        end if;
    end process;
		
		---------------------- INSTRUCTION MEMORY-------------------------------------
		
	NEW_Instruction_Memory: Instruction_Memory port map(F_MUX_RST,F_Instruction_Memory,F_Index_Memory);


		---------------------- JMP_ADDRESS_GENERATOR MEMORY-------------------------------------
		
		
	NEW_JMP_ADD_GENERATOR: JMP_ADD_GENERATOR port map(I_JMP_ADDRESS_GENERATOR, O_JMP_ADDRESS_GENERATOR);
		--------------------------------------------------------------------------------------------
		--CALC
		ge0<='1' when TO_INTEGER(UNSIGNED(F_MUX_RST))>=0
		ELSE '0';

		le3<='1' when TO_INTEGER(UNSIGNED(F_MUX_RST))<=3
		ELSE '0';

		GeneratorSel<=(ge0 AND le3);
		-------------------------------------------------------------------------------
		--7
	    process(GeneratorSel, F_Instruction_Memory, O_JMP_ADDRESS_GENERATOR)
		begin
        if GeneratorSel = '1' then
            F_MUX_GENERATOR <= O_JMP_ADDRESS_GENERATOR;
        else
            F_MUX_GENERATOR <= F_Instruction_Memory;
        end if;
		end process;
		
		---------------------------------------------
		--CALC
		S_MUX_ADDER<=F_MUX_GENERATOR(0);
		IN_PLUS_1<="0000000000000001";
		IN_PLUS_2<="0000000000000010";
		------------------------------------
		--8
	   process(S_MUX_ADDER)
			begin
				if S_MUX_ADDER = '1' then
					F_MUX_ADDER <= IN_PLUS_2;
				else
					F_MUX_ADDER <= IN_PLUS_1;
				end if;
		end process;
		
		-------------------------------------------------------
		--CALC
		S_MUX_NOP<=(NOT (RST_SEL) AND HAZARD_DU_stall);
		-----------------------------------------------------
		--9
	  process(S_MUX_NOP, F_MUX_GENERATOR, NOP_CU)
      begin
          if S_MUX_NOP = '1' then
              F_MUX_NOP <= NOP_CU;
          else
              F_MUX_NOP <= F_MUX_GENERATOR;
          end if;
      end process;
		
	
		------------------------------------------------------------------------------------
		--CALC
		OUT_AND_IN_OR<=HLT_CU_ADDER AND (NOT (RST_SEL));
		ADDER_DISABLE<= (HAZARD_DU_ADDER OR HLT_CU_ADDER);
		---------------------------------------------------------------------------------
		process(ADDER_DISABLE,F_MUX_ADDER,O_PC)
		begin
            if (ADDER_DISABLE = '0') then
               F_ADDER <= std_logic_vector(unsigned(F_MUX_ADDER) + unsigned(O_PC));
                F_ADDER_reg <= F_ADDER;  
            else
                F_ADDER <= F_ADDER_reg;
            end if;
		end process;
		
		
		
		------------------------------------------------------------------
		--CALC
		REG_INDEX_ADD<=("0000000000000000000000000000000" & REG_INDEX);
		-------------------------------------------------------------------
		process(F_Instruction_Memory)
		begin
        
         I_JMP_ADDRESS_GENERATOR <= std_logic_vector(unsigned(F_Instruction_Memory) + unsigned(REG_INDEX_ADD));

        
		end process;
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------
	
	
	
	O_IMM<=F_Instruction_Memory(31 DOWNTO 16);
	O_OPCODE<=F_Instruction_Memory(15 DOWNTO 11);
	O_RDST<=F_Instruction_Memory(10 DOWNTO 8);
	
	O_InputPort<=INPUT_PORT;

		process(clk)
		BEGIN
		IF rising_edge(clk) THEN  
			PC_1<=F_ADDER;
			PC<=F_MUX_EXCEPTION;
			Instruction<=F_MUX_NOP;
			
			IMM<=O_IMM;
			OPCODE<=O_OPCODE;
			RDST<=O_RDST;
			InputPort_F_D_B<=O_InputPort;
			
		END IF;
			
		END PROCESS;
		
		
	end architecture arch;