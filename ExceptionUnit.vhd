library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ExceptionUnit is
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
end ExceptionUnit;

architecture Behavioral of ExceptionUnit is
    signal F_PanicMode : std_logic ;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Default outputs
            FlushFlag <= '0';
            F_PanicMode <= '0';
            ExceptionAddress <= (others => '0'); -- Default to 0x0000

            -- Logic based on StackSelector and CheckOnMan
            if StackSelector = '0' then
                if CheckOnMan = x"FFFF" then
                    ExceptionAddress <= x"0001";
                    FlushFlag <= '1';
                    F_PanicMode <= '1';
                end if;
            else
                if CheckOnMan = x"0FFF" then
                    ExceptionAddress <= x"0002";
                    FlushFlag <= '1';
                    F_PanicMode <= '1';
                end if;
            end if;
            PanicModeON <= F_PanicMode;
            if F_PanicMode <= '1' then
                EPCVALUE <= Naughty_PC ;
            else 
                EPCVALUE <= (others => '0');
            end if;
        end if;
    end process;
	 END Behavioral;