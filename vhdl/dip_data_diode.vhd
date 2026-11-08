library IEEE;
use IEEE.std_logic_1164.all;
entity dip_data_diode is
  port ( world_in : in std_logic_vector(31 downto 0); world_valid : in std_logic;
         internal_data : out std_logic_vector(31 downto 0); internal_valid : out std_logic );
end entity;
architecture rtl of dip_data_diode is begin
  internal_data <= world_in;
  internal_valid <= world_valid;
end architecture;
