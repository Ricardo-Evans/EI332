library verilog;
use verilog.vl_types.all;
entity computer is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        aixin           : out    vl_logic_vector(31 downto 0)
    );
end computer;
