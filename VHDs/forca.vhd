----------------------------------------------------------------------------------
-- company: 
-- Engineer: 
-- 
-- Create Date:    12:14:34 12/12/2023 
-- Design Name: 
-- Module Name:    forca - forcaArquitetura 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity forca is
    Port ( tentativa : in  STD_LOGIC_VECTOR (2 downto 0);      	
           confirmar : in  STD_LOGIC;                         	
	   resetar : in std_logic;                           	
	   clk   : in std_logic;                           	
	   tentativasRestantes: out std_logic_vector(2 downto 0);     	
	   display: out STD_LOGIC_VECTOR(4 downto 0);    	
	   resultado : out std_logic_vector(1 downto 0)           	
	  );
end forca;

architecture forcaArquitetura of forca is

signal estados: STD_LOGIC_VECTOR(2 downto 0):= "000";           
signal vidas : integer range 3 downto 0 := 3;                   
signal resultadoParcial : STD_LOGIC_VECTOR(1 downto 0):= "00"; 		
signal displayParcial: STD_LOGIC_VECTOR(4 downto 0):= "00000";            
signal display0,display1,display2,display3,display4, acerto : STD_LOGIC := '0';  

signal senha4: STD_LOGIC_VECTOR (2 downto 0) := "011"; -- 3
signal senha3: STD_LOGIC_VECTOR (2 downto 0) := "111"; -- 7
signal senha2: STD_LOGIC_VECTOR (2 downto 0) := "010"; -- 2
signal senha1: STD_LOGIC_VECTOR (2 downto 0) := "101"; -- 5
signal senha0: STD_LOGIC_VECTOR (2 downto 0) := "110"; -- 6


--Estados* :
-- "000" -> possui as configurações do resetar e realiza a comparação do tentativa com os algarismos da senha. Vai para o estado "001", onde tal os resultados da comparação serão analisados.
-- "001" -> determinação se a pessoa acertou algum algarismo (vai para o estado "010") ou se errou o tentativa (vai para o estado "011")
-- "010" -> o jogador acertou algo: salva os bits acertados no vetor comp, em seguida, vai para o estado "011",  onde ocorre a determinação se o jogo acaba ou não (vitória).
-- "011" -> analisa os bits de comp, verificando se o jogador ganhou ou não o jogo (ocorre quando todos os bits de comparação são 1, ou seja, todos foram acertados). Retorna ao estado "000".
-- "100" -> o jogador errou no tentativa: perda de uma vida, em seguida, vai para o estado "101", onde ocorre a determinação se o jogo acaba ou não (derrota).
-- "101" -> analisa quantas vidas o jogador possui. Caso a quantidade de vidas tenha chegado a 0, o jogador perde o jogo. Retorna ao estado "000".


BEGIN

acerto <= (display0 OR display1 OR display2 OR display3 OR display4);     

process(vidas)
begin
	if (vidas = 3) then            
		tentativasRestantes <= "111";     
	elsif (vidas = 2) then         
		tentativasRestantes <= "011";     
	elsif (vidas = 1) then         
		tentativasRestantes <= "001";     
	elsif (vidas = 0) then
		tentativasRestantes <= "000";
	end if;
end process;

process(clk)
begin
	if(rising_edge(clk)) then
		case estados is
			when "000" =>         			
				if (resetar = '1') then 		
					vidas <= 3;          	     
					displayParcial <= "00000";             
					display0 <= '0';		     
					display1 <= '0';
					display2 <= '0';
					display3 <= '0';
					display4 <= '0';
					estados <= "000";
					resultadoParcial <= "00";
				elsif (confirmar = '1' AND vidas > 0) then             
					if (tentativa = senha0) then                   
						display0 <= '1';			   
					end if;					   
					if (tentativa = senha1) then		   
						display1 <= '1';			   
					end if;
					if (tentativa = senha2) then
						display2 <= '1';
					end if;
					if (tentativa = senha3) then
						display3 <= '1';
					end if;
					if (tentativa = senha4) then
						display4 <= '1';
					end if;
					estados <= "001";
				end if;
				
			when "001" => 
				if (acerto = '1') then
					estados <= "010"; 
				else
					estados <= "100"; 
				end if;
				
			when "010" =>                           
				displayParcial(0) <= display0 or displayParcial(0);    
				displayParcial(1) <= display1 or displayParcial(1);	
				displayParcial(2) <= display2 or displayParcial(2);	
				displayParcial(3) <= display3 or displayParcial(3);
				displayParcial(4) <= display4 or displayParcial(4);
				estados <= "011";
				
			when "011" => 
					display0 <= '0';
					display1 <= '0';			
					display2 <= '0';			
					display3 <= '0';
					display4 <= '0';
				if (displayParcial(4 downto 0) = "11111") then    
					resultadoParcial(1) <= '1'; 
					estados <= "000";
				else
					estados <= "000";
				end if;	
				
			when "100" => 
				vidas <= vidas - 1;
				estados <= "101";
				
			when "101" => 
				if (vidas = 0) then	 
					resultadoParcial(0) <= '1';
					estados <= "000";
				else
					estados <= "000";
				end if;	
				
			when others =>
		end case;
	end if;
end process;

display <= displayParcial;	
resultado <= resultadoParcial;		
					
END forcaArquitetura;