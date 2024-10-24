----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2022 10:25:40 AM
-- Design Name: 
-- Module Name: TopModule_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule_tb is
--  Port ( );
end TopModule_tb;

architecture Behavioral of TopModule_tb is
    signal clk,reset:std_logic;
    constant T : time :=20 ns;
    
begin
    
    topModule:entity work.TopModule(Structural)
                port map(
                        clk=>clk,
                        reset=>reset
                        );
     reset<='1' ,'0' after T/2;
     process 
        -- 20 ns clock generator
        begin
            clk<='0';
            wait for T/2;
            clk<='1';
            wait for T/2;
     end process;
                           
    process
    begin   
        wait for 20*T;
        assert false
                report "Simulation completed"
                severity failure;    
    end process;

end Behavioral;
