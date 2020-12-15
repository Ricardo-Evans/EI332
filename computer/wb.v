module WB(clock, reset, mem_wb_alu_result, mem_wb_alu_zero, mem_wb_write_register, mem_wb_register_number, mem_wb_register_source, mem_wb_pc4, mem_wb_data, 
							wb_write_enabled, wb_register_number, wb_data);
	input clock, reset;
	input mem_wb_alu_zero, mem_wb_write_register;
	input[31:0] mem_wb_alu_result, mem_wb_pc4, mem_wb_data;
	input[4:0] mem_wb_register_number;
	input[1:0] mem_wb_register_source;
	output wb_write_enabled;
	output[4:0] wb_register_number;
	output[31:0] wb_data;
	
	assign wb_write_enabled = mem_wb_write_register;
	assign wb_register_number = mem_wb_register_number;
	
	selector_4x32 wb_data_selector(mem_wb_register_source, mem_wb_alu_result, mem_wb_pc4, mem_wb_data, 2'h00,  wb_data);
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1)
		begin
		end
		else
		begin
		end
	end
endmodule 