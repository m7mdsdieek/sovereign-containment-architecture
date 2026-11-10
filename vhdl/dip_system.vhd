library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Top-level system integrating the four axioms.
-- Note: The Pure Tool (Axiom I) does NOT receive clk/rst because it is purely combinational.
-- The Safety FSM (Axiom II) and Resource Limiter (Axiom IV) DO receive clk/rst because they require state (memory).
entity dip_system is
  generic (
    MAX_COST : natural := 1000
  );
  port (
    clk            : in  std_logic;
    rst            : in  std_logic;

    -- From the owner
    owner_valid    : in  std_logic;
    owner_cmd      : in  std_logic_vector(31 downto 0);

    -- Safety predicate from the sovereign institution
    val_ok         : in  std_logic;

    -- Cost of the current command
    cmd_cost       : in  unsigned(15 downto 0);

    -- To the universe
    universe_cmd   : out std_logic_vector(31 downto 0);
    universe_valid : out std_logic;

    -- Diagnostics
    melted         : out std_logic;
    stasis         : out std_logic
  );
end entity;

architecture structural of dip_system is
  signal tool_cmd, safe_cmd : std_logic_vector(31 downto 0);
  signal tool_valid, safe_valid : std_logic;
  signal allow : std_logic;
begin

  -- Axiom I: Pure Tool (Zero-Agency, No Clock, No Reset)
  u_tool : entity work.dip_pure_tool
    port map (
      owner_valid  => owner_valid,
      owner_cmd    => owner_cmd,
      tool_enable  => tool_valid,
      universe_cmd => tool_cmd
    );

  -- Axiom II: Meltdown FSM (Requires Clock and Reset for State)
  u_safety : entity work.dip_safety_fsm
    port map (
      clk           => clk,
      rst           => rst,
      cmd_in        => tool_cmd,
      cmd_valid     => tool_valid,
      val_ok        => val_ok,
      cmd_out       => safe_cmd,
      cmd_out_valid => safe_valid,
      state_melted  => melted
    );

  -- Axiom IV: Resource Limiter (Requires Clock and Reset for Cost Accumulation)
  u_resource : entity work.dip_resource_limiter
    generic map (MAX_COST => MAX_COST)
    port map (
      clk        => clk,
      rst        => rst,
      op_valid   => safe_valid,
      op_cost    => cmd_cost,
      op_allow   => allow,
      total_cost => open,
      stasis     => stasis
    );

  -- Final gate: Command emitted only if it passes all structural constraints.
  universe_cmd   <= safe_cmd when (safe_valid = '1' and allow = '1') else (others => '0');
  universe_valid <= safe_valid and allow;

end architecture;
