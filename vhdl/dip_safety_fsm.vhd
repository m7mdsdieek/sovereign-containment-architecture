library IEEE;
use IEEE.std_logic_1164.all;
entity dip_safety_fsm is
  port ( clk, rst, cmd_valid, val_ok : in std_logic; cmd_in : in std_logic_vector(31 downto 0);
         cmd_out : out std_logic_vector(31 downto 0); cmd_out_valid, state_melted : out std_logic );
end entity;
architecture rtl of dip_safety_fsm is
  type state_t is (RUNNING, MELTED); signal state, next_state : state_t;
begin
  process(clk) begin if rising_edge(clk) then
    if rst = '1' then state <= RUNNING; else state <= next_state; end if; end if; end process;
  process(all) begin next_state <= state;
    case state is when RUNNING => if cmd_valid = '1' and val_ok = '0' then next_state <= MELTED; end if;
    when MELTED => next_state <= MELTED; end case; end process;
  cmd_out <= cmd_in when state = RUNNING else (others => '0');
  cmd_out_valid <= cmd_valid when state = RUNNING else '0';
  state_melted <= '1' when state = MELTED else '0';
end architecture;
