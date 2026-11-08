library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity dip_resource_limiter is generic (MAX_COST : natural := 1000);
  port ( clk, rst, op_valid : in std_logic; op_cost : in unsigned(15 downto 0);
         op_allow : out std_logic; total_cost : out unsigned(31 downto 0); stasis : out std_logic );
end entity;
architecture rtl of dip_resource_limiter is
  signal accumulated : unsigned(31 downto 0); signal frozen : std_logic;
begin
  process(clk) variable next_acc : unsigned(31 downto 0); begin if rising_edge(clk) then
    if rst = '1' then accumulated <= (others => '0'); frozen <= '0';
    elsif frozen = '0' and op_valid = '1' then
      next_acc := accumulated + resize(op_cost, 32);
      if next_acc > to_unsigned(MAX_COST, 32) then frozen <= '1';
      else accumulated <= next_acc; end if; end if; end if; end process;
  op_allow <= '1' when frozen = '0' else '0';
  total_cost <= accumulated; stasis <= frozen;
end architecture;
