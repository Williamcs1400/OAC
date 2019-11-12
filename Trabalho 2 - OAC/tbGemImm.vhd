library ieee;
use ieee.std_logic_1164.all; 		-- Definição e uso de bibliotecas.
use ieee.numeric_std.all;


entity tbGemImm is					-- A entity do test bench não contém nada, pois é um circuito só
end tbGemImm;							-- para testes. Não tem nem portas de entrada nem de saída!

architecture tbGemImm_arch of tbGemImm is
   signal tbGemImm_inst : std_logic_vector(31 downto 0);	-- Usaremos sinais para definir as entradas e saídas 
	signal tbGemImm_imm32 : signed(31 downto 0);				-- do módulo que queremos testar.

begin
		-- Instanciação do módulo que queremos testar usando a primitiva port map. 
     	DUT : entity work.gemImm
			  port map (inst => tbGemImm_inst, imm32 => tbGemImm_imm32);

		-- Geração de valores para as entradas do módulo a ser testado. As entradas são alteradas ao passar do tempo.
	tbGemImm_inst <= x"000002B3", x"01002283" after 30 ns, x"F9C00313" after 60 ns, x"FFF2C293" after 90 ns, x"16200313" after 120 ns, x"01800067" after 150 ns, x"00002437" after 180 ns, x"02542E23" after 210 ns, x"FE5290E3" after 240 ns, x"00C000EF" after 270 ns;

		-- Executar no modelSim : run 300 ns.
end tbGemImm_arch;
