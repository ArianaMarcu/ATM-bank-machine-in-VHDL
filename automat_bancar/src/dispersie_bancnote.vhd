library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity dispersie_banc is
Port 
( clk:in std_logic;
rst:in std_logic; 
--enable: in std_logic;
 suma:in std_logic_vector(15 downto 0);
 bancnota500:out std_logic_vector(3 downto 0);
 bancnota200:out std_logic_vector(3 downto 0);
 bancnota100:out std_logic_vector(3 downto 0);
 bancnota50:out std_logic_vector(3 downto 0); 
 bancnota20:out std_logic_vector(3 downto 0);
 bancnota10:out std_logic_vector(3 downto 0);
 bancnota5:out std_logic_vector(3 downto 0);
 bancnota1:out std_logic_vector(3 downto 0)
);
end dispersie_banc;

architecture greedy of dispersie_banc is
signal disp_suma:integer;
-- 1 5 10 20 50 100 200 500
-- 0 1 2  3  4   5   6   7
type nr_bancnote is array(7 downto 0) of std_logic_vector(3 downto 0); --vector[8] de 4 biti
signal vector_bancnote:nr_bancnote:=(others=>(others=>'0'));  -- cate bancnote de fiecare tip sunt sunt in total 
--- vector_bancnote[i]=nr de banc de tip i
--- vector_bancnote[2]=2 320
--- 2= 0010 
type tip_bancnote is array(7 downto 0) of integer;-- zecimal
signal vector_tip_bancnote:tip_bancnote:=(0=>1,1=>5,2=>10,3=>20,4=>50,5=>100,6=>200,7=>500);
--- vector_tip_banc[1]=5/ [2]=10...
signal i:integer range 7 downto 0:=7; --incepem de la cea mai mare bancnota

type stari is (idle,incarcare_suma,dispersie_suma,scadere_suma,scadere_i,suma_final,stop); 

signal stare_curenta:stari:=idle;
signal stare_urmatoare:stari:=idle;
begin

--proces pentru a actualiza starea curenta cu starea urmatoare sau reset
process(clk,rst)
begin
	if rst='1' then
		stare_curenta<=idle;
	elsif clk='1' and clk'event then
		stare_curenta<=stare_urmatoare;
	end if;
end process;

-- proces pentru a determina starea urmatoare in functie de starea curenta si anumite conditii ( daca exista)
process(stare_curenta,i,vector_tip_bancnote,disp_suma)
begin
	case stare_curenta is
		when idle=>stare_urmatoare<=incarcare_suma;
		when incarcare_suma=>stare_urmatoare<=dispersie_suma;
		when dispersie_suma=>if disp_suma-vector_tip_bancnote(i)>=0 then stare_urmatoare<=scadere_suma;
                      else stare_urmatoare<=scadere_i;
                      end if;
		when scadere_i=>stare_urmatoare<=suma_final;
when scadere_suma=>stare_urmatoare<=suma_final;
when suma_final=>if disp_suma=0 then stare_urmatoare<=stop;
            else
                stare_urmatoare<=dispersie_suma;
            end if;
when stop=>stare_urmatoare<=idle;
end case;
end process;

process(clk)
begin
if clk'event and clk='1' then
    if stare_curenta=incarcare_suma then
        disp_suma<=conv_integer(suma); --transf in zecimal
        i<=7;
    end if;
    if stare_curenta=scadere_i then
        i<=i-1;
    end if;
    if stare_curenta=scadere_suma then
        disp_suma<=disp_suma-vector_tip_bancnote(i);
		vector_bancnote(i)<=vector_bancnote(i)+1;
    end if;
end if;
end process;

bancnota500<=vector_bancnote(7);
bancnota200<=vector_bancnote(6);
bancnota100<=vector_bancnote(5);
bancnota50<=vector_bancnote(4);
bancnota20<=vector_bancnote(3);
bancnota10<=vector_bancnote(2);
bancnota5<=vector_bancnote(1);
bancnota1<=vector_bancnote(0);
end architecture;
