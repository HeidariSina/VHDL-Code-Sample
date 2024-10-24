----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2022 09:27:48 AM
-- Design Name: 
-- Module Name: CORDIC_tb - Behavioral
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

entity CORDIC_tb is
--  Port ( );
end CORDIC_tb;

architecture Behavioral of CORDIC_tb is
    signal reset,clk:std_logic;
    signal AddrBus:std_logic_vector(4 downto 0);
    signal DataBus: std_logic_vector(15 downto 0);
    signal WR_RD: std_logic;
    signal en: std_logic;
   
--    signal end_thick:std_logic;
    constant T : time :=20 ns;
begin
    
    CORDIC_instance: entity work.CORDIC(Structural)
            port map(
                    A=>AddrBus,
                    D=>dataBus,
                    WR_RD=>wr_rd,
                    en_CORDIC=>en,
                    clk=>clk,
--                    end_thick=>end_thick,
                    reset=>reset
            );
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
    begin
    ------------------------------
        ------exp(1)
        en<='1';
        wr_rd<='1';
        AddrBus<="00000";
        DataBus<="0001000000000000";
        wait for 2*T;
        en<='1';
        wr_rd<='1';
        AddrBus<="00010";
        DataBus<="0000000000010010";
        wait for 2*T;
        DataBus<=(others=>'Z');
        wr_rd<='0';
        AddrBus<="00011";
        
        wait for 2*T;
        
        wait for 5*T;
        AddrBus<="00001";
        
        wait for 60*T;
        ----------------------------
        --ln(0.5)
        en<='1';
        wr_rd<='1';
        AddrBus<="00000";
        DataBus<="0000100000000000";
        wait for 2*T;
        en<='1';
        wr_rd<='1';
        AddrBus<="00010";
        DataBus<="0000000000010100";
        wait for 2*T;
        DataBus<=(others=>'Z');
        wr_rd<='0';
        AddrBus<="00011";
        
        wait for 2*T;
        
        wait for 5*T;
        AddrBus<="00001";
        
        wait for 60*T;
        
        ----------------------------
        --sinh(0.125)
        en<='1';
        wr_rd<='1';
        AddrBus<="00000";
        DataBus<="0000001000000000";
        wait for 2*T;
        en<='1';
        wr_rd<='1';
        AddrBus<="00010";
        DataBus<="0000000000011000";
        wait for 2*T;
        DataBus<=(others=>'Z');
        wr_rd<='0';
        AddrBus<="00011";
        
        wait for 2*T;
        
        wait for 5*T;
        AddrBus<="00001";
        
        wait for 60*T;
        ----------------------------
        --sqrt(0.25)
        en<='1';
        wr_rd<='1';
        AddrBus<="00000";
        DataBus<="0000010000000000";
        wait for 2*T;
        en<='1';
        wr_rd<='1';
        AddrBus<="00010";
        DataBus<="0000000000010001";
        wait for 2*T;
        DataBus<=(others=>'Z');
        wr_rd<='0';
        AddrBus<="00011";
        
        wait for 2*T;
        
        wait for 5*T;
        AddrBus<="00001";
        
        wait for 60*T;
        
    
        assert false
                report "Simulation completed"
                severity failure;
    end process;
    
end Behavioral;
