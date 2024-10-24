----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2022 10:08:50 AM
-- Design Name: 
-- Module Name: TopModule - Structural
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

entity TopModule is
  Port (
        wr_status: out std_logic ;
        clk,reset:in std_logic
        );
end TopModule;

architecture Structural of TopModule is
signal DataBus:std_logic_vector(15 downto 0);
signal AddrBus:std_logic_vector (7 downto 0);
signal wr_rd:std_logic; 
signal enRom,enRam,enUART,enTIMER,enSENSOR,enCORDIC:std_logic;
begin
    wr_status<=wr_rd;
    cpu:entity work.CPU(Structural)
        port map(
                AB=>AddrBus,
                DB=>DataBus,
                WR_RD=>wr_rd,
                clk=>clk,
                reset=>reset
        );
    decoder:entity work.Decoder(GateDesign)
        port map(
            A7=>AddrBus(7),
            A6=>AddrBus(6),
            A5=>AddrBus(5),
            en_ROM=>enRom,
            en_RAM=>enRam,
            en_UART=>enUART,
            en_TIMER=>enTIMER,
            en_SENSOR=>enSENSOR,
            en_CORDIC=>enCORDIC      
        ); 
    
    rom: entity work.ROM(Behavioral)
        port map(
                A=>AddrBus(5 downto 0),
                D=>DataBus,
                RD=>wr_rd,
                en_ROM=>enRom
                );
    ram:entity work.RAM(Behavioral)
        port map(
                A=>AddrBus(5 downto 0),
                D=>DataBus,
                WR_RD=>wr_rd,
                en_RAM=>enRam,
                clk=>clk
                );
    CORDIC: entity work.CORDIC(Structural)
        port map(
                clk=>clk,
                reset=>reset,
                A=>AddrBus(4 downto 0),
                D=>DataBus,
                WR_RD=>wr_rd,
--        end_thick:out std_logic;
                en_CORDIC=>enCordic
        
                );
end Structural;
