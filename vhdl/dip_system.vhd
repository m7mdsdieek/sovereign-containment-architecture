library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dip_system is
  generic (MAX_COST : natural := 1000);
  port (
    clk, rst, owner_valid, val_ok : in std_logic;
    owner_cmd : in std_logic_vector(31 downto 0);
    cmd_cost : in unsigned(15 downto 0);
    universe_cmd : out std_logic_vector(31 downto 0);
    universe_valid, melted, stasis : out std_logic
  );
end entity;
architecture structural of dip_system is
  signal tool_cmd, safe_cmd : std_logic_vector(31 downto 0);
  signal tool_valid, safe_valid, allow : std_logic;
begin
  u_tool: entity work.dip_pure_tool port map (
    owner_valid => owner_valid, owner_cmd => owner_cmd,
    tool_enable => tool_valid, universe_cmd => tool_cmd );
  u_safety: entity work.dip_safety_fsm port map (
    clk => clk, rst => rst, cmd_valid => tool_valid, val_ok => val_ok,
    cmd_in => tool_cmd, cmd_out => safe_cmd, cmd_out_valid => safe_valid, state_melted => melted );
  u_resource: entity work.dip_resource_limiter generic map (MAX_COST => MAX_COST) port map (
    clk => clk, rst => rst, op_valid => safe_valid, op_cost => cmd_cost,
    op_allow => allow, total_cost => open, stasis => stasis );
  universe_cmd <= safe_cmd when (safe_valid = '1' and allow = '1') else (others => '0');
  universe_valid <= safe_valid and allow;
end architecture;
