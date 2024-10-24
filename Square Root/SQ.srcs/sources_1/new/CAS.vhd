library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CAS is
  Port (   
  x : in STD_LOGIC;
  p : in STD_LOGIC ;
  d : in STD_LOGIC ;
  cin : in STD_LOGIC ;
  R : out STD_LOGIC ;
  cout : out STD_LOGIC
   );
end CAS;

architecture Behavioral of CAS is
component fulladder is
    --    implementing the input and output
      Port (
     a : in std_logic;
     b : in std_logic;
     cin : in std_logic;
     s : out std_logic;
      carry : out std_logic );
end component;
    
signal DP : STD_LOGIC;

begin
    DP <= p xor d ;
    fu1 : fulladder port map (x , cin , DP , R ,cout);

end Behavioral;
