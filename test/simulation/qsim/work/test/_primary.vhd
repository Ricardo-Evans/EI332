library verilog;
use verilog.vl_types.all;
entity test is
    port(
        clock           : in     vl_logic;
        line            : out    vl_logic;
        register1       : out    vl_logic;
        register2       : out    vl_logic
    );
end test;
