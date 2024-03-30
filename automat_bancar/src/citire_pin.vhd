
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity intrari is
  Port 
  (	 
   clk:in std_logic;
   sw:in std_logic_vector(15 downto 0);
   an:out std_logic_vector(7 downto 0);
   cat:out std_logic_vector(6 downto 0);
   numar: out std_logic_vector(15 downto 0);
   numar1: out std_logic_vector(15 downto 0); 
   enable: in std_logic;
   rst: in std_logic
  );
end entity;

architecture compintrari of intrari is
--signal rst:std_logic:='0';
signal counter:integer:=0;
signal ceas_divizat: std_logic:='0';	 
signal numar_n1:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n2:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n3:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n4:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n5:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n6:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n7:std_logic_vector(3 downto 0):=(others=>'0');
signal numar_n8:std_logic_vector(3 downto 0):=(others=>'0');

component display
	port (clk: in std_logic;
	n1,n2,n3,n4,n5,n6,n7,n8: in std_logic_vector(3 downto 0);
	an:out std_logic_vector (7 downto 0);
	cat: out std_logic_vector (6 downto 0));
	end component;	

begin	    
	bit0: display port map (clk,numar_n1,numar_n2,numar_n3,numar_n4,numar_n5,numar_n6,numar_n7,numar_n8,an,cat);
	-- divizor de frecventa  
	  process(clk,rst)
	  begin			   
      if rst='1' then
		  counter<=0;
	  elsif clk'event and clk='1' then	   
		  if counter<499999999 then	  
			  ---1000000000	=1hz 
			counter<=counter+1;
	      else 
			  counter<=0;
			  ceas_divizat<=not(ceas_divizat);
	      end if;
      end if;
	  end  process;	 
		 
	process(sw)
	begin  
		if rst='1' then 
		  numar_n1<="0000";
		  numar_n2<="0000";
		  numar_n3<="0000";
		  numar_n4<="0000";
		  numar_n5<="0000";
		  numar_n6<="0000";
		  numar_n7<="0000";
		  numar_n8<="0000";
		 else
	if enable='1' then	
		if sw(3)='1' then	
			if RISING_EDGE(ceas_divizat) then
			   numar_n1<=numar_n1+1;
			end if;
		end if;
		if sw(2)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n2<=numar_n2+1;
			end if;
		end if;
		if sw(1)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n3<=numar_n3+1;
			end if;
		end if;
		if sw(0)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n4<=numar_n4+1;
			end if;
		end if;
		if sw(7)='1' then	
			if RISING_EDGE(ceas_divizat) then
			   numar_n5<=numar_n5+1;
			end if;
		end if;
		if sw(6)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n6<=numar_n6+1;
			end if;
		end if;
		if sw(5)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n7<=numar_n7+1;
			end if;
		end if;
		if sw(4)='1' then
			if RISING_EDGE(ceas_divizat) then
			   numar_n8<=numar_n8+1;
			end if;
		end if;
	else
		  numar(3 downto 0)<=numar_n1;
		  numar(7 downto 4)<=numar_n2;
		  numar(11 downto 8)<=numar_n3;
		  numar(15 downto 12)<=numar_n4;
		  numar1(3 downto 0)<=numar_n5;
		  numar1(7 downto 4)<=numar_n6;
		  numar1(11 downto 8)<=numar_n7;
		  numar1(15 downto 12)<=numar_n8;
	end if;	
	end if;
    end process;
  end architecture;