---proiect automat bancar

--- primii 4 anozi sunt pt pin iar ceilalti (pin0) reprezinta in functie de selectii: 
--- pt 00-interogare sold-> nimic
---	pt 01-depunere -> suma pe care vr sa o depui
--- pt 10- retragere -> suma pe care vr sa o retragi
--- pt 11-transfer -> suma pe care vrei sa o transferi
--- inainte sa se apese butonul trebuie setate:
-- operatiile sw(15-14),
-- iar in cazul transferului sw(12-11) reprezinta adresa pinului din memorie unde o sa se realizeze transferul 
-- chitanta sw13 

library	ieee;
use ieee.std_logic_1164.all;

entity intrari_si_iesiri is
	port(
	clk: in std_logic;
	sw: in std_logic_vector(15 downto 0);
	but: in std_logic_vector(5 downto 0);
	led: out std_logic_vector(15 downto 0);
	an: out std_logic_vector( 7 downto 0);
	cat: out std_logic_vector(6 downto 0)	 
   );									
end entity;

architecture organigrama of intrari_si_iesiri is  

component intrari
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
end component;

component mux_afisari is
	port(	
	sel: in std_logic_vector (1 downto 0);
	anod: out std_logic_vector(7 downto 0);
	catod: out std_logic_vector (6 downto 0);
	an_0,an_1,an_2,an_3: in std_logic_vector (7 downto 0);
	cat_0,cat_1,cat_2,cat_3: in std_logic_vector (6 downto 0)); 
end component;

component comparator_PIN is
	port
	(pin : in std_logic_vector(15 downto 0);
--	suma: in std_logic_vector(15 downto 0);
	ok_pin: out std_logic;
	enable:in std_logic);	
end component;

component RAM_SUME is
port (		   
DATE_PIN: in std_logic_vector(15 downto 0);
	WE: in std_logic;
	CS_RAM: in std_logic;
	DATE_RAM: out std_logic_vector(15 downto 0); --suma din cont 
	suma_in: in std_logic_vector(15 downto 0);
	enable:in std_logic);	 --suma modificata
end component;	

component display is
	port (clk: in std_logic;
	n1,n2,n3,n4,n5,n6,n7,n8: in std_logic_vector(3 downto 0);
	an:out std_logic_vector (7 downto 0);
	cat: out std_logic_vector (6 downto 0));
end component;	

component sumator_16biti IS
	PORT(suma_depus ,suma_cont:IN STD_LOGIC_VECTOR(15 DOWNTO 0); 	
	suma_depus_final:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	enable:in std_logic);
END component;

component scazator_16biti IS
	PORT(suma_retras ,suma_cont:IN STD_LOGIC_VECTOR(15 DOWNTO 0); 	
	suma_retras_final:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	enable:in std_logic);
END component;

