library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity X is
   Port ( 
  A : in STD_LOGIC_VECTOR (4 downto 0);
  DI1 : in STD_LOGIC;
  PI1 : in STD_LOGIC;
  PI2 : in STD_LOGIC;
  CO1 : out STD_LOGIC;
  CO2 : out STD_LOGIC;
  DO1 : out STD_LOGIC;
  DO2 : out STD_LOGIC;
  R : out STD_LOGIC_VECTOR (4 downto 0)
   );
end X;

architecture Behavioral of X is
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
signal cout : STD_LOGIC_VECTOR (4 downto 0);
signal rhelp : STD_LOGIC_VECTOR (1 downto 0);
signal pinot : STD_LOGIC_VECTOR (1 downto 0);
begin
 DO1 <= DI1;
 DO2 <=PI2;
 
 pinot(0) <= not pi1;
 pinot(1) <= not pi2;
 
 CAS_C : CAS port map (a(2) , PI1 , '1' , PI1 , rhelp(0) , cout(0));
 CAS_B : CAS port map (a(1) , pI1 , pinot(0) , cout(0) , rhelp(1) , cout(1));
 CAS_A : CAS port map (a(0) , PI1 , PI1 , cout(1) , R(0) , CO1);
 
 CAS_G : CAS port map (a(4) , PI2 , '1' , PI2 , R(4) , cout(2));
 CAS_F : CAS port map (a(3) , PI2 , PInot(1) , cout(2) , R(3) , cout(3));
 CAS_E : CAS port map (rhelp(0) , PI2 , PI2 , cout(3) ,  R(2) , cout(4));
 CAS_D : CAS port map (rhelp(1) , PI2 , DI1 , cout(4) ,  R(1) , CO2);


end Behavioral;
