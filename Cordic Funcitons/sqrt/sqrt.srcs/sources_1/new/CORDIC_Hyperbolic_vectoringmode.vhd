----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2022 06:46:42 PM
-- Design Name: 
-- Module Name: CORDIC_Hyperbolic_vectoringmode - Sequential
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

library  fixed_extensions_pkg;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use fixed_extensions_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CORDIC_Hyperbolic_vectoringmode is
  Port ( 
            x0 : IN std_logic_vector(11 downto 0);
            y0 : IN std_logic_vector(11 downto 0);
            z0 : IN std_logic_vector(11 downto 0);
            start: IN std_logic;
            clk: IN std_logic;
            reset: IN std_logic;
            
            xn : OUT std_logic_vector(11 downto 0);
            yn : OUT std_logic_vector(11 downto 0);
            zn : OUT std_logic_vector(11 downto 0);
            end_thick: OUT std_logic
            );
end CORDIC_Hyperbolic_vectoringmode;

architecture Sequential of CORDIC_Hyperbolic_vectoringmode is
    type rom_type is array(1 to 8) of signed(11 downto 0); --- signed
    signal theta : rom_type:=(
    "000001000110", --0.5493   radian
    "000000100001", --0.2554
    "000000010000", --0.1257
    "000000001000", --0.06258
    "000000001000", --0.06258  -- repeated for convergence
    "000000000100", --0.03126
    "000000000010", --0.01563
    "000000000001"  --0.007813
    );
    signal kn: unsigned (11 downto 0) := "000010011010"; --approximatly 1.2050873211229571
    signal x_next,y_next,z_next,x_reg,y_reg,z_reg: signed (11 downto 0);
    signal x_shift_next,y_shift_next,x_shift_reg,y_shift_reg: signed (11 downto 0);
    
    type state_type is (idle,read,do_shift,do_add,finish);
    signal state_reg,state_next: state_type;
    signal count_reg,count_next,i_reg,i_next: integer := 0;
begin
    --state register process
    process(clk,reset)
    begin
        if (reset='1') then
            count_reg<=0;
            state_reg<=idle;
            x_reg<=(others=>'0');
            y_reg<=(others=>'0');
            z_reg<=(others=>'0');
            x_shift_reg<=(others=>'0');
            y_shift_reg<=(others=>'0');
            i_reg<=1;
        elsif(clk' event and clk='1') then
            state_reg<=state_next;
            x_reg<=x_next;
            y_reg<=y_next;
            z_reg<=z_next;
            x_shift_reg<=x_shift_next;
            y_shift_reg<=y_shift_next;
            count_reg<=count_next;
            i_reg<=i_next;
        end if;     
    end process; 
    
    --next state logic
    process(state_reg,start,x_reg,y_reg,z_reg,x_shift_reg,y_shift_reg,count_reg,x0,y0,z0,i_reg)
    begin
        state_next<=state_reg;
        x_next<=x_reg;
        y_next<=y_reg;
        z_next<=z_reg;
        x_shift_next<=x_shift_reg;
        y_shift_next<=y_shift_reg;
        end_thick<='0';
        count_next<=count_reg;
        
        case state_reg is
            when idle=>
                i_next<=1;
                count_next<=0;
                x_next<=(others=>'0');
                y_next<=(others=>'0');
                z_next<=(others=>'0');
                x_shift_next<=(others=>'0');
                y_shift_next<=(others=>'0');
                if(start='1') then
                    state_next<=read;
                end if;
            
            when read=>
                x_next<=SIGNED(x0);
                y_next<=SIGNED(y0);
                z_next<=SIGNED(z0);
                state_next<=do_shift;
            
            when do_shift=>
                i_next<=i_reg+1;
                if(i_reg=1)then
                    if(x_reg>=0) then
                        x_shift_next<= '0' & x_reg(11 downto 1);
                    else
                        x_shift_next<= '1' & x_reg(11 downto 1);
                    end if;
                    if(y_reg>=0) then
                        y_shift_next<= '0' & y_reg(11 downto 1);
                    else
                        y_shift_next<= '1' & y_reg(11 downto 1);
                    end if;
                    state_next<=do_shift;
                else
                    if(i_reg<= count_reg+1) then
                        if(x_reg>=0) then
                            x_shift_next<= '0' & x_shift_reg(11 downto 1);
                        else
                            x_shift_next<= '1' & x_shift_reg(11 downto 1);
                        end if;
                        if(y_reg>=0) then
                            y_shift_next<= '0' & y_shift_reg(11 downto 1);
                        else
                            y_shift_next<= '1' & y_shift_reg(11 downto 1);
                        end if;
                        state_next<=do_shift;
                    else
                        i_next<=1;
                        state_next<=do_add;
                        count_next<=count_reg+1;
            
                        end if;
                 end if;
                
            when do_add=>
                if ((x_reg>=0 and y_reg>=0) or (x_reg<0 and y_reg<0)) then
                    x_next<=x_reg-y_shift_reg;
                    y_next<=y_reg-x_shift_reg;
                    z_next<=z_reg+theta(count_reg);
                else
                    x_next<=x_reg+y_shift_reg;
                    y_next<=y_reg+x_shift_reg;
                    z_next<=z_reg-theta(count_reg);
                end if;
                
                if(count_reg=integer(8)) then
                    state_next<=finish;    
                else
                    state_next<=do_shift;
                end if;
            
            when finish=>
                end_thick<='1'; --Kn is not inserted!!!!!
                state_next<=idle;        
                
        end case;
    
    end process;
    
    xn<=std_logic_vector(x_reg);
    yn<=std_logic_vector(y_reg);
    zn<=std_logic_vector(z_reg);
                
end Sequential;
