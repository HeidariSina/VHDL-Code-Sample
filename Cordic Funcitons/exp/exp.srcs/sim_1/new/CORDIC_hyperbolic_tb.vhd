----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2022 08:35:28 PM
-- Design Name: 
-- Module Name: CORDIC_hyperbolic_tb - Behavioral
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

entity CORDIC_hyperbolic_tb is
--  Port ( );
end CORDIC_hyperbolic_tb;

architecture Behavioral of CORDIC_hyperbolic_tb is
signal x0,y0,z0: std_logic_vector(11 downto 0);
signal xn,yn,zn: std_logic_vector(11 downto 0);
signal start,clk,end_thick,reset: std_logic;
signal T:time:=20 ns;
begin

    cordic_core: entity work.CORDIC_Hyperbolic_rotationmode(sequential)
                    port map(
                              x0=>x0,
                              y0=>y0,
                              z0=>z0,
                              xn=>xn,
                              yn=>yn,
                              zn=>zn,
                              start=>start,
                              end_thick=>end_thick,
                              reset=>reset,
                              clk=>clk);
    process 
        -- 20 ns clock generator
        begin
            clk<='0';
            wait for T/2;
            clk<='1';
            wait for T/2;
    end process;
    
    reset<='1' ,'0' after T/2;
    process
    begin  --exp(0)
        x0<="000100000000";-- 1
        y0<="000100000000";-- 1
        z0<="000000000000"; -- 0
        wait for 2*T;
        wait until  falling_edge(clk);
        start<='1';
        wait for 5*T;
        start<='0';
        wait for 50*T;
        assert false
                report "Simulation completed"
                severity failure;
        
    end process;
end Behavioral;
