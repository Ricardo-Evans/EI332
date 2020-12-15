module IF(clock, reset, old_pc, jump, jump_pc, pc, if_id_instruction, if_id_pc4);
	input clock, reset, jump;
	input[31:0] old_pc, jump_pc;
	output[31:0] pc, if_id_instruction, if_id_pc4;
	reg[31:0] if_id_instruction, if_id_pc4;
	
	wire[31:0] pc4;
	assign pc4 = old_pc + 4;
	
	selector_2x32 selector_instance(jump, jump_pc, pc4, pc);
	
	wire memory_clock;
	assign memory_clock = ~clock;
	wire[31:0] instruction;
	instruction_memory instruction_memory_instance(memory_clock, pc, instruction);
	
	always @ (posedge clock or posedge reset)
	begin
		if (reset == 1) 
		begin
			if_id_instruction <= 0;
			if_id_pc4 <= 0;
		end
		else 
		begin
			if_id_instruction <= instruction;
			if_id_pc4 <= pc4 + 4;
		end
	end
endmodule 