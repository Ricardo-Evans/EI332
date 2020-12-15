module io(memory_clock, address, input_data, output_data, write_enabled, aixin);
	input memory_clock, write_enabled;
	input[31:0] address, input_data;
	output[31:0] output_data, aixin;
	reg[31:0] output_data, aixin;
	always @ (posedge memory_clock)
	begin
		if (write_enabled)
		begin
			case(address[7:2])
				6'b101010: aixin <= input_data;
			endcase
		end
	end
endmodule 