----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2022 10:22:11 AM
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
  Port ( 
        AB:out std_logic_vector(7 downto 0);
        DB:inout std_logic_vector(15 downto 0);
        WR_RD:out std_logic;
        clk:in std_logic;
        reset:in std_logic
        );
end CPU;

architecture Structural of CPU is
signal WR_status:std_logic ;
signal MAR_reg: std_logic_vector(7 downto 0);
signal MDR_in_reg,MDR_out_reg: std_logic_vector(15 downto 0):=(others=>'0');
signal PC_reg: unsigned (5 downto 0);
signal AC_reg: signed (15 downto 0);
signal IR_reg: std_logic_vector(15 downto 0);
type state_type is (fetch,reset_pc,decode,exe_add,exe_load,exe_store,exe_wait,exe_jump,exe_minus,exe_TWO_COMPL,
cordic_set_dataIn,cordic_sqrt , cordic_exp , cordic_ln , cordic_sinh , cordic_read_result,wait_to_zero,wait_to_zero2 , cordic_read_status ,
uart_set_tx , uart_get_rx , uart_set_br , uart_read_status , 
timer_read_count , timer_start_up , timer_start_down , timer_stop_up , timer_stop_down , timer_sPeriod , timer_sDC , 
io_output , io_input , io_temp , io_adc,hult
);
signal state:state_type;
begin
    AB<=MAR_reg;
    WR_RD<=WR_status;
