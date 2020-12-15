library verilog;
use verilog.vl_types.all;
entity sc_computer_vlg_sample_tst is
    port(
        AX              : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end sc_computer_vlg_sample_tst;
