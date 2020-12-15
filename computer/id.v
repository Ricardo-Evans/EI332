module ID(clock, reset, block, if_id_instruction, if_id_pc4, jump, jump_pc, 
							id_ex_alu_operation, id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_write_register, id_ex_register_number, id_ex_register_source, id_ex_write_data, id_ex_data, id_ex_pc4,
							wb_write_enabled, wb_register_number, wb_data, forward_data);
							
	input clock, reset, wb_write_enabled;
	input[31:0] if_id_instruction, if_id_pc4, wb_data, forward_data;
	input[4:0] wb_register_number;
	
	output[3:0] id_ex_alu_operation;
	reg[3:0] id_ex_alu_operation;
	output block, jump, id_ex_write_register, id_ex_write_data;
	output[1:0] id_ex_register_source;
	output[4:0] id_ex_register_number;
	output[31:0] jump_pc, id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_data, id_ex_pc4;
	reg[31:0] id_ex_alu_parameter1, id_ex_alu_parameter2, id_ex_data, id_ex_pc4;
	reg id_ex_write_register, id_ex_write_data;
	reg[1:0] id_ex_register_source;
	reg[4:0] id_ex_register_number;
	
	// r-type
	wire[5:0] op = if_id_instruction[31:26];
	wire[4:0] rs = if_id_instruction[25:21];
	wire[4:0] rt = if_id_instruction[20:16];
	wire[4:0] rd = if_id_instruction[15:11];
	wire[31:0] shamt = {{17{1'b0}}, if_id_instruction[10:6]};
	wire[5:0] func = if_id_instruction[5:0];
	// i-type
	wire[15:0] im = if_id_instruction[15:0];
	// j-type
	wire[25:0] address = if_id_instruction[25:0];
	
	// registers
	wire[31:0] raw_rs_data, raw_rt_data, rs_data, rt_data;
	registers registers_instance(clock, reset, rs, rt, wb_register_number, wb_data, raw_rs_data, raw_rt_data, wb_write_enabled);
	// forward
	wire forward_rs, forward_rt;
	assign forward_rs = id_ex_write_register & (r_type | i_type) & (id_ex_register_number == rs);
	assign forward_rt = id_ex_write_register & r_type & (id_ex_register_number == rt);
	selector_2x32 rs_data_selector(forward_rs, forward_data, raw_rs_data, rs_data);
	selector_2x32 rt_data_selector(forward_rt, forward_data, raw_rt_data, rt_data);
	
	wire branch_condition = (rs_data == rt_data);
	wire sign_extern, write_register, read_data, write_data, shift, alu_immediate, r_type, i_type, j_type, jal;
	wire[3:0] alu_operation;
	wire[1:0] pc_source;
	cu cu_instance(op, func, branch_condition, r_type, i_type, j_type, write_data, write_register, read_data, alu_operation, shift, alu_immediate, pc_source, jal, sign_extern);
	assign jump = (pc_source != 0);
	selector_4x32 jump_pc_selector(pc_source, 0, if_id_pc4 + (immediate << 2), {if_id_pc4[31:28], address, 2'b00}, rs_data, jump_pc);
	
	// alu parameter
	wire e = sign_extern & if_id_instruction[15];
   wire[31:0] immediate = {{16{e}}, im};
	wire[31:0] alu_parameter1, alu_parameter2;
	selector_2x32 alu_parameter_selector1(shift, shamt, rs_data, alu_parameter1);
	selector_2x32 alu_parameter_selector2(alu_immediate, immediate, rt_data, alu_parameter2);
	
	reg block_instruction;
	assign block = block_instruction & (id_ex_register_number == rs | (r_type & id_ex_register_number == rt));
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1)
		begin
			block_instruction <= 0;
			id_ex_alu_operation <= 0;
			id_ex_alu_parameter1 <=  0;
			id_ex_alu_parameter2 <= 0;
			id_ex_write_data <= 0;
			id_ex_write_register <= 0;
			id_ex_register_source[1] <= 0;
			id_ex_register_source[0] <= 0;
			id_ex_register_number <= 0;
			id_ex_data <= 0;
			id_ex_pc4 <= 0;
		end
		else
		begin
			block_instruction <= read_data;
			id_ex_alu_operation <= block == 1 ? 0 : alu_operation;
			id_ex_alu_parameter1 <=  block == 1 ? 0 : alu_parameter1;
			id_ex_alu_parameter2 <= block == 1 ? 0 : alu_parameter2;
			id_ex_write_data <= block == 1 ? 0 : write_data;
			id_ex_write_register <= block == 1 ? 0 : write_register;
			id_ex_register_source[1] <= block == 1 ? 0 : read_data;
			id_ex_register_source[0] <= block == 1 ? 0 : jal;
			id_ex_register_number <= block == 1 ? 0 : (r_type == 1 ? rd : (i_type == 1 ? rt : (j_type == 1 ? 5'b11111 : 1'b0)));
			id_ex_data <= block == 1 ? 0 : rt_data;
			id_ex_pc4 <= block == 1 ? 0 : if_id_pc4;
		end
	end
endmodule 