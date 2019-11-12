library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tbGemImm is
end tbGemImm;


architecture tbGemImm_arch of tbGemImm is
   signal tbGemImm_inst : std_logic_vector(31 downto 0);
	signal tbGemImm_imm32 : signed(31 downto 0);

begin

     	DUT : entity work.gemImm
			  port map (inst => tbGemImm_inst, imm32 => tbGemImm_imm32);

	tbGemImm_inst <= x"000002B3", x"01002283" after 30 ns, x"F9C00313" after 60 ns, x"FFF2C293" after 90 ns, x"16200313" after 120 ns, x"01800067" after 150 ns, x"00002437" after 180 ns, x"02542E23" after 210 ns, x"FE5290E3" after 240 ns, x"00C000EF" after 270 ns;


end tbGemImm_arch;
