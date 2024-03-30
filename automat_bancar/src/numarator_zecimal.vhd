library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
entity numarator_zec is
	port( clk: in std_logic;
	carry: out std_logic;
	numar:out std_logic_vector (3 downto 0));
end entity;	 

architecture numarator_zec1 of numarator_zec is
signal tmp: std_logic_vector(3 downto 0):=(others =>'0');
begin
	process(clk, tmp)
	begin
		if clk'event and clk='1' then 
			if tmp ="1001" then tmp<="0000";
			else
				tmp<=tmp+1;
			end if;
		end if;
		end process;
		carry<= tmp(3) and tmp(0);
		numar<=tmp;
end numarator_zec1;