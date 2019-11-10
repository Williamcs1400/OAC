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
		immTipoU <= (signed(shift_left((resize(signed(inst(31 downto 12)),32)),12)) and x"FFFFF000");
		--immTipoI <= resize(inst(31) & inst(31 downto 20); -- Falta so extensao
		immTipoJ <= ('1','1','1','1','1','1','1','1','1','1','1','1') & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0'; -- Falta so extensao
		immTipoS <= ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0') & inst(31 downto 25) & inst(11 downto 7); -- Falta so extensao
		immTipoB <= ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0') & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0'; -- Falta so extensao
		
		
		imm32 <= immTipoU when (signed(inst(6 downto 0))) = "0010111" else   -- tipo-U op = x17
					immTipoU when (signed(inst(6 downto 0))) = "0110111" else   -- tipo-U op = x37
					immTipoI when (signed(inst(6 downto 0))) = "0010011" else   -- tipo-I op = x13
					--immTipoI when (signed(inst(6 downto 0))) = "0000011‬" else   -- tipo-I op = x03
					--immTipoI when (signed(inst(6 downto 0))) = "1100111‬" else   -- tipo-I op = x67
					--immTipoS when (signed(inst(6 downto 0))) = "0100011‬" else   -- tipo-S op = x23
					--immTipoB when (signed(inst(6 downto 0))) = "1100011‬";       -- tipo-B op = x63
					immTipoJ when (signed(inst(6 downto 0))) = "1101111";   -- tipo-J op = x6F
					
				

end gemImm;