--    DB<=MDR_out_reg;
--    MDR_in_reg<=DB;
--    MDR_out_reg<=std_logic_vector(AC_reg);----???
    process(clk,reset)
    begin  
        if(reset='1')then
            state<=reset_pc;
        elsif(clk'event and clk='1') then
            case state is
                when reset_pc=>
                    PC_reg<=(others=>'0');
                    AC_reg<=(others=>'0');
                    state<=fetch;
                when fetch=>
                    IR_reg<=MDR_in_reg;
--                    IR_reg<=DB;
                    PC_reg<=PC_reg+1;
                    state<=decode;
               when decode=>
                    case IR_reg(15 downto 8) is
                        when "00000000"=>
                            state<=exe_add;
                        when "00000001"=>
                            state<=exe_store;
                        when "00000010"=>
                            state<=exe_load;
                        when "00000011"=>
                            state<=exe_jump;
                        when "00000100"=>
                            state<=exe_minus;
                        when "00000101"=>
                            state<=exe_two_compl;
                        when "00000110"=>
                            state<=wait_to_zero;
                            
                        
                        when "00010000" =>--cordic
                        	state <= cordic_sqrt;
                        when "00010001" =>
                        	state <= cordic_exp;
                        when "00010010" =>
                        	state <= cordic_ln;
                        when "00010011" =>
                        	state <= cordic_sinh;
                        when "00010100" =>
                        	state <= cordic_read_result;
                        when "00010101" =>
                        	state <= cordic_read_status;
                        when "00010110" =>
                        	state <= cordic_set_datain;
                        
                        
                        when "00100000" =>--uart
                        	state <= uart_set_tx;
                        when "00100001" =>
                        	state <= uart_get_rx;
                        when "00100010" =>
                        	state <= uart_set_br;
                        when "00100011" =>
                        	state <= uart_read_status;
                        
                        when "00110000" =>--timer
                        	state <= timer_read_count ;
                        when "00110001" =>
                        	state <= timer_start_up ;
                        when "00110010" =>
                        	state <= timer_start_down ;
                        when "00110011" =>
                        	state <= timer_stop_up ;
                        when "00110100" =>
                        	state <= timer_stop_down ;
                        when "00110101" =>
                        	state <= timer_sPeriod ;
                        when "00110110" =>
                        	state <= timer_sDC ;
                        
                        when "01000000" =>--io
                        	state <= io_output ;
                        when "01000001" =>
                        	state <= io_input ;
                        when "01000010" =>
                        	state <= io_temp ;
                        when "01000011" =>
                        	state <= io_adc;
                        
                        when "11111111" =>
                            state<=hult;
                        
                        when others =>
                            state<=fetch;
                        
                    end case;
               when exe_add=>
                    AC_reg<=AC_reg+signed(MDR_in_reg);
                    state<=fetch;
               when exe_minus=>
                    AC_reg<=AC_reg-signed(MDR_in_reg);
                    state<=fetch;
               when exe_TWO_COMPL=>
                    AC_reg<=not(AC_reg)+"0000000000000001";
                    state<=fetch;
               
               when exe_store=>
                    state<=exe_wait;--for making one clock delay
                    MDR_out_reg<=std_logic_vector(AC_reg);
               when exe_wait =>
                    state<=fetch;
                    
               when exe_load=>
                    AC_reg<=signed(MDR_in_reg);
                    state<= fetch;
               
               when exe_jump=>
                    PC_reg<=unsigned(IR_reg(5 downto 0));       
                    state<=fetch;
               when wait_to_zero=>
                    AC_reg<=signed(MDR_in_reg);
                    state<= wait_to_zero2;
               when wait_to_zero2=>
                    AC_reg<=AC_reg+1;
                    if(AC_reg="0000000000000000") then
                        state<=fetch;
                    end if;
               ----------------------------------UART
               when uart_set_tx =>
	                state <= exe_wait; ---do we need 1 clk?????
	                MDR_out_reg<=std_logic_vector("0000000" & '1' & AC_reg(7 downto 0));
                
                when uart_get_rx =>
                	state <= fetch; -- AC_reg <= MDR
                    AC_reg<=signed(MDR_in_reg);
                    
                when uart_set_br =>
                	state <= exe_wait; -- MDR <= AC_reg
                    MDR_out_reg<=std_logic_vector("0000000" & AC_reg(8 downto 0));    
                when uart_read_status=>
                	state <= fetch; -- AC_reg <= MDR
                    AC_reg<=signed(MDR_in_reg);
                    
                when timer_read_count =>
                	state <= fetch; -- AC_reg <= MDR
                    AC_reg<=signed(MDR_in_reg);
                 -------------------------------Timer   
                when timer_start_up =>
                	state <= exe_wait; --MDR <= AC_reg **
                    MDR_out_reg<="0000000000000011";
                when timer_start_down =>
                	state <= exe_wait; -- MDR <= AC_reg **
                	MDR_out_reg<="0000000000000001";
                when timer_stop_up =>
                	state <= exe_wait; -- MDR <= AC_reg **
                	MDR_out_reg<="0000000000000010";
                when timer_stop_down =>
                	state <= exe_wait; -- MDR <= AC_reg **
                	MDR_out_reg<="0000000000000000";
                when timer_sPeriod =>
                	state <= exe_wait; -- MDR <= AC_reg
                	MDR_out_reg<=std_logic_vector(AC_reg);
                when timer_sDC =>
                	state <= exe_wait; -- MDR <= AC_reg
                    MDR_out_reg<=std_logic_vector(AC_reg);
                ---------------------------IO
                when io_output =>
                	state <= exe_wait; -- MDR <= AC_reg
                	MDR_out_reg<=std_logic_vector(AC_reg);
                when io_input =>
                	state <= fetch;  -- AC_reg <= MDR
                    AC_reg<=signed(MDR_in_reg);
                    
                when io_temp =>
                	state <= fetch; -- AC_reg <= MDR
                	AC_reg<=signed(MDR_in_reg);
                    
                when io_adc=>
                	state <= fetch; -- AC_reg <= MDR
                    AC_reg<=signed(MDR_in_reg);
               -----------------------------CORDIC
                when cordic_set_datain=>
                	state <= exe_wait; 
                	MDR_out_reg<=std_logic_vector(AC_reg);
                when cordic_sqrt=>
                	state <= exe_wait; 
                	MDR_out_reg<="0000000000010001";
                when cordic_exp =>
                	state <= exe_wait;  
                    MDR_out_reg<="0000000000010010";    
                when  cordic_ln =>
                	state <= exe_wait;
                	MDR_out_reg<="0000000000010100";    
                when cordic_sinh=>
                	state <= exe_wait; 
                    MDR_out_reg<="0000000000011000";
                when cordic_read_status=>
                	state <= fetch; 
                    AC_reg<=signed(MDR_in_reg);
                when cordic_read_result=>
                	state <= fetch; 
                    AC_reg<=signed(MDR_in_reg);
                
               
               -----------------------------others
               when hult=>
                    state<=hult;
               
               when others=>
                    state<=fetch;
            end case;
        end if;
    end process;
    with state select
        MAR_reg<="00000000"                     when reset_pc,
            "00" & std_logic_vector(PC_reg)     when fetch,
            IR_reg(7 downto 0)                  when decode,
            "00" & std_logic_vector(PC_reg)     when exe_add,
            IR_reg(7 downto 0)                  when exe_store,
            "00" & std_logic_vector(PC_reg)     when exe_wait,
            "00" & std_logic_vector(PC_reg)     when exe_load,
            IR_reg(7 downto 0)                  when exe_jump,
            IR_reg(7 downto 0)                  when cordic_set_datain,
            IR_reg(7 downto 0)                  when cordic_sqrt,
            IR_reg(7 downto 0)                  when cordic_ln,
            IR_reg(7 downto 0)                  when cordic_sinh,
            IR_reg(7 downto 0)                  when cordic_exp,
            
--            cordic_set_dataIn,cordic_sqrt , cordic_exp , cordic_ln , cordic_sinh
            -- special addresses will be set in assembler
            IR_reg(7 downto 0)     when uart_set_tx        ,       

            IR_reg(7 downto 0)     when uart_set_br        ,

            IR_reg(7 downto 0)     when timer_start_up        ,
            IR_reg(7 downto 0)     when timer_start_down           ,
            IR_reg(7 downto 0)     when timer_stop_up         ,
            IR_reg(7 downto 0)     when timer_stop_down         ,
            IR_reg(7 downto 0)     when timer_sPeriod      ,
            IR_reg(7 downto 0)     when timer_sDC          ,
            IR_reg(7 downto 0)     when io_output          ,
            
            "00" & std_logic_vector(PC_reg)     when others;
            
            
            
    with state select
        WR_status<='1'          when exe_store|uart_set_tx 
                                     | uart_set_br |timer_start_up|
                                     timer_start_down |timer_stop_up|
                                     timer_stop_down |timer_sDC |
                                     timer_sPeriod | io_output|
                                     cordic_set_dataIn|cordic_sqrt |
                                     cordic_exp | cordic_ln | cordic_sinh,
               '0'              when others;
    
--    process(state,DB,MDR_out_reg)
--    begin 
--        if(state=exe_store) then
--            DB<=MDR_out_reg;             
--        end if;
--    end process; 
     
     --read from data bus process
     process(state,MDR_out_reg,MAR_reg,WR_status)
     begin
        if(WR_status='0')then
        MDR_in_reg<=DB;
        end if;
     end process;
     
     --Tri-state buffer
     DB<= MDR_out_reg when (WR_status='1') else (others=>'Z');
     
    
                                 
end Structural;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
