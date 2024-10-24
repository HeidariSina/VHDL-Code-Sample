----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2022 11:12:14 AM
-- Design Name: 
-- Module Name: ROM_tb - Behavioral
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

entity ROM_tb is
--  Port ( );
end ROM_tb;

architecture Behavioral of ROM_tb is
signal addrBus:std_logic_vector (5 downto 0);
signal dataBus:std_logic_vector (15 downto 0);
signal en,wr_rd:std_logic;

begin
    rom_instance:entity work.ROM(Behavioral)
                    port map(
                            A=>addrBus,
                            D=>dataBus,
                            en_Rom=>en,
                            RD=>wr_rd
                            );
    process 
    begin
        addrBus<="000010";
        en<='1';
        wr_rd<='0';
        wait for 30 ns;
        en<='0';
        wait for 30 ns;
        assert false
                report "Simulation completed"
                severity failure;
        
    end process;
end Behavioral;
