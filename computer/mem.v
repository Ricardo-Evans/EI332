module MEM(clock, reset, memory_data, aixin,
								ex_mem_alu_result, ex_mem_alu_zero, ex_mem_write_register, ex_mem_register_number, ex_mem_register_source, ex_mem_write_data, ex_mem_data, ex_mem_pc4, 
								mem_wb_alu_result, mem_wb_alu_zero, mem_wb_write_register, mem_wb_register_number, mem_wb_register_source, mem_wb_pc4, mem_wb_data);
	
	input clock, reset, ex_mem_alu_zero, ex_mem_write_register, ex_mem_write_data;
	input[31:0] ex_mem_alu_result, ex_mem_data, ex_mem_pc4;
	input[4:0] ex_mem_register_number;
	input[1:0] ex_mem_register_source;
	output mem_wb_alu_zero, mem_wb_write_register;
	output[31:0] memory_data, mem_wb_alu_result, mem_wb_pc4, mem_wb_data, aixin;
	output[4:0] mem_wb_register_number;
	output[1:0] mem_wb_register_source;
	reg mem_wb_alu_zero, mem_wb_write_register;
	reg[31:0] mem_wb_alu_result, mem_wb_pc4, mem_wb_data;
	reg[4:0] mem_wb_register_number;
	reg[1:0] mem_wb_register_source;
	
	
	wire memory_clock;
	assign memory_clock = ~clock;
	wire[31:0] memory_data;
	data_memory data_memory_instance(memory_clock, ex_mem_alu_result, ex_mem_data, memory_data, ex_mem_write_data, aixin);
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1)
		begin
			mem_wb_alu_result <= 0;
			mem_wb_alu_zero <= 0;
			mem_wb_write_register <= 0;
			mem_wb_register_number <= 0;
			mem_wb_register_source <= 0;
			mem_wb_pc4 <= 0;
			mem_wb_data <= 0;
		end
		else 
		begin
			mem_wb_alu_result <= ex_mem_alu_result;
			mem_wb_alu_zero <= ex_mem_alu_zero;
			mem_wb_write_register <= ex_mem_write_register;
			mem_wb_register_number <= ex_mem_register_number;
			mem_wb_register_source <= ex_mem_register_source;
			mem_wb_pc4 <= ex_mem_pc4;
			mem_wb_data <= memory_data;
		end
	end
endmodule 