library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gemImm is
	port (
		inst  : in std_logic_vector(31 downto 0);
		imm32 : out signed(31 downto 0)
	);
end entity gemImm;

architecture gemImm of gemImm is
	signal immTipoR, immTipoI, immTipoS, immTipoB, immTipoU, immTipoJ : signed(31 downto 0);
	signal opcode : std_logic_vector(6 downto 0);
	
	begin
		opcode <= inst(6 downto 0);
		immTipoR <= x"00000000";
		immTipoU <= (signed(shift_left((resize(signed(inst(31 downto 12)),32)),12)) and x"FFFFF000");
		immTipoI <= (signed(resize(signed(inst(31 downto 20)),32)));
		immTipoS <= (signed(resize(signed(inst(31 downto 25) & inst(11 downto 7)),32)));
		immTipoB <= (signed(resize(signed(inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0'),32)));
		immTipoJ <= (signed(resize(signed(inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0'),32)));
		
		imm32 <= immTipoJ when opcode = "1101111" else   -- tipo-J op = x6F
					immTipoU when opcode = "0010111" else   -- tipo-U op = x17
					immTipoU when opcode = "0110111" else   -- tipo-U op = x37
					immTipoI when opcode = "0010011" else   -- tipo-I op = x13
					immTipoI when opcode = "0000011";		 -- tipo-I op = x03
					--immTipoI when opcode = "1100111‬" else       -- tipo-I op = x67
					--immTipoS when (signed(inst(6 downto 0))) = "0100011‬" else   -- tipo-S op = x23
					--immTipoB when (signed(inst(6 downto 0))) = "1100011‬" else   -- tipo-B op = x63
					--immTipoR when opcode = "0110011‬";
	
end gemImm;
