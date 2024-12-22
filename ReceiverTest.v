`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:06:14 10/26/2024
// Design Name:   Main
// Module Name:   D:/Program_Files/Xilinx/Lab6/ReceiverTest.v
// Project Name:  Lab6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ReceiverTest;

	// Inputs
	reg clk;
	reg tx;
	reg rst;
	reg rx_data;

	// Outputs
	wire rx_status;
	wire [7:0] RHR;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.clk(clk), 
		.tx(tx), 
		.rst(rst), 
		.rx_data(rx_data),
		.rx_status(rx_status),
		.RHR(RHR)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		tx = 0;
		rst = 0;
		rx_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		#100;
		rst = 0;
        
		// Add stimulus here
		rx_data = 1;
		#13020;
		rx_data = 0;
		
		#104160; //first bit, number is current 01000001
		rx_data = 1;
		
		#104160; //second bit
		rx_data = 0;
		
		#104160; //third bit
		
		#104160; //fourth bit
		
		#104160; //fifth bit
		
		#104160; //sixth bit
		rx_data = 0;
		
		#104160; //seventh bit
		rx_data = 1;
		
		#104160; //eighth bit
		rx_data = 0;
		
		#104160; //stop bit
		rx_data = 1;

	end
	
	always #5 clk = ~clk;
      
endmodule

