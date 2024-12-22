`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:45 12/09/2024 
// Design Name: 
// Module Name:    BTNDebounce 
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
module BTNDebounce(input clk, btn, output reg outbtn
    );

parameter count = 1000;
reg [11:0] counter = 0;

always @(posedge clk)
begin
	counter = counter + 1;
	if (counter == count)
	begin
		outbtn = btn;
		counter = 0;
	end
end

endmodule
