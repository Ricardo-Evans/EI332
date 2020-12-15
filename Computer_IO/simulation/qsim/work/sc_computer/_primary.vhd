library verilog;
use verilog.vl_types.all;
entity sc_computer is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        clock           : out    vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        inst            : out    vl_logic_vector(31 downto 0);
        aluout          : out    vl_logic_vector(31 downto 0);
        memout          : out    vl_logic_vector(31 downto 0);
        imem_clk        : out    vl_logic;
        dmem_clk        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        AX              : in     vl_logic_vector(31 downto 0);
        mem_dataout     : out    vl_logic_vector(31 downto 0);
        io_read_data    : out    vl_logic_vector(31 downto 0)
    );
end sc_computer;
