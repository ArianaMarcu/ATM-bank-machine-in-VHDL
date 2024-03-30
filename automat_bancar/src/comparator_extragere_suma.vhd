library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comparator_extragere is
	port
	(
	suma_extragere: in std_logic_vector(15 downto 0);	
	suma_cont: in std_logic_vector(15 downto 0);
    ok_extragere: out std_logic;
	enable: in std_logic);
end comparator_extragere;

architecture Behavioral of comparator_extragere is
begin
	PROCESS	(suma_extragere,suma_cont,enable) 
	VARIABLE intermediar:INTEGER;	
	BEGIN
		if enable='1' then
			if(CONV_INTEGER(suma_extragere)<CONV_INTEGER(suma_cont)) then
				ok_extragere<='1';
			else ok_extragere<='0';
			end if;
		end if;
	END PROCESS;
end Behavioral;

