module io_output(addr,datain,write_io_enable,io_clk,result);
	input [31:0] addr,datain;
	input write_io_enable,io_clk;
	output [31:0] result;
	reg [31:0] result;
	always @ (posedge io_clk)
	begin
		if (write_io_enable == 1)
			case (addr[7:2])
				6'b100000: result <= datain; // 80h
			endcase
	end
endmodule
