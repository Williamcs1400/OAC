library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb is
generic (DATA_WIDTH : natural := 32);
end tb;


architecture tb_arch of tb is
   signal tb_A, tb_B, tb_S : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal tb_OP : std_logic_vector(3 downto 0);
begin

     	DUT : entity work.p_ula
			  port map (a => tb_A, b => tb_b, result => tb_S, op => tb_OP);

	tb_OP <= "0000", "0001" after 30 ns, "0010" after 60 ns, "0011" after 90 ns, "0100" after 120 ns, "0101" after 150 ns, "0110" after 180 ns, "0111" after 210 ns, "1000" after 240 ns, "1001" after 270 ns, "1010" after 300 ns, "1011" after 330 ns;

	tb_A <= x"00000000", x"00000001" after 10 ns; -- x"00000010" after 20 ns; --x"00000001" after 10 ns;

	tb_B <= x"00000000", x"00000001" after 20 ns; -- x"00000010" after 40 ns;

end tb_arch;