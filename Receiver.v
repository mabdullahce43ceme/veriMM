`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:07:51 10/22/2024 
// Design Name: 
// Module Name:    Receiver 
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
module Receiver(input rx_data, clk, output reg rx_status, output reg [7:0] RHR
    );

reg highEdge, lowEdge;
reg prevRx;
reg [4:0] counter, c_counter; //, rst_counter;
reg [7:0] RSR;

//assign highEdge = !prevRx & rx_data;
//assign lowEdge = prevRx & !rx_data;

initial
begin
	rx_status = 0;
	//rst_counter = 0;
end

always @(posedge clk)
begin
	highEdge = !prevRx & rx_data;
	lowEdge = prevRx & !rx_data;
	prevRx = rx_data;
	RHR = 0;
	
	/*if (RHR != 0)
	begin
		rst_counter = rst_counter + 1;
		if (rst_counter == 8)
		begin
			rst_counter = 0;
			RHR = 0;
		end
	end*/
		
	
	if (lowEdge == 1 & rx_status == 0)
	begin
		counter = 0;
		c_counter = 0;
		rx_status = 1;
	end
	
	else if (rx_status & c_counter < 8)
	begin
		counter = counter + 1;
		
		if (counter == 8)
		begin
			c_counter = c_counter + 1;
			counter = 0;
			
			
			RSR = RSR >> 1;
			RSR[7] = rx_data;
		end
	end
	
	else if (c_counter == 8)
	begin
		RHR = RSR;
		rx_status = 0;
	end
	
end

endmodule
