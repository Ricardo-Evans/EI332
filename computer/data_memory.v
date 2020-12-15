module data_memory(memory_clock, address, input_data, output_data, write_enabled, aixin);
	input memory_clock, write_enabled;
	input[31:0] address, input_data;
	output[31:0] output_data, aixin;
	
	wire[31:0] ram_output, io_output;
	
	io io_instance(memory_clock, address, input_data, io_output, write_enabled & address[7], aixin);
	ram ram_instance(memory_clock, address[6:2], input_data, ram_output, write_enabled & (~address[7]));
	
	selector_2x32 selector_instance(address[7], io_output, ram_output, output_data);
endmodule 