LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY scazator_16biti IS
	PORT(suma_retras ,suma_cont:IN STD_LOGIC_VECTOR(15 DOWNTO 0); 	
	suma_retras_final:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	enable: in std_logic);
END ENTITY;

architecture scazator16 of scazator_16biti is
BEGIN					
	PROCESS	(suma_retras,suma_cont) 
	VARIABLE intermediar:INTEGER;	
	BEGIN  
	if enable='1' then
		IF (suma_cont>suma_retras) THEN 
			intermediar:=CONV_INTEGER(suma_cont)-CONV_INTEGER(suma_retras);
			suma_retras_final<=CONV_STD_LOGIC_VECTOR(intermediar,16);	
		ELSE suma_retras_final<="1111111111111111";	
		END IF;
	end if;
	END PROCESS;  	
end architecture;	