module Transmitter (
	input wire clk, en, 
	input wire[7:0] parallel_in,
	output wire tx,
	output reg tx_status
);
/**
 * 8N1 frame size
 * 9600 BAUD rate
 * 'tx_status' should be used to properly handle 'en' because
 * 'en' is not protected, acts as a reset, and should stay HIGH for a single cycle
**/

// bclk generator
reg bclk_en, bclk, rst_clk_counter;				// signals
reg [31:0] clk_counter;


always @(posedge clk) begin
	if (rst_clk_counter) begin
		clk_counter = 0;
	end else if (!bclk_en) begin
		clk_counter = 0;
	end else begin
		clk_counter = clk_counter + 1;
	end
end
always @(*) begin
	if (en) begin
		bclk_en = 1'b1;		// sig handled (1/3)
	end else begin
		bclk_en = 1'b0;
	end
end
always @(*) begin
	if (clk_counter == 5208) begin
		bclk = ~bclk;	// sig handled (1/1)
		rst_clk_counter = 1'b1;
	end else begin
		bclk = bclk;
		rst_clk_counter = 1'b0;
	end
end


/**
 * baud_count = floor( 100 * 10^6 / (2 * 9600) ) => 5208
 * for 8N1 @ 9600, the clock drift would be 63.33ns per data frame 
 * which is quite small as compared to 104,167ns time period of 9600Hz
**/

// transmission engine
reg [3:0] bit_counter;
reg [9:0] parallel_in_serial_out;


assign tx = parallel_in_serial_out[0];
always @(posedge bclk or posedge en) begin
	if (en) begin
		parallel_in_serial_out = {1'b1, parallel_in, 1'b0};
		bit_counter = 4'd0;
	end else begin
		parallel_in_serial_out = parallel_in_serial_out >> 1;
		bit_counter = bit_counter + 1'b1;
	end
	/**
	 * tx_status should come at last 
	 * because we want tx_status to be updated 
	 * in the current clock cycle and not in the next one
	**/
	tx_status = bit_counter <= 4'd9;
end
always @(*) begin
	if (bit_counter == 9) begin
		rst_bit_counter = 1'b1;
		bclk_en = 1'b0;
	end else begin
		rst_bit_counter = 1'b0;
		bclk_en = 1'b1;
	end
end


endmodule

