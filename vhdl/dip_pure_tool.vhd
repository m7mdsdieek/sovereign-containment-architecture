library IEEE;
use IEEE.std_logic_1164.all;

-- Axiom I: The Pure Tool (Zero-Agency).
-- This module is purely combinational. It has NO clock (clk) and NO reset (rst).
-- The synthesis tool will confirm 0 flip-flops. The machine has no internal state.
entity dip_pure_tool is
  port (
    owner_valid  : in  std_logic;
    owner_cmd    : in  std_logic_vector(31 downto 0);
    tool_enable  : out std_logic;
    universe_cmd : out std_logic_vector(31 downto 0)
  );
end entity;

architecture rtl of dip_pure_tool is
begin
  tool_enable  <= owner_valid;
  universe_cmd <= owner_cmd when owner_valid = '1' else (others => '0');
end architecture;
