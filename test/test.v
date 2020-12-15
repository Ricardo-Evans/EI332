module test(clock, line, register1, register2);
	input clock;
	output register1, register2, line;
	reg register1, register2;
	wire line = ~register1;
	initial
	begin
		register1 <= 0;
		register2 <= 0;
	end
	always @ (posedge clock)
	begin
		register1 <= ~register1;
		register2 <= line;
	end
endmodule 