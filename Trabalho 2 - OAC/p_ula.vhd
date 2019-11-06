library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p_ula is
	generic (DATA_WIDTH : natural := 32);
	port(
		a, b   : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		result : out std_logic_vector(DATA_WIDTH - 1 downto 0);
		op   	 : in std_logic_vector(3 downto 0)
	);
	
end entity p_ula;

architecture p_ula of p_ula is
begin 
	result <= std_logic_vector(signed(a) + signed(b)) when op = "0000" else 	-- Soma de a e b (add)
	          std_logic_vector(signed(a) - signed(b)) when op = "0001" else		-- Subtracao de a e b (sub)
				 
				 to_stdlogicvector(to_bitvector(a) sll to_integer(unsigned(b))) when op = "0010" else		-- Desloca a b bits a esquerda (sll)
				 to_stdlogicvector(to_bitvector(a) srl to_integer(unsigned(b))) when op = "0110" else 		-- Desloca a b bits a direita sem manter o sinal (srl)
				 to_stdlogicvector(to_bitvector(a) sra to_integer(unsigned(b))) when op = "0111" else 		-- Desloca a b bits a direita mantendo o sinal (sra)
				 
				 x"00000001" when op = "0011" and signed(a) < signed(b) else 		-- Joga 1 na saida se a for menor que b levando em conta o sinal (slt)
				 x"00000001" when op = "0100" and unsigned(a) < unsigned(b) else 	-- Joga 1 na saida se a for menor que b sem levar em conta o sinal (sltu)
				 
				 std_logic_vector(signed(a) xor signed(b)) when op ="0101" else	-- XOR logico bit a bit entre a e b (xor)
				 std_logic_vector(signed(a) or signed(b)) when op = "1000" else	-- OU logico bit a bit entre a e b (ou)
				 std_logic_vector(signed(a) and signed(b)) when op = "1001" else	-- E logico bit a bit entre a e b (and)
				 
				 x"00000001" when op = "1010" and signed(a) = signed(b) else 		-- Joga 1 na saida se a for igual a b (seq)
				 x"00000001" when op = "1011" and signed(a) /= signed(b) else 		-- Joga 1 ma saida se a for diferente b (sne)
				 x"00000001" when op = "1100" and signed(a) >= signed(b) else 		-- Joga 1 ma saida se a for maior igual que b co sinal (sge)
				 x"00000001" when op = "1101" and unsigned(a) >= unsigned(b);	 	-- Joga 1 ma saida se a for maior igual que b co sinal (sgeu)
				 
end p_ula;