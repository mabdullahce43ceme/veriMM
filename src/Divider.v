`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:33 09/23/2024 
// Design Name: 
// Module Name:    Divider 
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
module Divider (input clk, input [2:0] DIV, output reg outclk
    );


reg [27:0] counter = 0; //Counter that ticks up. Helps to divide the clock cycle.

//DIV is basically sel bits for this module.
parameter DC = 100000000;
parameter HZ_Half = DC;
parameter HZ_One = DC/2;
parameter HZ_OneHalf = 33000000; //Causing issues in bit file creation, since real number division causes issues.
parameter HZ_Two = 5*DC/20;
parameter HZ_Debounce = 1000;

initial
begin
	outclk = 0;
	//counter = 0;
end

always @(posedge clk)
begin
	counter <= counter + 1; //Counts up every cycle.
	
	case (DIV) //Case resets the counter once it reaches a certain value dependent on DIV.
		3'b000: 
		begin
			if (counter == HZ_Half)
			begin
				outclk <= ~outclk;
				counter <= 0;
			end
		end
		
		3'b001: 
		begin
			if (counter == HZ_One)
			begin
				outclk <= ~outclk;
				counter <= 0;
			end
		end
		
		3'b010: 
		begin
			if (counter == HZ_OneHalf)
			begin
				outclk <= ~outclk;
				counter <= 0;
			end
		end
		
		3'b011: 
		begin
			if (counter == HZ_Two)
			begin
				outclk <= ~outclk;
				counter <= 0;
			end
		end
		
		3'b100: 
		begin
			if (counter == HZ_Debounce)
			begin
				outclk <= ~outclk;
				counter <= 0;
			end
		end
	endcase
end

endmodule
