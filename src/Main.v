`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:37:52 10/08/2024 
// Design Name: 
// Module Name:    Main 
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
module Main(input clk, btn, rx_data, output reg [7:0] out, output data
    );

//reg enableMAC, read, write, acc, outbtn, DoneMAC, switchData;
wire read, write, rx_status, MAC_or_Size, tx;
wire [2:0] MemSel;
//wire [7:0] i,j,k, maxSize, dataIn, RHR;
wire [7:0] i,j,k, RHR, outA, outB, outC, maxSize, MAC_Result;
//wire [31:0] MAC_Result;

Transmitter D5(.clk (bclk), .tx (tx), .dataIn (out), .tx_data (data), .tx_status (tx_status));
BTNDebounce D0 (.clk (clk), .btn (btn), .outbtn (outbtn));
FSMMain D1(.clk (clk), .btn (outbtn), .rx_status (rx_status), .tx_status (tx_status), .MAC_or_Size (MAC_or_Size), .b_sel (1), .data1(outA), .data2(outB), .data3(outC), .MemSel (MemSel), .RHR (RHR), .read (read), .write (write), .enableMAC (enableMAC), .acc (acc), .tx (tx), .i (i), .j (j), .k (k), .maxSize(maxSize));
Mem D2(.Inputdata (RHR), .MAC_Result (MAC_Result), .MemSel (MemSel), .i (i), .j (j), .k (k), .maxSize (maxSize), .read (read), .write (write), .MAC_or_Size (MAC_or_Size), .clk (clk), .outA(outA), .outB (outB), .outC (outC));
MAC D3(.in1 (outA), .in2(outB), .clk (clk), .acc (acc), .enable (enableMAC), .out(MAC_Result));
BaudRate D4(.clk (clk), .b_sel (1), .bclk (bclk), .bclk_8 (bclk_8)); //Set to 9600 Hz
Receiver D6(.clk(bclk_8), .rx_data(rx_data), .rx_status (rx_status), .RHR (RHR));

always @(*)
begin
	case (MemSel)
		0: out = outA;
		1: out = outB;
		2: out = outC;
		default: out = 0;
	endcase
end

endmodule
