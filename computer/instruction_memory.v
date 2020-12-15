module instruction_memory(memory_clock, address, instruction);
	input memory_clock;
	input[31:0] address;
	output[31:0] instruction;
	
	rom rom_instance(memory_clock, address[7:2], instruction);
endmodule 