library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity div is
	port(clk_100: in std_logic;
	q2: out std_logic;
	q1: out std_logic;
	q0: out std_logic);
end entity;
architecture div1 of div is
begin
	process(clk_100)
	variable i: std_logic_vector(16 downto 0) :=(others=>'0');
	begin
		if(clk_100'event) and (clk_100='1') then
			i:=i+1;
		end if;
		q2<=i(16);
		q1<=i(15);
		q0<=i(14);
	end process;
end architecture;				 
