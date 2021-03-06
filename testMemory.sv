// This is a READ ONLY MEMORY
// Reading a one-port ROM
// This is 7 bits so the highest it can be is only 127 for address

module testMemory(Clk, Reset ,Dout);
	input Clk, Reset;
	output [15:0] Dout;
	
	logic [6:0] addr = 7'd0;
	
	// Copied from myAlteraROM.v
	myAlteraROM u1(
	.address(addr),
	.clock(Clk),
	.q(Dout));
	
	
	always_ff @(posedge Clk) begin
		
		if (Reset) // active high
				addr <= 7'd0;
		else if (addr != 7'd127)
				 addr <= addr + 1;
				else
				 addr <= 8'd0;
	end
	
	
endmodule


// This will go through all the addresses
`timescale 1ns/1ns 
module testMemory_tb();
	
	logic Clk, Reset;
	logic [15:0] Dout;
//	logic [7:0] addr;
	
	
	testMemory DUT(Clk, Reset, Dout);
	
	always begin
		
		Clk = 0; #10;
		Clk = 1; #10;
	
	end
	
	
	initial begin
		Reset = 0;
		#200;
		Reset = 1; 
		#200;
		@(posedge Clk);
		Reset = 0; //Disassert the reset signal
		@(posedge Clk);// 1 clock cycle
		@(posedge Clk); // 1 clock cycle
		assert(Dout == 8'd10);
		$display("Done!");
		#400;
		$stop;
	end
	
	
	// This will monitor/display whenever something changes
	initial $monitor($time,,,DUT.addr,,, Dout);



endmodule
