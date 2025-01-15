library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PredictionUnit is
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
end PredictionUnit;

architecture Behavioral of PredictionUnit is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Default outputs
            JMPTaken <= '0';
            FlushFlag <= '0';
            JMPAddressSelector <= "00";

            -- Check input flags
            if UnCondJMPMANThree = '1' then 
                JMPTaken <= '1';
                FlushFlag <= '0';
                JMPAddressSelector <= "10";
            elsif CondJMPMAN = '1' then
                -- Conditional Jump
                JMPTaken <= '0';
                FlushFlag <= '0';
                JMPAddressSelector <= "00";
            elsif UnCondJMPMANImm = '1' then
                -- Unconditional Jump
                JMPTaken <= '1';
                FlushFlag <= '0';
                JMPAddressSelector <= "00";
            elsif UnCondJMPMANRsrc1 = '1' then
                -- Unconditional Jump
                JMPTaken <= '1';
                FlushFlag <= '0';
                JMPAddressSelector <= "01";
            elsif YouWereWrongBuddyFlag = '1' then
                -- Misprediction correction
                JMPTaken <= '1';
                FlushFlag <= '1';
                JMPAddressSelector <= "01";
            end if;
        end if;
    end process;
end Behavioral;
