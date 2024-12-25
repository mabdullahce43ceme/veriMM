`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:38:55 10/08/2024 
// Design Name: 
// Module Name:    MAC 
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
module MAC(input [7:0] in1,in2, input clk, acc, enable, output reg [7:0] out
    );

reg [31:0] tempval = 0;
//reg [31:0] A,B;

always @(posedge clk)
begin
	//A <= in1;
	//B <= in2;
	
	if (enable)
	begin
		if (acc)
			//tempval <= A*B;
			tempval <= in1*in2;
		else
			//tempval <= A*B + tempval;
			tempval <= in1*in2 + tempval;
	end
end

always @(*)
begin
	out = tempval;
end

endmodule
