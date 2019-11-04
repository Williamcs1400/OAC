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
	result <= std_logic_vector(signed(a) + signed(b)) when op = "0000" else
	          std_logic_vector(signed(a) - signed(b)) when op = "0001" else
				 to_stdlogicvector(to_bitvector(a) sll to_integer(unsigned(b))) when op = "0010" else
				 a;
				 
end p_ula;