library verilog;
use verilog.vl_types.all;
entity computer_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end computer_vlg_sample_tst;
