module selector_2x32(control, source1, source2, result);
	input control;
	input[31:0] source1, source2;
	output[31:0] result;
	
	assign result = control ? source1 : source2;
endmodule 