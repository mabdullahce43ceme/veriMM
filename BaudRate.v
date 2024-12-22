`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:46:56 10/22/2024 
// Design Name: 
// Module Name:    BaudRate 
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
module BaudRate(input clk, /*rst,*/ input [1:0] b_sel, output reg bclk_8, bclk
    );

reg [20:0] counter;
reg [4:0] counter2;

parameter 
B1 = 325, // This is for 19200 Baud Rate
B2 = 651, //This is for 9600 Baud Rate
B3 = 1302,
B4 = 3906;


initial
begin
	bclk_8 <= 0;
	bclk <= 0;
	counter <= 0;
	counter2 <= 0;
end

always @(posedge clk /*or posedge rst*/)
begin
	/*if (rst)
	begin
		bclk_8 <= 0;
		bclk <= 0;
		counter <= 0;
		counter2 <= 0;
	end
	
	else
	begin*/
	
	if (counter2 == 8)
	begin
		bclk <= ~bclk;
		counter2 <= 0;
	end
	
	counter <= counter + 1;
	
	case (b_sel)
		2'b00: begin 
		if (counter == B1)
		begin
			bclk_8 <= ~bclk_8;
			counter <= 0;
			counter2 <= counter2 + 1;
			
		end
		end
		
		2'b01: begin 
		if (counter == B2)
		begin
			bclk_8 <= ~bclk_8;
			counter <= 0;
			counter2 <= counter2 + 1;
		end
		end
		
		2'b10: begin 
		if (counter == B3)
		begin
			bclk_8 <= ~bclk_8;
			counter <= 0;
			counter2 <= counter2 + 1;
		end
		end
		
		2'b11: begin 
		if (counter == B4)
		begin
			bclk_8 <= ~bclk_8;
			counter <= 0;
			counter2 <= counter2 + 1;
		end
		end
	endcase
	//end
end

endmodule
