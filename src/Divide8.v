`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:56:20 10/22/2024 
// Design Name: 
// Module Name:    Divide8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Divide8(input clk, rst, output clkby8
    );

reg [2:0] counter;


always @(posedge clk)
begin
	if (rst)
	begin
		counter = 0;
		clkby8 = 0;
	end

	counter = counter + 1;
	if (counter == 4)
	begin
		clkby8 = ~clkby8;
	end
end

endmodule
