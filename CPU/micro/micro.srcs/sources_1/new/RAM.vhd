----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 10:53:07 AM
-- Design Name: 
-- Module Name: RAM - Behavioral
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

entity RAM is
  Port ( 
        A: in std_logic_vector(5 downto 0);
        D: inout std_logic_vector(15 downto 0);
        WR_RD: in std_logic;
        en_RAM: in std_logic;
        clk: in std_logic);
end RAM;

architecture Behavioral of RAM is
    constant ADDR_WIDTH:integer :=6;
    constant DATA_WIDTH:integer :=16;
    
    signal data_out:std_logic_vector (DATA_WIDTH-1 downto 0);
    type ram_type is array(0 to 2**ADDR_WIDTH-1)
        of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal ram: ram_type:=(  "1111111111010101",
                             "0000000000000111",
                             "0000000000000011",
                             "0001000000000000",
                            others=>(others=>'0'));
begin
    
    ----it has one clock delay :((((((((
--    process(clk,en_RAM,WR_RD)
--    begin
--    if(en_RAM='1') then
--        if(clk'event and clk='1') then 
--            if(WR_RD='1') then
--                ram(TO_INTEGER(unsigned(A)))<=D;
--            else
--                D<=ram(TO_INTEGER(unsigned(A)));
--            end if; 
             
--        end if;
--    else
--        D<=(others=>'Z');
--    end if;
--    end process;





    --Memory write block
    --when en=1 , wr_rd=1
    process(A,D,en_RAM,WR_RD)
    begin
        if(en_RAM='1' and  WR_RD='1') then
            ram(TO_INTEGER(unsigned(A)))<=D;
        end if;   
    end process;
    
    --Tri-state Buffer control
    D<= data_out when (en_RAM='1' and wr_rd='0') else (others=>'Z');
    
    --Memmory read block
    --when en=1 , wr_rd=0
    process(A,D,en_RAM,WR_RD,ram)
    begin
        if(en_RAM='1' and  WR_RD='0') then
            data_out<=ram(TO_INTEGER(unsigned(A)));
        else
            data_out<=(others=>'0');
        end if;   
    end process;
    
end Behavioral;
