library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IncrementDecrementUnit is
    port (
        clk          : in  std_logic;  
        inc_signal   : in  std_logic;  
        dec_signal   : in  std_logic;  
        Enablee       : in  std_logic;  
        input_value  : in  std_logic_vector(15 downto 0); 
        output_value : out std_logic_vector(15 downto 0)  
    );
end entity IncrementDecrementUnit;

architecture Behavioral of IncrementDecrementUnit is
    signal internal_value : std_logic_vector(15 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if Enablee = '1' then
                if inc_signal = '1' and dec_signal = '0' then
                    internal_value <= std_logic_vector(unsigned(input_value) + 1);
                elsif dec_signal = '1' and inc_signal = '0' then
                    internal_value <= std_logic_vector(unsigned(input_value) - 1);
                else
                    internal_value <= input_value; 
                end if;
            else
                internal_value <= input_value; 
            end if;
        end if;
    end process;

    output_value <= internal_value;
end architecture Behavioral;
