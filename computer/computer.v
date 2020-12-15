module computer(clock, reset, pc, aixin);
	input clock, reset;
	output[31:0] pc;
	output[31:0] aixin;
	
	cpu cpu_instance(clock, reset, pc, aixin);
endmodule 