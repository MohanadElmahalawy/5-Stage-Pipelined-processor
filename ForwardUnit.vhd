library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ForwardUnit is
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
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Default values
            Rsrc1OverWriteFlag <= (others => '0');
            Rsrc2OverWriteFlag <= (others => '0');

            -- Prioritize ALU logic
            if WbALU = '1' then
                if Rsrc1 = RdstALU then
                    Rsrc1OverWriteFlag(1 DOWNTO 0 )  <= "10";
                end if;
                if Rsrc2 = RdstALU then
                    Rsrc1OverWriteFlag(1 DOWNTO 0 )  <= "10";
                end if;
            elsif WbMEM = '1' then -- Only check MEM if ALU isn't active
                if Rsrc1 = RdstMEM then
                    Rsrc1OverWriteFlag(1 DOWNTO 0 )  <= "11";
                end if;
                if Rsrc2 = RdstMEM then
                    Rsrc1OverWriteFlag(1 DOWNTO 0 )  <= "11";
                end if;
            end if;
        end if;
    end process;
end Behavioral;