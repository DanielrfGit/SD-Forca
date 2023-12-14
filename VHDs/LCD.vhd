----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:13 12/12/2023 
-- Design Name: 
-- Module Name:    LCD - arquiteturaLCD 
-- Project Name: 
-- Target Devices: 
-- Tool veregisterSelections: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity LCD is
generic (fclk: natural := 110_000_000); 
		port (tentativa : in STD_LOGIC_VECTOR (2 downto 0);			
		      confirmar : in STD_LOGIC;					
		      resetar : in STD_LOGIC;						
		      clk   : in STD_LOGIC;					
		      tentativasRestantes:  out std_logic_vector(2 downto 0); 			
		      registerSelect, readWrite      : out bit;						
		      E           : buffer bit;  					
		      bitData          : out bit_vector(7 downto 0)); 			
end LCD;

architecture arquiteturaLCD of LCD is																	
	type state is (FunctionSetl, FunctionSet2, FunctionSet3,
	 FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,				
	 FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDisplay, DisplayControl, EntryMode, 		
	 WriteDatal, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,WriteData11,			
	 WriteData12,SetAddress,SetAddress1, ReturnHome);													
	
	signal aState, nextState: state; 	      
	signal displayParcial : std_logic_vector(4 downto 0);   
	signal resultado : std_logic_vector(1 downto 0);  
	signal clkExtra : std_logic;		      
	
Component forca is						
    Port ( tentativa : in  STD_LOGIC_VECTOR (2 downto 0);    	
           confirmar : in  STD_LOGIC;				
	   resetar : in std_logic;
	   clk   : in std_logic;
	   tentativasRestantes: out std_logic_vector(2 downto 0);
	   display: out STD_LOGIC_VECTOR(4 downto 0);
	   resultado : out std_logic_vector(1 downto 0)
	 );
end component;
begin

