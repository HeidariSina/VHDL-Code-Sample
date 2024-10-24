----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2022 06:03:42 PM
-- Design Name: 
-- Module Name: RAM_tb - Behavioral
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

entity RAM_tb is
--  Port ( );
end RAM_tb;

architecture Behavioral of RAM_tb is
    signal clk,wr_rd,en:std_logic;
    signal addrBus:std_logic_vector (5 downto 0);
    signal dataBus: std_logic_vector (15 downto 0);
    constant T : time :=20 ns;
    
begin
    ram_instance: entity work.RAM(Behavioral)
                    port map(
                            A=>addrBus,
                            D=>dataBus,
                            clk=>clk,
                            WR_RD=>wr_rd,
                            en_RAM=>en
                            );
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
--        addrBus<="000000";
--        en<='1';
--        wr_rd<='0';
--        wait for 3*T;
--        en<='0';
--        wait for 3*T;
        addrBus<="000011";
        dataBus<="1111000000111001";
        en<='1';
        wr_rd<='1';
        wait for 3*T;
        dataBus<=(others=>'Z'); 
        addrBus<="000000";
        en<='1';
        wr_rd<='0';
        wait for 3*T;
        en<='0';
        wait for 3*T;
        addrBus<="000011";
        en<='1';
        wr_rd<='0';
        wait for 3*T;
        en<='0';
        
        assert false
                report "Simulation completed"
                severity failure;
     end process;
     
end Behavioral;
