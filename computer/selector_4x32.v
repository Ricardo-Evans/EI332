module selector_4x32(control, source0, source1, source2, source3, result);
	input[31:0] source0, source1, source2, source3;
	input[1:0] control;
	output[31:0] result;
	
	assign result = (control == 0 ? source0 : (control == 1 ? source1 : (control == 2 ? source2 : (control == 3 ? source3 : 0))));
		
endmodule 