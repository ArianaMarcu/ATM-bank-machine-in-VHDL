library	ieee;
use ieee.std_logic_1164.all;
entity dcd is
	port( I: in std_logic_vector (3 downto 0);
	cat:out std_logic_vector (6 downto 0));
end dcd;
architecture dcd1 of dcd is
begin 
	process(I)
	begin
		case I is 
			when "0000" => cat <=not("0111111"); --0
			when "0001" => cat <=not("0000110");	--1
			when "0010" => cat <=not("1011011");	   --2
			when "0011" => cat <=not("1001111");		  --3
			when "0100" => cat <=not("1100110");			 --4
			when "0101" => cat <=not("1101101");				--5
			when "0110" => cat <=not("1111101");				   --6
			when "0111" => cat <=not("0000111");					  --7
			when "1000" => cat <=not("1111111");						 --8
			when "1001" => cat <=not("1101111");--9	
			when "1010" => cat<= not("1101101");-- S
			when "1011" => cat<= not("0111000");--L	
			when "1100" => cat<= not("1011110");--d
			when others => cat <="1000000";	  
		end case;
		end process;
end architecture;
			