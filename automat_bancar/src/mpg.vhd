
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MPG is
Port 
(
signal btn:in std_logic;
signal clk:in std_logic;
signal rez:out std_logic
 );
end MPG;

architecture Behavioral of MPG is

signal counter:std_logic_vector(15 downto 0);

signal Q1:std_logic; 
signal Q2:std_logic;
signal Q3:std_logic;
begin

process(clk)
begin

if clk='1' and clk'event then

    if counter="1111111111111111" then
        Q1<=btn;
    end if;
    Q2<=Q1;
    Q3<=Q2;
    counter<=counter+1;
end if;
end process;

rez<=not(Q3) and Q2;
end Behavioral;
