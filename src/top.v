module Main (
	input wire clk, rst, Rx, 
	output wire Tx
);
wire tx_status, rx_status, tx_en, mm_en;
wire[7:0] parallel_in, parallel_out, addr_in, addr_out;
wire[7:0] c11, c12, c13, c21, c22, c23, c31, c32, c33;
reg mm_status;
reg[7:0] a1, a2, a3, b1, b2, b3;
reg[7:0] mem_in[0:17], mem_out[0:8];


/**
 * RsTx and RsRx with their controller
 * This controller also gives the addresses of where to put the data 
 * Or from where to load the data
**/
Transmitter blk_01(.clk(clk), .en(tx_en), .parallel_in(parallel_in), .tx(tx), .tx_status(tx_status));
Receiver blk_02(.clk(clk), .rx(rx), .rx_status(rx_status), .parallel_out(parallel_out));
Control blk_03(.clk(clk), .rst(rst), .rx_status(rx_status), .tx_status(tx_status), .mm_status(mm_status), .tx_en(tx_en), .mm_en(mm_en), .addr_in(addr_in), .addr_out(addr_out));


/**
 * Handling the data loading into mem_in
 * And also from mem_out into parallel_in
**/
always @(posedge clk or posedge rst) begin
	if (rst) begin									// on reset
		for (integer i = 0; i < 18; i = i + 1) begin
			mem_in[i] = 0;
		end
		for (integer i = 0; i < 9; i = i + 1) begin
			mem_out[i] = 0;
		end
	end else if (!rx_status) begin					// if not receiving
		mem_in[addr_in] = parallel_out;
		for (integer i = 0; i < 9; i = i + 1) begin
			mem_out[i] = mem_out[i];
		end
	end else begin
		mem_in[addr_in] = mem_in[addr_in];
		for (integer i = 0; i < 9; i = i + 1) begin
			mem_out[i] = mem_out[i];
		end
	end
end
assign parallel_in = mem_out[addr_out];


/**
 * Processing Elements, inspired from systolic arrays but implemented in parallel manner
**/
MAC pe_01(.clk(clk), .rst(mac_rst), .a(a1), .b(b1), .c(c11));
MAC pe_02(.clk(clk), .rst(mac_rst), .a(a1), .b(b2), .c(c12));
MAC pe_03(.clk(clk), .rst(mac_rst), .a(a1), .b(b3), .c(c13));
MAC pe_04(.clk(clk), .rst(mac_rst), .a(a2), .b(b1), .c(c21));
MAC pe_05(.clk(clk), .rst(mac_rst), .a(a2), .b(b2), .c(c22));
MAC pe_06(.clk(clk), .rst(mac_rst), .a(a2), .b(b3), .c(c23));
MAC pe_07(.clk(clk), .rst(mac_rst), .a(a3), .b(b1), .c(c31));
MAC pe_08(.clk(clk), .rst(mac_rst), .a(a3), .b(b2), .c(c32));
MAC pe_09(.clk(clk), .rst(mac_rst), .a(a3), .b(b3), .c(c33));


/**
 * Defining a controller for the PEs
 * It is to be an FSM
**/
reg mac_rst;
reg[2:0] state, next_state;
always @(posedge clk or posedge rst) begin
	if (rst) begin
		state = 0;
	end else begin
		state = next_state;
	end
end
always @(*) begin
	next_state = state;
	mac_rst = 0;
	mm_status = 0;
	a1 = 0;
	a2 = 0;
	a3 = 0;
	b1 = 0;
	b2 = 0;
	b3 = 0;
	case (state)
		0: begin
			if (mm_en) begin
				next_state = 1;
			end
		end
		1: begin
			next_state = 2;
			mac_rst = 1;
		end
		2: begin
			next_state = 3;
			a1 = mem_in[0];
			a2 = mem_in[3];
			a3 = mem_in[6];
			b1 = mem_in[9];
			b2 = mem_in[12];
			b3 = mem_in[15];
		end
		3: begin
			next_state = 4;
			a1 = mem_in[1];
			a2 = mem_in[4];
			a3 = mem_in[7];
			b1 = mem_in[10];
			b2 = mem_in[13];
			b3 = mem_in[16];
		end
		4: begin
			next_state = 5;
			a1 = mem_in[2];
			a2 = mem_in[5];
			a3 = mem_in[8];
			b1 = mem_in[11];
			b2 = mem_in[14];
			b3 = mem_in[17];
		end
		5: begin
			mm_status = 1;
			next_state = 0;
		end
	endcase
end
always @(posedge mm_status) begin
	mem_out[0] = c11;
	mem_out[1] = c12;
	mem_out[2] = c13;
	mem_out[3] = c21;
	mem_out[4] = c22;
	mem_out[5] = c23;
	mem_out[6] = c31;
	mem_out[7] = c32;
	mem_out[8] = c33;
end


endmodule

