/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (reset,clk,clock,pc,inst,aluout,memout,imem_clk,dmem_clk,result,AX,mem_dataout,io_read_data);
   
	input[31:0] AX;
   input reset,clk;
	
	output clock;
	reg clock;
	
	initial
	begin
		clock = 0;
	end
	always @(posedge clk)
	begin
		if(~reset)
			clock <= 0;
		clock <= ~clock;
	end
	
   output [31:0] pc,inst,aluout,memout;
   output        imem_clk,dmem_clk;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
	output [31:0] result;
	output [31:0] mem_dataout;
	output [31:0] io_read_data;
   
   sc_cpu cpu (clock,reset,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem (aluout,data,memout,wmem,clock,clk,dmem_clk,AX,result,mem_dataout,io_read_data); // data memory.

endmodule



