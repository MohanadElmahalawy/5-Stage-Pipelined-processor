library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY ALU IS
PORT
(
--	RST: IN STD_LOGIC ;
	REG1_ALU,REG2_ALU :IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	ALU_OPCODE: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	ALU_OUTPUT :OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	FLAGS :OUT STD_LOGIC_VECTOR(2 DOWNTO 0) ); --- Z N C---
END ENTITY ALU;
ARCHITECTURE ALU_ARCH OF ALU IS 
	SIGNAL TEMP_FLAGS: STD_LOGIC_VECTOR (2 downto 0) := (OTHERS => '0');
	SIGNAL TEMP_OUTPUT: STD_LOGIC_VECTOR (16 downto 0);
	
	BEGIN 
	WITH ALU_OPCODE SELECT
	TEMP_OUTPUT <= 
---NOT---
					'0' & NOT REG1_ALU WHEN "00011",
---AND---
					 '0' & (REG1_ALU AND REG2_ALU) WHEN "01010",
---INC---
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) + 1, 17))  WHEN "00100",
---ADD---
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) + TO_INTEGER(SIGNED(REG2_ALU)), 17)) WHEN "01000",
---SUB---
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) - TO_INTEGER(SIGNED(REG2_ALU)), 17)) WHEN "01001",
---IADD---
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) + TO_INTEGER(SIGNED(REG2_ALU)), 17)) WHEN "01011",
---LDD---
--- REG2 has offset------ 
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) + TO_INTEGER(SIGNED(REG2_ALU)), 17)) WHEN "01111",
---STD---
					STD_LOGIC_VECTOR(TO_SIGNED(TO_INTEGER(SIGNED(REG1_ALU)) + TO_INTEGER(SIGNED(REG2_ALU)), 17)) WHEN "10000",
					
---OTHER CASES---
					'0' & REG1_ALU WHEN OTHERS;
					
------FLAGS-----------
---CARRY FLAG 0 ---
	TEMP_FLAGS(0) <= TEMP_OUTPUT(16) WHEN
-----SETC---
--									(ALU_OPCODE = "00010") 
---INC---
									(ALU_OPCODE="00100")
--ADD---
									OR(ALU_OPCODE="01000")
---IADD---
									OR (ALU_OPCODE="01011")
---SUB---
									OR (ALU_OPCODE="01001")
						ELSE '0';
							
---NEG FLAG 1 ---
	TEMP_FLAGS(1) <=TEMP_OUTPUT(15); 
---NOT---						 
---INC---
---ADD---
---IADD---
---SUB---
--AND---
		
---ZERO FLAG 2 ---
	TEMP_FLAGS(2) <= '1' WHEN TEMP_OUTPUT(15 DOWNTO 0) = "0000000000000000" ELSE '0';
---NOT---					
---INC---
---ADD--
---IADD---
---SUB---
--AND---
	FLAGS<=TEMP_FLAGS;
	ALU_OUTPUT<=TEMP_OUTPUT(15 DOWNTO 0);
END ARCHITECTURE ALU_ARCH;

