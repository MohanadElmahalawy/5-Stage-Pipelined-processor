library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Register_File is 
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
end entity; 



architecture behavioral of Register_File is 
type ram_type is array((2**3)-1 downto 0) of std_logic_vector(15 downto 0); 
signal memory : ram_type;


begin 
	process(clk, rst) 
	begin 
		if(rst = '1') then
			for loc in 0 to (2**3) - 1 loop
				memory(loc) <= (others => '0');
			end loop;
		elsif rising_edge(clk) then
			if reg_write='1' then 
				memory(to_integer(unsigned(write_address))) <= data_in; 
			end if; 
		end if;
	end process; 

	data_out1 <= memory(to_integer(unsigned(read1_address)));
	data_out2 <= memory(to_integer(unsigned(read2_address)));
end architecture;
