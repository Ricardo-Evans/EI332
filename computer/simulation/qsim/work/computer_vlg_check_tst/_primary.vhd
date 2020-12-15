library verilog;
use verilog.vl_types.all;
entity computer_vlg_check_tst is
    port(
        aixin           : in     vl_logic_vector(31 downto 0);
        pc              : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end computer_vlg_check_tst;