forca_f: forca port map (tentativa,confirmar,resetar,clkExtra,tentativasRestantes,displayParcial,resultado);  

		process (clk)				
		variable count: natural range 0 to fclk/100; 	
		begin					
			if (clk' event and clk = '1') then 	
				count := count + 1;
				if (count=fclk/100) then 
				 E <= not E; 
				 clkExtra <= NOT clkExtra;
				 count := 0; 
				end if; 
			end if; 
		end process;

		process (E) 					
		begin
			if (E' event and E = '1') then 
				aState <= FunctionSetl; 
				aState <= nextState; 
			end if; 
		end process;
		
		process (aState) 
		begin
		case aState is


		when FunctionSetl => 				
		registerSelect<= '0'; readWrite<= '0'; 		
		bitData<= "00111000"; 		
		nextState <= FunctionSet2; 	
						
		when FunctionSet2 => 		
		registerSelect<= '0'; readWrite<= '0'; 
		bitData <= "00111000";
		nextState <= FunctionSet3; 
		
		when FunctionSet3 => 
		registerSelect <= '0'; readWrite<='0'; 
		bitData <= "00111000"; 
		nextState <= FunctionSet4;

		when   FunctionSet4   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet5;

		when   FunctionSet5   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet6;

		when   FunctionSet6   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet7;

		when   FunctionSet7   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet8;

		when   FunctionSet8   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet9;

		when   FunctionSet9   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet10;

		when   FunctionSet10   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet11;

		when   FunctionSet11   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet12;

		when   FunctionSet12   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet13;

		when   FunctionSet13   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet14;

		when   FunctionSet14   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet15;

		when   FunctionSet15   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet16;

		when   FunctionSet16   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet17;

		when   FunctionSet17   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet18;

		when   FunctionSet18   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= FunctionSet19;

		when   FunctionSet19   =>
		registerSelect<=  '0'; readWrite<=  '0';
		bitData   <=   "00111000";
		nextState <= ClearDisplay ;


		when ClearDisplay =>
		registerSelect<= '0'; readWrite<= '0';
		bitData <= "00000001";
		nextState <= DisplayControl; 
		
		when   DisplayControl   =>
		registerSelect<= '0';   readWrite<=  '0';
		bitData   <=  "00001100";
		nextState <= EntryMode; 
		
		when EntryMode =>
		registerSelect<= '0'; readWrite<= '0';
		bitData <= "00000110";
		nextState   <=  WriteDatal; 

		when  WriteDatal =>
		registerSelect<=   '1';   readWrite <='0';
		bitData   <=   "00100000";   
		nextState <= SetAddress1; 

		when SetAddress1 =>
		registerSelect<=   '0';   readWrite<=   '0';
		bitData   <=  "10000101";        
		nextState  <= WriteData2; 
		

		when WriteData2 =>		
		registerSelect<= '1'; readWrite<= '0';		
		if (displayParcial(4) = '1') then		
			bitData <= X"33"; --3	
		else				
			bitData <= X"2A"; -- *	
		end if;				
		nextState <= WriteData3; 
		
		when WriteData3 =>
		registerSelect<= '1'; readWrite<= '0';
		if (displayParcial(3) = '1') then
			bitData <= X"37"; --7
		else
			bitData <= X"2A"; -- *
		end if;     
		nextState  <= WriteData4; 
		
		when  WriteData4   =>
		registerSelect<=   '1';   readWrite<=   '0';
		if (displayParcial(2) = '1') then
			bitData <= X"32"; --2
		else
			bitData <= X"2A"; -- *
		end if;
		nextState  <= WriteData5; 

		when  WriteData5   =>
		registerSelect<=   '1';   readWrite<=   '0';
		if (displayParcial(1) = '1') then
			bitData <= X"35"; --5
		else
			bitData <= X"2A"; -- *
		end if;
		nextState  <= WriteData6;
		
		when  WriteData6   =>
		registerSelect<=   '1';   readWrite<=   '0';
		if (displayParcial(0) = '1') then
			bitData <= X"36"; --6
		else
			bitData <= X"2A"; -- *
		end if;
		nextState  <= SetAddress;
	
		when SetAddress =>
		registerSelect<=   '0';   readWrite<=   '0';
		bitData   <=  "11000101";         
		nextState  <= WriteData7;

		when  WriteData7   =>			
		registerSelect<=   '1';   readWrite<=   '0';		
		if (resultado = "00") then			
			bitData <= X"20"; -- espaço		
		elsif (resultado = "01") then		
			bitData <= X"50"; --P		
		else
			bitData <= X"56"; --V
		end if;
		nextState  <= WriteData8;

		when  WriteData8   =>
		registerSelect<=   '1';   readWrite<=   '0';
		if (resultado = "00") then
			bitData <= X"20"; -- espaço
		elsif (resultado = "01") then
			bitData <= X"45"; --E
		else
			bitData <= X"45"; --E
		end if;
		nextState  <= WriteData9;

		when WriteData9 =>
		registerSelect<= '1'; readWrite<= '0';
		if (resultado = "00") then
			bitData <= X"20"; -- espaço
		elsif (resultado = "01") then
			bitData <= X"52"; --R
		else
			bitData <= X"4E"; --N
		end if;
		nextState <= WriteData10; 

		when WriteData10 =>
		registerSelect<= '1'; readWrite<= '0';
		if (resultado = "00") then
			bitData <= X"20"; -- espaço
		elsif (resultado = "01") then
			bitData <= X"44"; --D
		else
			bitData <= X"43"; --C
		end if;
		nextState <= WriteData11; 

		when WriteData11 =>
		registerSelect<= '1'; readWrite<= '0';
		if (resultado = "00") then
			bitData <= X"20"; -- espaço
		elsif (resultado = "01") then
			bitData <= X"45"; --E
		else
			bitData <= X"45"; --E
		end if;
		nextState <= WriteData12;

		when WriteData12 =>
		registerSelect<= '1'; readWrite<= '0';
		if (resultado = "00") then
			bitData <= X"20"; -- espaço
		elsif (resultado = "01") then
			bitData <= X"55"; --U
		else
			bitData <= X"55"; --U
		end if;
		nextState <= ReturnHome;
 
		
		when   ReturnHome   =>		
		registerSelect<=   '0';   readWrite<=  '0';
		bitData   <=  "10000000";
		nextState <= WriteDatal; 
		
		end case; 
	end process;

end arquiteturaLCD;