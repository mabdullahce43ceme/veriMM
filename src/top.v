module Main (
	input wire clk, rst, Rx, 
	output wire Tx
);

//reg enableMAC, read, write, acc, outrst, DoneMAC, switchtx;
wire read, write, rx_status, MAC_or_Size;
wire [2:0] MemSel;
wire [7:0] i,j,k, RHR, outA, outB, outC, maxSize, MAC_Result;


Transmitter blk_01(.clk(clk), .en(), .parallel_in(), .tx(tx), .tx_status());
Receiver blk_02(.clk(clk), .rx(rx), .rx_status(), .parallel_out());
Control blk_03(.clk(clk), .rst(rst), .rx_status(), .tx_status(), .mm_status(), .tx_en(), .mm_en(), .addr_in(), .addr_out());
MAC blk_04(.in1 (outA), .in2(outB), .clk (clk), .acc (acc), .enable (enableMAC), .out(MAC_Result));




endmodule
