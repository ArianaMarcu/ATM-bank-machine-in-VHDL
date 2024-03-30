library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity RAM_SUME is
port (		   
DATE_PIN: in std_logic_vector(15 downto 0);
	WE: in std_logic;
	CS_RAM: in std_logic;
	DATE_RAM: out std_logic_vector(15 downto 0); --suma initiala
	suma_in: in std_logic_vector(15 downto 0);
	enable:in std_logic);	 --suma adaugata
end entity;
architecture comportamentala of RAM_SUME is
type memorie is array(0 to 3) of std_logic_vector(15 downto 0);
begin
process(WE, CS_RAM,enable)
	variable RAM: memorie := ( "0000100000000000",   --800
						"0000001000010000",   --210
						"0000010000110001",   --431
						"0011000001010111"    --3057
);
begin
	if enable='1' then
		if(CS_RAM = '1') then
		IF WE ='0' THEN
			case DATE_PIN is
				when "0001001000110100" => DATE_RAM <= RAM(0);
				when "0111010000100101" => DATE_RAM <= RAM(1);
				when "1001011000001000" => DATE_RAM <= RAM(2);
				when "0001010100010001" => DATE_RAM <= RAM(3);
				when others =>
			end case;
			end if;
		ELSE
			case DATE_PIN is
				when "0001001000110100" => RAM(0) := suma_in;
				when "0111010000100101" => RAM(1) := suma_in;
				when "1001011000001000" => RAM(2) := suma_in;
				when "0001010100010001" => RAM(3) := suma_in;
				when others =>
			end case;
		end if;
	end if;
end process;
end architecture;