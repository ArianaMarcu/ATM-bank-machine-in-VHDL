library	ieee;
use ieee.std_logic_1164.all;

entity mux_afisari is
	port(	
	sel: in std_logic_vector (1 downto 0);
	anod: out std_logic_vector(7 downto 0);
	catod: out std_logic_vector (6 downto 0);
	an_0,an_1,an_2,an_3: in std_logic_vector (7 downto 0);
	cat_0,cat_1,cat_2,cat_3: in std_logic_vector (6 downto 0)
	); 
end entity;
architecture mux of mux_afisari is	  
begin			 				 

	process(sel,an_0,cat_0,an_1,cat_1)
	begin
		case sel is
			when "00" => anod<=an_0; catod<=cat_0;
			when "01" => anod<=an_1; catod<=cat_1;
			when "10" => anod<=an_2; catod<=cat_2;
			when "11" => anod<=an_3; catod<=cat_3;
			when others=> 
		end case; 
	end process;
end architecture;