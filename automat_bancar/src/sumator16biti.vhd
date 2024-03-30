LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY sumator_16biti IS
	PORT(suma_depus ,suma_cont:IN STD_LOGIC_VECTOR(15 DOWNTO 0); 	
	suma_depus_final:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	enable: in std_logic);
END ENTITY;

architecture sumator16 of sumator_16biti is
BEGIN					
	PROCESS	(suma_depus,suma_cont,enable) 
	VARIABLE intermediar:INTEGER;	
	BEGIN		  
		if enable='1' then
		intermediar:=CONV_INTEGER(suma_cont)+CONV_INTEGER(suma_depus);
		suma_depus_final<=CONV_STD_LOGIC_VECTOR(intermediar,16);	
		end if;
	END PROCESS;  	
end architecture;	