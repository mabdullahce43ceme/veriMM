module Receiver (
	input wire clk, rx,
	output reg rx_status,
	output wire[7:0] parallel_out
);
/**
 * 'rx_status' tells if receiver is busy or not
 * 'parallel_out' should only be sampled when 'rx_status' is LOW
**/


assign parallel_out = serial_in_parallel_out[8:1];

// bclk generator
reg bclk_en, bclk;				// signals
reg [31:0] clk_counter;
always @(posedge clk) begin
	if (!bclk_en) begin
		clk_counter = 0;
	end else begin
		clk_counter = clk_counter + 1;
	end
end
always @(clk_counter) begin
	if (clk_counter == 5208) begin
		bclk = ~bclk;	// sig handled (1/1)
		bclk_en = 0;	// sig handled (2/3)
	end else begin
		bclk = bclk;
		bclk_en = 1;	// sig handled (3/3)
	end
end


// receive engine
reg rst_bit_counter;
reg[4:0] bit_counter;
reg[9:0] serial_in_parallel_out;

always @(negedge rx) begin
	if (!bclk_en) begin
		bclk_en = 1;	// sig handled (1/3)
	end else begin
		bclk_en = bclk_en;
	end
end
always @(posedge bclk) begin
	if (bit_counter == 0 & !rx | rx_status) begin
		// start bit
		bit_counter = bit_counter + 1;
		serial_in_parallel_out[9] = rx;
		serial_in_parallel_out = serial_in_parallel_out >> 1;
		rx_status = 1;
	end else begin
		// some glitch, so ignore bclk and turn it OFF
		bit_counter = 0;
		serial_in_parallel_out = serial_in_parallel_out;
		rx_status = 0;
		bclk_en = 0;
	end
	if (bit_counter == 10) begin
		rst_bit_counter = 1;
		rx_status = 0;
	end else begin
		rst_bit_counter = 0;
	end
end
always @(posedge clk) begin
	if (rst_bit_counter) begin
		bit_counter = 0;
	end else begin
		bit_counter = bit_counter;
	end
end


endmodule

