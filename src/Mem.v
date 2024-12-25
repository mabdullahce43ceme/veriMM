`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:41:56 10/08/2024 
// Design Name: 
// Module Name:    Mem 
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
module Mem(input [7:0] Inputdata, MAC_Result, i,j,k, maxSize, input [2:0] MemSel, input read, write, clk, MAC_or_Size, output [7:0] outA, outB, outC
    );

reg [7:0] MemA [255:0];
reg [7:0] MemB [255:0];
reg [7:0] MemC [255:0];
wire [7:0] addressA,addressB;

assign addressA = i*maxSize + j + 1; //Using different i,j,k values for reading because we want it to be independent of Baud Rate. otherwise, multiple drivers will drive values of i,j and k
assign addressB = j*maxSize + k + 1;

assign outA = (read)? MemA[addressA]: 0;
assign outB = (read)? MemB[addressB]: 0;
assign outC = (read)? MemC[addressB]: 0;

//k is the total length of the matrix
//The first memory address 0 always contains the total length of the Matrix
initial
begin
	/*MemA[0] = 10;
	MemB[0] = 10;
	
	MemC[0] = 2;
	MemC [1] = 1;
	MemC [2] = 3;
	MemC [3] = 5;
	MemC [4] = 7;*/
end

always @(posedge clk)
begin
	if (write)
	begin
		//addressA = i*maxSize + j + 1;
		case (MemSel)
			2'b00: MemA[addressA] = Inputdata;
			2'b01: MemB[addressA] = Inputdata;
			2'b10: MemC[addressA] = (MAC_or_Size)? outA : MAC_Result;
		endcase
	end
end

endmodule
