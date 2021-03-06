// Example of Jonah 1st RAM
// Test using testbench go through all the locations 
// and overwrite the old data
// rden is active high and wren is active low. Check myAlteraRAM.v for configs 
// rden == read enable
// wren == write enable
module testRAM(Clk, rden, wren, Dout);
	
	input Clk, rden, wren;
	output [15:0] Dout;
	
	logic [7:0] addr;
	logic [15:0] Din;
	
	myAlteraRAM (
	.address(addr),
	.clock(Clk),
	.data(Din), // data to be written 16 bits
	.rden(rden),
	.wren(wren),
	.q(Dout)); // RAM. When we read it what is the data to be read?

endmodule


// meaning it wont be synthezied with the quartus compiler
`ifdef MODEL_TECH
`timescale 1ns/1ns

module testRAM_tb();
	logic Clk, rden, wren;
	logic [15:0] Dout;
	
	logic [7:0] addr;
	logic [15:0] Din;
	
	testRAM DUT(Clk, rden, wren);
	
	
	always begin
	
		Clk = 0; #10;
		Clk = 1; #10;
		
	end
	
	
	initial begin
	
		wren = 1'b1; rden = 1'b0; #45;  // disable the read and write of RAM
		rden = 1'b1; //enable the read
		
	end

endmodule


`endif
