library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder is
--    implementing the input and output
  Port (
  a : in std_logic;
  b : in std_logic;
  cin : in std_logic;
  s : out std_logic;
  carry : out std_logic );
end fulladder;

architecture Behavioral of fulladder is

begin
--    implementing the logic of Full adder
    s <= (a xor b) xor cin ;
    carry <= ((a xor b) and cin) or (a and b);
end Behavioral;
