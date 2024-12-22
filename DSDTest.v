`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:56:13 12/09/2024
// Design Name:   Main
// Module Name:   D:/Program_Files/Xilinx/DSDProject/DSDTest.v
// Project Name:  DSDProject
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

module DSDTest;

	// Inputs
	reg clk;
	reg btn;
	reg rx_data;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.clk(clk), 
		.btn(btn), 
		.rx_data(rx_data),
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btn = 0;
		rx_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rx_data = 1;
		#13020;
		rx_data = 0;
		
		#104160; //first bit
		rx_data = 0;
		
		#104160; //second bit
		//rx_data = 0;
		
		#104160; //third bit
		//rx_data = 0;
		
		#104160; //fourth bit
		//rx_data = 0;
		
		#104160; //fifth bit
		//rx_data = 0;
		
		#104160; //sixth bit
		//rx_data = 0;
		
		#104160; //seventh bit
		rx_data = 1;
		
		#104160; //eighth bit
		rx_data = 0;
		
		#104160; //stop bit
		rx_data = 1;
		
		/*#104160; rx_data = 1; //2 = size of thing
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 1; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 1; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 1; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //1
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 1; //second bit
		#104160; rx_data = 0; //third bit
		#104160; rx_data = 1; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 1; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 1; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		/*#104160; rx_data = 1; //2
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 1; //second bit
		#104160; rx_data = 0; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //3
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 1; //first bit, number is current 01000001 
		#104160; rx_data = 1; //second bit
		#104160; rx_data = 0; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //4
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //5
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 1; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //6
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 1; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //7
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 1; //first bit, number is current 01000001 
		#104160; rx_data = 1; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //8
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 0; //third bit
		#104160; rx_data = 1; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		#104160; rx_data = 1; //9
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 1; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 0; //third bit
		#104160; rx_data = 1; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit
		
		
		//Displaying the results
		#104160; rx_data = 1; //8
		#13020; rx_data = 0; //start bit
		#104160; rx_data = 0; //first bit, number is current 01000001 
		#104160; rx_data = 0; //second bit
		#104160; rx_data = 1; //third bit
		#104160; rx_data = 0; //fourth bit
		#104160; rx_data = 0; //fifth bit
		#104160; rx_data = 0; //sixth bit
		#104160; rx_data = 0; //seventh bit
		#104160; rx_data = 0; //eighth bit
		#104160; rx_data = 1; //stop bit

		
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;
		#100000; btn = 1; #100000; btn = 0;*/
		
	end
	
	always #5 clk = ~clk;
      
endmodule

