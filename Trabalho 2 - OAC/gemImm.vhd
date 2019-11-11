library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gemImm is
	port (
		inst  : in std_logic_vector(31 downto 0); -- declaração da instrução de entrada
		imm32 : out signed(31 downto 0)				-- declaração do imediato de saída
	);
end entity gemImm;

architecture gemImm of gemImm is
	signal immTipoR, immTipoI, immTipoS, immTipoB, immTipoU, immTipoJ : signed(31 downto 0); -- vetores auxiliares
	signal opcode : std_logic_vector(6 downto 0);														  -- vetor para guardar o opcode da instrução
	
	begin
		opcode <= inst(6 downto 0);																								-- guarda os 7 bits do opcode
		immTipoR <= x"00000000";																									-- vetor do tipo R recebe 0's (não tem imediato)
		immTipoU <= (signed(shift_left((resize(signed(inst(31 downto 12)),32)),12)) and x"FFFFF000");		-- vetor do tipo U recebe o formato da instrução do imediato e coloca 0's nos 12 bits menos significativos (não tem extensao de sinal)
		immTipoI <= (signed(resize(signed(inst(31 downto 20)),32)));													-- vetor do tipo I recebe o formato da instrução do imediato com extensão de sinal
		immTipoS <= (signed(resize(signed(inst(31 downto 25) & inst(11 downto 7)),32)));							-- vetor do tipo S recebe o formato da instrução do imediato com extensão de sinal
		immTipoB <= (signed(resize(signed(inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0'),32)));	-- vetor do tipo B recebe o formato da instrução do imediato com extensão de sinal
		immTipoJ <= (signed(resize(signed(inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0'),32))); -- vetor do tipo J recebe o formato da instrução do imediato com extensão de sinal
		
		imm32 <= immTipoU when opcode = "0010111" else   -- tipo-U op = x17
					immTipoU when opcode = "0110111" else   -- tipo-U op = x37
					immTipoI when opcode = "0010011" else   -- tipo-I op = x13
					immTipoI when opcode = "0000011" else   -- tipo-I op = x03
					immTipoI when opcode = "1100111" else	 -- tipo-I op = x67
					immTipoS when opcode = "0100011" else   -- tipo-S op = x23
					immTipoB when opcode = "1100011" else   -- tipo-B op = x63
					immTipoR when opcode = "0110011" else   -- tipo-R op = x33
					immTipoJ when opcode = "1101111";       -- tipo-J op = x6F
	
end gemImm;
