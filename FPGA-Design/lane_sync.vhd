-- lane_sync.vhd
--
-- delay video sync signals
--
-- FPGA Vision Remote Lab http://h-brs.de/fpga-vision-lab
-- (c) Marco Winzker, Hochschule Bonn-Rhein-Sieg, 03.01.2018

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity lane_sync is
  generic (delay : integer := 7);
  port (clk    : in  std_logic;
        reset  : in  std_logic;
        vs_in  : in  std_logic;
        hs_in  : in  std_logic;
        de_in  : in  std_logic;
        vs_out : out std_logic;
        hs_out : out std_logic;
        de_out : out std_logic);
end lane_sync;

architecture behave of lane_sync is


  type delay_array is array (0 to delay) of std_logic;
  signal vs_delay : delay_array;
  signal hs_delay : delay_array;
  signal de_delay : delay_array;

begin

  -- first value of array is current input
  vs_delay(0) <= vs_in;
  hs_delay(0) <= hs_in;
  de_delay(0) <= de_in;

  process
  begin
    wait until rising_edge(clk);

    -- delay according to generic
    for i in 1 to delay loop
      vs_delay(i) <= vs_delay(i-1);
      hs_delay(i) <= hs_delay(i-1);
      de_delay(i) <= de_delay(i-1);
    end loop;

  end process;

  -- last value of array is output
  vs_out <= vs_delay(delay);
  hs_out <= hs_delay(delay);
  de_out <= de_delay(delay);

end behave;
