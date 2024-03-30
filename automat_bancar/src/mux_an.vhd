library	ieee;
use ieee.std_logic_1164.all;
entity muxx is
	port(s2,s1,s0: std_logic;
	an: out std_logic_vector (7 downto 0));
end entity;	
architecture mux_an of muxx is
begin
	process(s2,s1,s0)	 
	begin
		if s2='0' then 
			if(s1='0') then
				if(s0='0') then
					an<="11111110";
				else
					an<="11111101";
				end if;
			else
				if(s0='0') then
					an<="11111011";
				else
					an<="11110111";
				end if;
			end if;
		else if(s1='0') then
				if(s0='0') then
					an<="11101111";
				else
					an<="11011111";
				end if;
			else
				if(s0='0') then
					an<="10111111";
				else
					an<="01111111";
				end if;
			end if;
		end if;
end process;
end architecture;