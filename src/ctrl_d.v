module Control (
	input wire clk, rst, rx_status, tx_status, mm_status,
	output reg tx_en, mm_en,
	output reg [7:0] addr_in, addr_out
);
reg rst_addr_in, rst_addr_out;


always @(negedge rx_status) begin
	// this means some data has been received
	if (rst_addr_in) begin
		addr_in = 0;
	end else begin
		addr_in = addr_in + 1;
	end
end
always @(posedge clk or posedge rst) begin
	// if receiving done, then start multiplication
	if (addr_in == 17 | rst) begin
		rst_addr_in = 1;
		mm_en = 1;
	end else begin
		rst_addr_in = 0;
		mm_en = 0;
	end
	// if transmission done
	if (addr_out == 8 | rst) begin
		rst_addr_out = 1;
	end else begin
		rst_addr_out = 0;
	end
end
always @(posedge clk or posedge mm_status) begin
	// if matrix multiplication done, start transmission
	if (mm_status & (!tx_status & addr_out != 8)) begin
		tx_en = 1;
	end else begin
		tx_en = 0;
	end
end
always @(posedge tx_status) begin
	if (rst_addr_out) begin 
		addr_out = 0;
	end else begin
		addr_out = addr_out + 1;
	end
end


endmodule

