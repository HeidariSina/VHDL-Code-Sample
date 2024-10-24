----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2022 07:46:58 PM
-- Design Name: 
-- Module Name: CORDIC - Behavioral
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

entity CORDIC is
  Port (
        clk,reset:in std_logic;
        A:in std_logic_vector(4 downto 0);
        D:inout std_logic_vector(15 downto 0);
        WR_RD:in std_logic;
--        end_thick:out std_logic;
        en_CORDIC:in std_logic
        
         );
end CORDIC;

architecture Structural of CORDIC is

signal DataIn,ResultOut,Config,Status:std_logic_vector(15 downto 0):=(others=>'0');
signal data_out: std_logic_vector (15 downto 0);

signal x0_sqrt,y0_sqrt,z0_sqrt,xn_sqrt,yn_sqrt,zn_sqrt: std_logic_vector (15 downto 0);
signal start_sqrt,end_thick_sqrt,busy_sqrt: std_logic;

signal x0_ln,y0_ln,z0_ln,xn_ln,yn_ln,zn_ln: std_logic_vector (15 downto 0);
signal start_ln,end_thick_ln,busy_ln: std_logic;

signal x0_exp,y0_exp,z0_exp,xn_exp,yn_exp,zn_exp: std_logic_vector (15 downto 0);
signal start_exp,end_thick_exp,busy_exp: std_logic;

signal x0_sinh,y0_sinh,z0_sinh,xn_sinh,yn_sinh,zn_sinh: std_logic_vector (15 downto 0);
signal start_sinh,end_thick_sinh,busy_sinh: std_logic;

signal kn: signed (15 downto 0) := "0001001101010000";
signal sqrt_out:std_logic_vector(31 downto 0);

type StartStates is (startOn,startOff);
signal isStartedFlag:std_logic ;
signal state_start_reg,state_start_next: StartStates:= startOff;
begin


    --read from data bus
    --when en=1,wr_rd=1
    process(A,D,WR_RD,en_CORDIC)
    begin
        if(en_CORDIC='1' and WR_RD='1') then
            case A is
                when "00000"=>
                    DataIn<=D;
                when "00010"=>
                    Config<=D;
                when others=>
            end case;
        end if;
    end process;
    
    --Tri state buffer
    D<= data_out when (en_CORDIC='1' and wr_rd='0') else (others=>'Z');
    
    --write on data bus
    --when en=1, wr_rd=0
    process(A,WR_RD,en_CORDIC,ResultOut,Status)
    begin
        if(en_CORDIC='1' and WR_RD='0') then
            case A is
                when "00001"=>
                    data_out<=ResultOut;
                when "00011"=>
                    data_out<=Status;
                when others=>
            end case;
        end if;
    end process;
    
    sqrt:entity work.CORDIC_Hyperbolic_vectoringmode(Sequential)
            port map(
                    x0=>x0_sqrt,
                    y0=>y0_sqrt,
                    z0=>z0_sqrt,
                    start=>start_sqrt,
                    clk=>clk,
                    reset=>reset,
            
                    xn =>xn_sqrt,
                    yn =>yn_sqrt,
                    zn =>zn_sqrt,
                    end_thick=>end_thick_sqrt,
                    busy=>busy_sqrt
            );
     
    Ln:entity work.CORDIC_Hyperbolic_vectoringmode(Sequential)
            port map(
                    x0=>x0_ln,
                    y0=>y0_ln,
                    z0=>z0_ln,
                    start=>start_ln,
                    clk=>clk,
                    reset=>reset,
            
                    xn =>xn_ln,
                    yn =>yn_ln,
                    zn =>zn_ln,
                    end_thick=>end_thick_ln,
                    busy=>busy_ln
            );
        
    exp:entity work.CORDIC_Hyperbolic_rotationmode(Sequential)
            port map(
                    x0=>x0_exp,
                    y0=>y0_exp,
                    z0=>z0_exp,
                    start=>start_exp,
                    clk=>clk,
                    reset=>reset,
            
                    xn =>xn_exp,
                    yn =>yn_exp,
                    zn =>zn_exp,
                    end_thick=>end_thick_exp,
                    busy=>busy_exp
            );
            
    sinh:entity work.CORDIC_Hyperbolic_rotationmode(Sequential)
            port map(
                    x0=>x0_sinh,
                    y0=>y0_sinh,
                    z0=>z0_sinh,
                    start=>start_sinh,
                    clk=>clk,
                    reset=>reset,
            
                    xn =>xn_sinh,
                    yn =>yn_sinh,
                    zn =>zn_sinh,
                    end_thick=>end_thick_sinh,
                    busy=>busy_sinh
            );
    
    x0_sqrt<=std_logic_vector(signed(Datain)+"0000010000000000");--dataIn+0.25
    y0_sqrt<=std_logic_vector(signed(Datain)-"0000010000000000");--dataIn-0.25
    z0_sqrt<=(others=>'0');
    
    x0_ln<=std_logic_vector(unsigned(Datain)+"0001000000000000");--dataIn+1
    y0_ln<=std_logic_vector(unsigned(Datain)-"0001000000000000");--dataIn-1
    z0_ln<=(others=>'0');
    
    x0_exp<=std_logic_vector( kn);-- kn=1/k*
    y0_exp<=std_logic_vector( kn);-- kn=1/k*
    z0_exp<=Datain;
    
    x0_sinh<=std_logic_vector( kn);-- kn=1/k*
--    x0_sinh<="0001000000000000";-- 1
    y0_sinh<="0000000000000000";-- 0
    z0_sinh<=Datain;
           
    status(0)<= busy_exp or busy_sinh or busy_ln or busy_sqrt;
--    end_thick<=end_thick_exp or end_thick_ln or end_thick_sqrt or end_thick_sinh;
    process(clk,reset)
    begin
        if(reset='1') then
            state_start_reg<=startOff;
        elsif(clk'event and clk='1') then
            state_start_reg<=state_start_next;
        end if;
    end process;
    
    process (state_start_reg,Config)
    begin
        case state_start_reg is
            when startOff=>
                if((busy_sqrt or busy_exp or busy_ln or busy_sinh)='0') then
                case config(4 downto 0) is
                    when "10001"=>
                        start_sqrt<='1';
                        state_start_next<=startOn;
                    when "10010"=>
                        start_exp<='1';
                        state_start_next<=startOn;
                    when "10100"=>
                        start_ln<='1';
                        state_start_next<=startOn;
                    when "11000"=>
                        start_sinh<='1';
                        state_start_next<=startOn;
                    when others=>
                        start_sqrt<='0';
                        start_ln<='0';
                        start_exp<='0';
                        start_sinh<='0';
                        state_start_next<=startOff;
                end case;
                end if;
            when startOn=>
                start_sqrt<='0';
                start_ln<='0';
                start_exp<='0';
                start_sinh<='0';
                 state_start_next<=startOff;
                
        end case;    
    end process;
    sqrt_out<=std_logic_vector(kn*signed(xn_sqrt));
    with  status(0) & config(3 downto 0) select
            resultOut<=     sqrt_out(27 downto 12)                                 when "10001",
                            yn_exp                                  when "10010",
                            zn_ln(14 downto 0) &'0'                when "10100",
                            yn_sinh                                 when "11000",
                            resultOut                           when others;         
    
end Structural;
