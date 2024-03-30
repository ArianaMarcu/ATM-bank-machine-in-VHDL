library	ieee;
use ieee.std_logic_1164.all;
entity mux is
	port(s2,s1,s0: std_logic;
	n1,n2,n3,n4,n5,n6,n7,n8: in std_logic_vector (3 downto 0);
	c: out std_logic_vector (3 downto 0));
end entity;
architecture mux1 of mux is
begin 
	process(s0,s1)
	begin
		if s2='0' then 
			if(s1='0') then
				if(s0='0') then
					c<=n1;
				else
					c<=n2;
				end if;
			else
				if(s0='0') then
					c<=n3;
				else
					c<=n4;
				end if;
			end if;
		else if(s1='0') then
				if(s0='0') then
					c<=n5;
				else
					c<=n6;
				end if;
			else
				if(s0='0') then
					c<=n7;
				else
					c<=n8;
				end if;
			end if;
		end if;
	end process;
end architecture;