component dispersie_banc is
Port 
( clk:in std_logic;
 rst:in std_logic;
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
end component;

component comparator_extragere is
	port
	(
	suma_extragere: in std_logic_vector(15 downto 0);	
	suma_cont: in std_logic_vector(15 downto 0);
    ok_extragere: out std_logic;
	enable:in std_logic);
end component;

component MPG is
Port 
(
signal btn:in std_logic;
signal clk:in std_logic;
signal rez:out std_logic
 );
end component;

signal anod0,anod1,anod2,anod3: std_logic_vector(7 downto 0);
signal catod0,catod1,catod2,catod3: std_logic_vector(6 downto 0);
signal enable_pin,rst_pin: std_logic:='0';
signal pin, pin0,pin_transfer: std_logic_vector(15 downto 0);
signal reset,rst_dispersie: std_logic:='0';
signal pin_bun,ok_retragere,ok_transfer: std_logic; 
signal suma_pin,suma_ram,suma_depus,date_ram_depus,suma_transfer_adunare,suma_pin_transfer,suma_transfer_scadere: std_logic_vector(15 downto 0);
signal sel: std_logic_vector(1 downto 0);	
signal bancnota500,bancnota200,bancnota100,bancnota50,bancnota20,bancnota10,bancnota5,bancnota1: std_logic_vector(3 downto 0);
signal enable_ram_suma,enable_suma_depus,enable_ram_depus,enable_retragere,enable_comp_pin: std_logic:='0';	 
signal enable_transfer,enable_transfer_ram,enable_suma_transfer,enable_ramad_transfer,enable_scadere_transfer,enable_ramsc_transfer: std_logic:='0';
signal b0,b1: std_logic;

type stari is (modificare_ram,reset1,reset2,reset3,rst0,chitanta,continua,idle,citire_pin,verificare,operatie,interogare_sold,depunere,retragere,transfer);
signal curent, urmator: stari;

begin	
	-- pin0 o sa fie: suma depusa daca sw e 01 la inceput
					-- suma transferata daca sw e 11 la inceput
					-- suma retrasa daca sw e 10 la inceput	
	-- 00 						  
	pbut0: mpg	port map(but(0),clk,b0);  
	pbut1: mpg	port map(but(0),clk,b1);
	p1: intrari port map (clk,sw,anod0,catod0,pin,pin0,enable_pin,rst_pin);
	p2: mux_afisari port map (sel,an,cat,anod0,anod1,anod2,anod3,catod0,catod1,catod2,catod3);	
	p3: comparator_PIN port map (pin,pin_bun,enable_comp_pin);
	p4: RAM_SUME port map (pin,'0','1',suma_pin,suma_ram,enable_ram_suma); -- retinem in suma_pin suma ce corespunde pinului
	--interogare sold							
	p5	: display port map (clk,suma_pin(3 downto 0),suma_pin(7 downto 4),suma_pin(11 downto 8),suma_pin(15 downto 12),"1100","1011","0000","1010",anod1,catod1);--sold
	--depunere
	p6: sumator_16biti	port map (pin0,suma_pin,suma_depus,enable_suma_depus);
	p7: RAM_SUME port map(pin,'1','1',date_ram_depus,suma_depus,enable_ram_depus);
	p8: display port map (clk,suma_depus(3 downto 0),suma_depus(7 downto 4),suma_depus(11 downto 8),suma_depus(15 downto 12),"1100","1011","0000","1010",anod2,catod2);
	--transfer	
	p9: comparator_extragere port map(pin0,suma_pin,ok_transfer,enable_transfer);	
	p10: RAM_SUME port map(pin_transfer,'0','1', suma_pin_transfer,suma_ram,enable_transfer_ram);	--citeste suma din cont al pinului transferat 
	p11: sumator_16biti port map (pin0,suma_pin_transfer,suma_transfer_adunare,enable_suma_transfer); --aduna suma transferata la sold
	p12: RAM_SUME port map(pin_transfer,'1','1',date_ram_depus,suma_transfer_adunare,enable_ramad_transfer); -- schimba suma in memorie
	p13: scazator_16biti port map(pin0,suma_pin,suma_transfer_scadere,enable_scadere_transfer);
	p14: RAM_SUME port map (pin,'1','1',date_ram_depus,suma_transfer_scadere,enable_ramsc_transfer);	   
	--retragere	
	p15: comparator_extragere port map(pin0,suma_pin,ok_retragere,enable_retragere);
	p16: dispersie_banc port map(clk,rst_dispersie,pin0,bancnota500,bancnota200,bancnota100,bancnota50,bancnota20,bancnota10,bancnota5,bancnota1);
	p17: display port map (clk,bancnota500,bancnota200,bancnota100,bancnota50,bancnota20,bancnota10,bancnota5,bancnota1,anod3,catod3);
	-- trecere prin stari
	process(curent)	
	begin
	case curent is 
		when idle => urmator<= citire_pin; rst_pin<='1'; enable_pin<='1';
		when citire_pin => rst_pin<='0'; 
						if b0='1' then  urmator<=verificare; enable_pin<='0'; enable_comp_pin<='1';	
						else urmator<=citire_pin; enable_pin<='1';
						end if;
		when verificare=> enable_comp_pin<='0'; if pin_bun ='1' then led(0)<='1'; urmator<=operatie; enable_ram_suma<='1';
						--led(0)=1 pinul e bun/ led(1)=1 pinul nu e bun
						else led(1)<='1'; urmator<=idle;
						end if;	
		-- in functie de valorile sw(14) signal sw(15) alegi operatia
		--led(3) e activ pe interogare sold; led(4) activ pe depunere; led(5) activ pe retragere; led(6) activ pe transfer
		when operatie =>  enable_ram_suma<='0'; if sw(14)='0' and sw(15)='0' then urmator<= interogare_sold; led(3)<='0'; led(4)<='0';led(5)<='0'; led(6)<='0';
				elsif sw(14)='0' and sw(15)='1' then urmator<= depunere; enable_suma_depus<='1'; enable_suma_depus<='1'; led(3)<='0'; led(4)<='0';led(5)<='0'; led(6)<='0';
				elsif sw(14)='1' and sw(15)='0' then urmator<= retragere; enable_retragere<='1'; led(3)<='0'; led(4)<='0';led(5)<='0'; led(6)<='0';
				elsif sw(14)='1' and sw(15)='1' then urmator<= transfer; enable_transfer<='1';	led(3)<='0'; led(4)<='0';led(5)<='0'; led(6)<='0';
				end if;
		when interogare_sold=> led(3)<='1'; urmator<=chitanta;
		-- pt a primi chitanta sw(13) trebuie sa aiba val 1
		when chitanta => enable_suma_transfer<='0'; enable_ramad_transfer<='0'; 
						if b1='1'then
							if sw(13)='1' then led(2)<='1';
							else led(2)<='0';
							end if;	 
							urmator<=idle;	
						else urmator<=chitanta;
						end if;
		when depunere => enable_suma_depus<='1'; enable_ram_depus<='1'; led(4)<='1'; urmator<=chitanta;	
		when retragere=> enable_retragere<='0'; if ok_retragere='1' then led(5)<='1'; urmator<=chitanta; --urmator<=dispersie; 
						else urmator<=chitanta; led(5)<='0';
						end if;
		--when dispersie => enable_dispersie<='0'; urmator<=chitanta;
		when transfer=> if ok_transfer='1' then  enable_transfer<='0';  enable_transfer_ram<='1'; urmator<= modificare_ram;
			--enable_suma_transfer<='1';enable_ramad_transfer<='1';
						enable_scadere_transfer<='1'; enable_ramsc_transfer<='1';	
			--led(6)<='1'; urmator<=chitanta;	
						if sw(12)='0' and sw(11)='0' then pin_transfer<="0001001000110100";	  --pinul 1
						elsif sw(12)='0' and sw(11)='1' then pin_transfer<="0111010000100101"; -- pinul 2
						elsif sw(12)='1' and sw(11)='0' then pin_transfer<="1001011000001000"; -- pinul 3
						elsif sw(12)='1' and sw(11)='1' then pin_transfer<="0001010100010001";	-- pinul 4 
						end if;
					else urmator<=chitanta;	led(6)<='0';
					end if;
		when modificare_ram=> led(6)<='1'; enable_suma_transfer<='1'; enable_ramad_transfer<='1'; enable_scadere_transfer<='0'; enable_ramsc_transfer<='0'; urmator<=chitanta;
		when others=> urmator<=idle;
	end case;
	end process; 
	-- pentru alegere selectie
	process(curent)	
	begin
	case curent is 
		when citire_pin=> sel<="00"; 
		when interogare_sold=> sel<="01";
		when depunere => sel <="10"; 
		when retragere => sel <="11";
		--when transfer => sel <="11";
		when others=> sel<=sel;
	end case;
	end process;
	
	process(curent,clk)
	begin
		if reset='1' then 
			curent<=idle;
		elsif clk'event and clk='1' then
			curent<=urmator;
		end if;
	end process;  
end architecture;