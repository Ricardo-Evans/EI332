module EX(clock, reset, alu_result, 
							id_ex_alu_operation, id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_write_register, id_ex_register_number, id_ex_register_source, id_ex_write_data, id_ex_data, id_ex_pc4,
							ex_mem_alu_result, ex_mem_alu_zero, ex_mem_write_register, ex_mem_register_number, ex_mem_register_source, ex_mem_write_data, ex_mem_data, ex_mem_pc4);
	
	input clock, reset, id_ex_write_register, id_ex_write_data;
	input[31:0] id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_data, id_ex_pc4;
	input[3:0] id_ex_alu_operation;
	input[4:0] id_ex_register_number;
	input[1:0] id_ex_register_source;
	output[31:0] alu_result, ex_mem_alu_result, ex_mem_data, ex_mem_pc4;
	output ex_mem_alu_zero, ex_mem_write_register, ex_mem_write_data;
	output[4:0] ex_mem_register_number;
	output[1:0] ex_mem_register_source;
	reg[31:0] ex_mem_alu_result, ex_mem_data, ex_mem_pc4;
	reg ex_mem_alu_zero, ex_mem_write_register, ex_mem_write_data;
	reg[4:0] ex_mem_register_number;
	reg[1:0] ex_mem_register_source;
	
	wire[31:0] alu_result;
	wire zero;
	alu alu_instance(id_ex_alu_operation, id_ex_alu_parameter1, id_ex_alu_parameter2, alu_result, zero);
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1)
		begin
			ex_mem_alu_result <= 0;
			ex_mem_alu_zero <= 0;
			ex_mem_data <= 0;
			ex_mem_pc4 <= 0;
			ex_mem_write_data <= 0;
			ex_mem_write_register <= 0;
			ex_mem_register_number <= 0;
			ex_mem_register_source <= 0;
		end
		else 
		begin
			ex_mem_alu_result <= alu_result;
			ex_mem_alu_zero <= zero;
			ex_mem_data <= id_ex_data;
			ex_mem_pc4 <= id_ex_pc4;
			ex_mem_write_data <= id_ex_write_data;
			ex_mem_write_register <= id_ex_write_register;
			ex_mem_register_number <= id_ex_register_number;
			ex_mem_register_source <= id_ex_register_source;
		end
	end
	
endmodule 