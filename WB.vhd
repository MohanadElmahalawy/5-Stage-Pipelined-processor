library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WB is
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
end WB;

architecture Behavioral of WB is
    signal F_WBSEL_MUX   : std_logic_vector(15 downto 0); 
    signal F_Reg_Address : std_logic_vector(2 downto 0);
    signal F_Flags_CCR   : std_logic_vector(2 downto 0);
    signal F_SETCCR_Flag : std_logic; 
    signal F_ret_Flag    : std_logic;
    signal F_WB_EN       : std_logic;
    signal F_MemOUt      : std_logic_vector(15 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            case WB_SEL is
                when "00" => 
                    F_WBSEL_MUX <= Vsrc1; -- Select Vsrc1
                when "01" => 
                    F_WBSEL_MUX <= ALUOUT; -- Select ALUOUT
                when "10" => 
                    F_WBSEL_MUX <= MEMOUT; -- Select MEMOUT
                when "11" => 
                    F_WBSEL_MUX <= INport; -- Select INport
                when others =>
                    F_WBSEL_MUX <= (others => '0'); -- Default case
            end case;

            if OUTPUTEnablteWB = '1' then
                WB_OutPort_Data <= F_WBSEL_MUX; -- Forward to WB_OutPort_Data if needed
            else
                WB_OutPort_Data <= OUTPUTPrevDATA; -- Forward to WB_OutPort_Data if needed
            end if;

            WB_Reg_Data       <= F_WBSEL_MUX; 
            F_Reg_Address     <= WB_Reg_Address_in;
            WB_Reg_Address_out <= F_Reg_Address;
            F_Flags_CCR       <= MEMOUT(2 downto 0) ;
            Flags_CCR_out     <= F_Flags_CCR;
            F_SETCCR_Flag     <= SETCCR_Flag_in;
            SETCCR_Flag_out   <= F_SETCCR_Flag;
            F_WB_EN           <= Reg_WB_Flag_in;
            Reg_WB_Flag_out   <= F_WB_EN;
            F_ret_Flag        <= RET_Flag_in;
            RET_Flag_out      <= F_ret_Flag;
            F_MemOUt          <= std_logic_vector(shift_right(unsigned(MEMOUT), 4));
            popped_PC         <= F_MemOUt;
        end if;
    end process;

end Behavioral;