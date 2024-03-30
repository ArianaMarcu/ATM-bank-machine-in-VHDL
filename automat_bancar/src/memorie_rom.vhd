library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ROM_PIN is
	port (cont: in std_logic_vector(1 downto 0);
PIN: out std_logic_vector(15 downto 0));
end entity;
architecture comportamentala of ROM_PIN is
	type memorie is array(0 to 3) of std_logic_vector(15 downto 0);
	constant ROM: memorie := (
	0 => "0001001000110100",   --1234	
	1 => "0111010000100101",   --7425
	2 => "1001011000001000",   --9608
	3 => "0001010100010001"   --1511   
);
begin
	process (cont)
	begin
case cont is
			when "00" => PIN <= ROM(0);
			when "01" => PIN <= ROM(1);
			when "10" => PIN <= ROM(2);
			when "11" => PIN <= ROM(3);
			when others => PIN <= "0000000000000000";
		end case;
end process;
end architecture;