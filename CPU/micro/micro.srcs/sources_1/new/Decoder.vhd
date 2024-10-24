----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2022 10:00:22 AM
-- Design Name: 
-- Module Name: Decoder - GateDesign
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
  Port ( 
        A7:in std_logic;
        A6:in std_logic;
        A5:in std_logic;
        en_ROM:out std_logic;
        en_RAM:out std_logic;
        en_UART:out std_logic;
        en_TIMER:out std_logic;
        en_SENSOR:out std_logic;
        en_CORDIC:out std_logic      
        );
end Decoder;

architecture GateDesign of Decoder is
signal x:std_logic_vector(2 downto 0);

begin
x<=A7 & A6 & A5;
    process(x)
        begin
        en_ROM<='0';
        en_RAM<='0';
        en_UART<='0';
        en_TIMER<='0';
        en_CORDIC<='0';
        en_SENSOR<='0';
        case x is
            when "000" | "001"=>
                en_ROM<='1';
            when "010" | "011"=>
                en_RAM<='1';
            when "100"=>
                en_UART<='1';
            when "101"=>
                en_TIMER<='1';
            when "110"=>
                en_CORDIC<='1';
            when "111"=>
                en_SENSOR<='1';
            when others=>
        
        end case;
    end process;

end GateDesign;
