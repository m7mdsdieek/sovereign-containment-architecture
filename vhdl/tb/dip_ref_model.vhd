library IEEE;
use IEEE.std_logic_1164.all;
entity dip_ref_model is
  port ( clk, rst, cmd_valid, val_ok : in std_logic; cmd_in : in std_logic_vector(31 downto 0);
         cmd_out : out std_logic_vector(31 downto 0); cmd_out_valid, state_melted : out std_logic );
end entity;
architecture behavioral of dip_ref_model is signal is_melted : std_logic := '0';
begin process(clk) begin if rising_edge(clk) then if rst = '1' then is_melted <= '0';
  elsif cmd_valid = '1' and val_ok = '0' then is_melted <= '1'; end if; end if; end process;
  cmd_out <= cmd_in when is_melted = '0' else (others => '0');
  cmd_out_valid <= cmd_valid when is_melted = '0' else '0';
  state_melted <= is_melted;
end architecture;
