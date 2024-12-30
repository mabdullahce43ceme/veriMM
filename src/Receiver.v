module Receiver (
	input wire clk, rx,
	output reg rx_status,
	output wire[7:0] parallel_out
);
/**
PORTs:
 * clk __ clock
 * rx __ receiver input
 * rx_status __ signals receiving
 * parallel_out __ output of receiver
HANDLING:
 * on negdge of rx, the bclk starts
 * the counter starts at 0 and then goes to 5207, then a rst_counter resets the counter.
 * the bclk_en signal goes off at the negedge of rx_status
 * 'rx_status' tells if receiver is receiving or not
 * 'parallel_out' should only be sampled when 'rx_status' is LOW
**/

assign parallel_out = serial_in_parallel_out[8:1];

// bclk generator
reg bclk_en, bclk, rst_counter;				// signals
reg [31:0] clk_counter;
always @(posedge clk) begin
	if (!bclk_en) begin
		clk_counter = 0;
	end else begin
		clk_counter = clk_counter + 1;
	end
end
always @(negedge rx) begin
	if (!rx_status) begin
		bclk_en = 1;	// sig handled (1/3)
	end else begin
		bclk_en = bclk_en;
	end
end
always @(posedge clk) begin
	if (clk_counter == 5208) begin
		bclk = ~bclk;	// sig handled (1/1)
		rst_counter = 1;
	end else begin
		bclk = bclk;
		rst_counter = 0;
	end
end


// receive engine
reg rst_bit_counter;
reg[4:0] bit_counter;
reg[9:0] serial_in_parallel_out;

always @(posedge bclk) begin
	if (!rst_bit_counter) begin
		// start bit
		bit_counter = bit_counter + 1;
		serial_in_parallel_out[9] = rx;
		serial_in_parallel_out = serial_in_parallel_out >> 1;
		rx_status = 1;
	end else begin
		bit_counter = 0;
		serial_in_parallel_out = serial_in_parallel_out;
		rx_status = 0;
	end
end
always @(*) begin
	if (bit_counter == 9) begin
		bclk_en = 0;
		rst_bit_counter = 1;
	end else begin
		bclk_en = 1;
		rst_bit_counter = 0;
	end
end


endmodule

