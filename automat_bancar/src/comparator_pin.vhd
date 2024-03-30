library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparator_PIN is
	port
	(pin : in std_logic_vector(15 downto 0);
--	suma: in std_logic_vector(15 downto 0);
ok_pin: out std_logic;
enable: in std_logic);	
end comparator_PIN;

architecture Behavioral of comparator_PIN is 	

component ROM_PIN 
port (cont: in std_logic_vector(1 downto 0);
PIN: out std_logic_vector(15 downto 0));
end component;	

signal pin_memorie_1: std_logic_vector(15 downto 0);
signal pin_memorie_2: std_logic_vector(15 downto 0);
signal pin_memorie_3: std_logic_vector(15 downto 0);
signal pin_memorie_4: std_logic_vector(15 downto 0);
signal  ok: std_logic:='0';
begin 											 
	c1: rom_pin port map("00",pin_memorie_1);
	c2: rom_pin port map("01",pin_memorie_2);
	c3: rom_pin port map("10",pin_memorie_3);
	c4: rom_pin port map("11",pin_memorie_4);
	process(pin,enable) 
	begin
	if enable='1' then
	if pin_memorie_1 = pin then 
		ok<='1';
	elsif  pin_memorie_2 = pin then 
		ok<='1';
	elsif  pin_memorie_3 = pin then 
		ok<='1';
	elsif  pin_memorie_4 = pin then 
		ok<='1';
	else ok<='0';
	end if;
	end if;
	--ok_pin<=ok;
	end process;
	ok_pin<=ok;
end Behavioral;