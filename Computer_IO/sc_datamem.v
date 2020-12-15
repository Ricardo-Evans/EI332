module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk,AX,result,mem_dataout,io_read_data);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
   
   input          we, clock,mem_clk;
	input [31:0] AX;
   output [31:0]  dataout;
   output         dmem_clk;
	output [31:0] result;
	output [31:0] mem_dataout;
	output [31:0] io_read_data;
   
   wire           dmem_clk;    
   wire           write_enable; 
	wire [31:0] dataout;
	wire [31:0] mem_dataout;
	wire write_data_enable;
	wire write_io_enable;
   assign         write_enable = we & ~clock; 
   
   assign         dmem_clk = mem_clk & ( ~ clock) ; 
	assign write_data_enable = write_enable & (~addr[7]);//注意
	assign write_io_enable = write_enable & addr[7]; //注意
   
   lpm_ram_dq_dram  dram(addr[6:2],dmem_clk,datain,write_data_enable,mem_dataout );
	
	mux2x32 io_data_mux(mem_dataout,io_read_data,addr[7],dataout);
	
	io_output io_output_reg (addr, datain, write_io_enable, dmem_clk, result);
	io_input io_input_reg(addr, dmem_clk, io_read_data, AX);
	

endmodule 