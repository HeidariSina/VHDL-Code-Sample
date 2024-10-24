library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;

architecture Behavioral of testbench is

component SQR is
  Port ( 
  A : in STD_LOGIC_VECTOR(11 downto 0) ;
  q : out STD_LOGIC_VECTOR (5 downto 0);
  r : out STD_LOGIC_VECTOR (7 downto 0)
 );
 end component;

    --Signals
  signal a : std_logic_vector(11 downto 0) := (others => '0');
  signal q : std_logic_vector(5 downto 0):= (others => '0');
  signal r : std_logic_vector(7 downto 0):= (others => '0');
    
begin

    --process 
process
  begin
  
  wait for 100ns;
  A <= ("000000001111");
  wait for 100ns;
  
end process;
SQR1 : SQR port map(A ,q ,r);
end Behavioral;
