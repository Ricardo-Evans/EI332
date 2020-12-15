library verilog;
use verilog.vl_types.all;
entity test_vlg_check_tst is
    port(
        line            : in     vl_logic;
        register1       : in     vl_logic;
        register2       : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end test_vlg_check_tst;
