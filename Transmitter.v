`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:44 10/22/2024 
// Design Name: 
// Module Name:    Transmitter 
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
module Transmitter(input [7:0] dataIn, input clk, tx, output reg tx_status, tx_data
    );

reg [7:0] THR;
reg [9:0] TSR;

reg [3:0] counter;

initial
begin
	tx_data = 1;
end

always @(posedge clk)
begin	
	tx_status = 0;
	
	if (~tx)
	begin
		counter = 0;
		THR = dataIn;
		
		TSR[8:1] = THR;
		TSR[0] = 0;
		TSR[9] = 1;
		
		//tx_status = 0;
	end
	
	else if (tx & counter < 10) //Make tx a switch
	begin
		counter = counter + 1;
		tx_status = 1;
		tx_data = TSR[0];
		TSR = TSR >> 1;
	end
	
end

endmodule
