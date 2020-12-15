module cpu(clock, reset, pc, aixin);
	input clock, reset;
	output[31:0] pc, aixin;
	
	reg[31:0] old_pc;
	wire[31:0] pc, jump_pc;
	wire jump, block;
	
	initial
	begin
		old_pc <= -4;
	end
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1) old_pc <= -4;
		else if (block == 0) old_pc <= pc;
	end
	
	wire[31:0] if_id_instruction, if_id_pc4;
	IF if_stage(clock, reset, old_pc, jump, jump_pc, pc, if_id_instruction, if_id_pc4);
	
	wire[3:0] id_ex_alu_operation;
	wire[31:0] id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_data, id_ex_pc4, wb_data;
	wire id_ex_write_register, id_ex_write_data, wb_write_enabled;
	wire[1:0] id_ex_register_source;
	wire[4:0] id_ex_register_number, wb_register_number;
	wire[31:0] alu_result, memory_data, forward_data;
	selector_4x32 forward_data_selector(id_ex_register_source, alu_result, id_ex_pc4, memory_data, 2'h00,  forward_data);
	ID id_stage(clock, reset, block, if_id_instruction, if_id_pc4, jump, jump_pc, 
								id_ex_alu_operation, id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_write_register, id_ex_register_number, id_ex_register_source, id_ex_write_data, id_ex_data, id_ex_pc4,
								wb_write_enabled, wb_register_number, wb_data, forward_data);
										
	wire[31:0] ex_mem_alu_result, ex_mem_data, ex_mem_pc4;
	wire ex_mem_alu_zero, ex_mem_write_register, ex_mem_write_data;
	wire[4:0] ex_mem_register_number;
	wire[1:0] ex_mem_register_source;
	EX ex_stage(clock, reset, alu_result, 
								id_ex_alu_operation, id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_write_register, id_ex_register_number, id_ex_register_source, id_ex_write_data, id_ex_data, id_ex_pc4,
								ex_mem_alu_result, ex_mem_alu_zero, ex_mem_write_register, ex_mem_register_number, ex_mem_register_source, ex_mem_write_data, ex_mem_data, ex_mem_pc4);
	
	wire mem_wb_alu_zero, mem_wb_write_register;
	wire[31:0] mem_wb_alu_result, mem_wb_pc4, mem_wb_data;
	wire[4:0] mem_wb_register_number;
	wire[1:0] mem_wb_register_source;
	MEM mem_stage(clock, reset, memory_data, aixin,
											ex_mem_alu_result, ex_mem_alu_zero, ex_mem_write_register, ex_mem_register_number, ex_mem_register_source, ex_mem_write_data, ex_mem_data, ex_mem_pc4,
											mem_wb_alu_result, mem_wb_alu_zero, mem_wb_write_register, mem_wb_register_number, mem_wb_register_source, mem_wb_pc4, mem_wb_data);
											
	WB wb_stage(clock, reset, mem_wb_alu_result, mem_wb_alu_zero, mem_wb_write_register, mem_wb_register_number, mem_wb_register_source, mem_wb_pc4, mem_wb_data, 
									wb_write_enabled, wb_register_number, wb_data);
									
endmodule 