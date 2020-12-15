module io_input(addr,io_clk,io_read_data,AX);
	input [31:0] addr;
	input io_clk;
	input [31:0] AX;
	output [31:0] io_read_data;
	reg [31:0] in_reg;
	io_input_mux io_input_mux2x32(in_reg,addr[7:2],io_read_data);
	
	always @ (posedge io_clk)
	begin
		in_reg <= AX;
	end
		
	
endmodule

module io_input_mux(reg0,sel_addr,y);
	input [31:0] reg0;
	input [5:0] sel_addr;
	output [31:0] y;
	reg [31:0] y;
	always @ *
		case (sel_addr)
			6'b100100: y = reg0;
			// more ports 可根据需要设计更多的端口
			default: y = 32'h0;
		endcase
	
endmodule
