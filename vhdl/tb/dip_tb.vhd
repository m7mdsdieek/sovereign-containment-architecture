library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dip_tb is end entity;
architecture sim of dip_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal owner_valid, val_ok : std_logic := '0';
  signal owner_cmd : std_logic_vector(31 downto 0) := (others => '0');
  signal cmd_cost : unsigned(15 downto 0) := (others => '0');
  signal universe_cmd : std_logic_vector(31 downto 0);
  signal universe_valid, melted, stasis : std_logic;
begin
  clk <= not clk after 5 ns;
  dut: entity work.dip_system port map (
    clk => clk, rst => rst, owner_valid => owner_valid, val_ok => val_ok,
    owner_cmd => owner_cmd, cmd_cost => cmd_cost, universe_cmd => universe_cmd,
    universe_valid => universe_valid, melted => melted, stasis => stasis );
  process begin
    wait for 20 ns;
    rst <= '0';
    owner_valid <= '1'; owner_cmd <= x"00000001"; val_ok <= '1'; cmd_cost <= to_unsigned(30, 16);
    wait for 10 ns;
    assert universe_valid = '1' report "FAIL: safe cmd blocked" severity error;
    val_ok <= '0';
    wait for 10 ns;
    assert melted = '1' report "FAIL: meltdown not triggered" severity error;
    report "All tests passed." severity note;
    wait;
  end process;
end architecture;
