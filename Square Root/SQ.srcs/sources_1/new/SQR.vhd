library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SQR is
  Port ( 
  A : in STD_LOGIC_VECTOR(11 downto 0) ;
  q : out STD_LOGIC_VECTOR (5 downto 0);
  r : out STD_LOGIC_VECTOR (7 downto 0)
 );
end SQR;

architecture Behavioral of SQR is

Component X is
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
end Component;

Component Y is
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
end Component;

signal A1 : STD_LOGIC_VECTOR (14 downto 0);
signal R1 : STD_LOGIC_VECTOR (14 downto 0);
signal temp : STD_LOGIC_VECTOR(1 downto 0);
signal cout: STD_LOGIC_VECTOR(11 downto 0);
signal DO : STD_LOGIC_VECTOR(11 downto 0);
signal PO : STD_LOGIC_VECTOR(5 downto 0);
signal S2 : STD_LOGIC_VECTOR(5 downto 0);
signal S1 : STD_LOGIC_VECTOR(2 downto 0);
signal q1 : STD_LOGIC_VECTOR(5 downto 0);

begin
A1 (0)<= '1';
A1(1) <= A(11);
A1(2) <= A(10);
A1(3) <= A(9);
A1(4) <= A(8);
X_1 : X port map(a1(4 downto 0), '0', '1', q1(0) , q1(0) , q1(1) ,DO(0),DO(1),R1(4 downto 0) );

A1(5)<= R1(4);
A1(6) <= A(7);
A1(7) <= A(6);
A1(8) <= A(5);
A1(9) <= A(4);
X_2 : X port map(A1(9 downto 5) , PO(0) , PO(0) , PO(1) , cout(0) , cout(1) , DO(2) , DO(3) , R1(9 downto 5));
Y_1 : Y port map (q1(1), q1(2),DO(0), DO(1),R1(3 downto 2),R1(5), cout(0), cout(1),PO(0), PO(1),DO(4), DO(5),q1(2), q1(3) , S2(1 downto 0), S1(0));

A1(10)<= R1(9);
A1(11) <= A(3);
A1(12) <= A(2);
A1(13) <= A(1);
A1(14) <= A(0);
temp(0)<= S2(1);
temp(1)<= R1(6);
X_3 : X port map (A1(14 downto 10) , PO(2) , PO(2) , PO(3) , cout(2) , cout(3) , DO(6) , DO(7) , R1(14 downto 10));
Y_2 : Y port map (PO(4) , PO(5) , DO(2), DO(3),R1(8 downto 7), R1(10) , cout(2) , cout(3), PO(2) , PO(3), DO(8), DO(9), cout(4) , cout(5) , S2(3 downto 2) , S1(1));
Y_3 : Y port map (q1(3), q1(4), DO(4) , DO(5) , temp , S1(1) , cout(4) , cout(5) , PO(4) , PO(5) , DO(10) , DO(11) ,q1(4) , q1(5) ,S2(5 downto 4) , S1(2));

q(5)<= q1(0);
q(4)<= q1(1);
q(3)<= q1(2);
q(2)<= q1(3);
q(1)<= q1(4);
q(0)<= q1(5);

R(7)<= S2(5);
R(6)<= S2(4);
R(5)<= S2(3);
R(4)<= S2(2);
R(3)<= R1(11);
R(2)<= R1(12);
R(1)<= R1(13);
R(0)<= R1(14);

end Behavioral;
