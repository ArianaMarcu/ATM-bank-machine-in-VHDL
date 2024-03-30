library ieee;
use ieee.std_logic_1164.all;
entity display is
	port (clk: in std_logic;
	n1,n2,n3,n4,n5,n6,n7,n8: in std_logic_vector(3 downto 0);
	an:out std_logic_vector (7 downto 0);
	cat: out std_logic_vector (6 downto 0));
end entity;
architecture display1 of display is
component dcd
	port(i:in std_logic_vector(3 downto 0);
	cat: out std_logic_vector(6 downto 0));
end component;
component mux
	port(s2,s1,s0: in std_logic;
	n1,n2,n3,n4,n5,n6,n7,n8: in std_logic_vector(3 downto 0);
	c:out std_logic_vector( 3 downto 0));
end component;	
component muxx is
	port(s2,s1,s0: std_logic;
	an: out std_logic_vector (7 downto 0));
end component;	
component div
	port(clk_100: in std_logic;	
	q2:out std_logic;
	q1: out std_logic;
	q0:out std_logic);
end component;
signal  q2,q1,q0: std_logic;
signal n:std_logic_vector ( 3 downto 0);
begin
	c1: div port map (clk,q2,q1,q0);
	c2: muxx port map (q2,q1,q0,an);
	c3: mux port map (q2,q1,q0,n1,n2,n3,n4,n5,n6,n7,n8,n);
	c4: dcd port map(n,cat);
end architecture;