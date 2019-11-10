library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gemImm is
	port (
		inst  : in std_logic_vector(31 downto 0);
		imm32 : out std_logic_vector(31 downto 0)
	);
end entity gemImm;

architecture gemImm of gemImm is
	signal immTipoI, immTipoS, immTipoB, immTipoU, immTipoJ : std_logic_vector(31 downto 0);
	
	begin
		immTipoU <= inst(31 downto 12)& ('0','0','0','0','0','0','0','0','0','0','0','0');
		immTipoI <= inst(31 downto 20) & ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
		immTipoJ <= inst(30 downto 21) & inst(20) & inst(19 downto 12) & inst(31) & '0' & ('0','0','0','0','0','0','0','0','0','0','0');
		immTipoS <= inst(4 downto 0) & inst(31 downto 25) & ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
		immTipoB <= inst(11 downto 8) & inst(25 downto 30) & inst(7) & inst(31) & '0' & ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
		
		
		imm32 <= immTipoI when (signed(inst(7 downto 0))) = "00000011" else   -- tipo-I
					immTipoI when (signed(inst(7 downto 0))) = "00001101‬" else   -- tipo-I
					immTipoI when (signed(inst(7 downto 0))) = "01000011‬" else   -- tipo-I
					immTipoU when (signed(inst(7 downto 0))) = "00010001" else   -- tipo-U
					immTipoU when (signed(inst(7 downto 0))) = "00100101" else   -- tipo-U
					immTipoS when (signed(inst(7 downto 0))) = "00010111‬" else   -- tipo-S
					immTipoB when (signed(inst(7 downto 0))) = "00111111‬" else   -- tipo-B
					immTipoJ when (signed(inst(7 downto 0))) = "01101111";		  -- tipo-J
				

end gemImm;