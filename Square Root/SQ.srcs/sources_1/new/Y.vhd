library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Y is
  Port ( 
  PI1 : in STD_LOGIC;
  PI2 : in STD_LOGIC;
  DI1 : in STD_LOGIC;
  DI2 : in STD_LOGIC;
  A1 : in STD_LOGIC_VECTOR (1 downto 0);
  A2 : in STD_LOGIC ;
  CI1 : in STD_LOGIC;
  CI2 : in STD_LOGIC;
  PO1 : out STD_LOGIC;
  PO2 : out STD_LOGIC;
  DO1 : out STD_LOGIC;
  DO2 : out STD_LOGIC;
  CO1 : out STD_LOGIC;
  CO2 : out STD_LOGIC;
  S2 : out STD_LOGIC_VECTOR (1 downto 0);
  S1 : out STD_LOGIC 
  );
end Y;

architecture Behavioral of Y is
component CAS is
    Port (   
  x : in STD_LOGIC;
  p : in STD_LOGIC ;
  d : in STD_LOGIC ;
  cin : in STD_LOGIC ;
  R : out STD_LOGIC ;
  cout : out STD_LOGIC
   );
end component;
signal carry : STD_LOGIC_VECTOR (1 downto 0) ;
signal Rhelp : STD_LOGIC;

begin
 DO1<= DI1;
 DO2 <= DI2;
 PO1 <= PI1;
 PO2 <= PI2;
 
 CAS_I : CAS port map (A1(1) , PI1 , DI2 , CI1 , Rhelp ,carry(0));
 CAS_H : CAS port map (A1(0) , PI1 , DI1 , carry(0) , S1 , CO1);
 CAS_K : CAS port map (A2 , PI2 , DI2 , CI2 , S2(1) ,carry(1));
 CAS_J : CAS port map (Rhelp , PI2 , DI1 , carry(1) , S2(0) ,CO2);

end Behavioral;