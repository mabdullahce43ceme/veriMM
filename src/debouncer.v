`timescale 1ns / 1ps

module debouncer(
	input clk, push_btn, rst,
	output pulse);

	wire clk_out;
	clk_div clk_mod(.clk(clk), .rst(rst), .clk_out(clk_out));
	button btn(.clk(clk_out), .in(push_btn), .out(pulse));
	
endmodule
//////////////////////////////////////////////////////////////////
module button(
  input clk, in,
  output out
);

  reg r1,r2,r3;
  initial begin
	  r1 <= 0;
	  r2 <= 0;
	  r3 <= 0;
  end
  always @(posedge clk)
  begin
    r1 <= in; // first reg in synchronizer
    r2 <= r1; // second reg in synchronizer, output is in sync!
    r3 <= r2; // remembers previous state of button
  end
  
  // rising edge = old value is 0, new value is 1
  assign out = ~r3 & r2;
endmodule
//////////////////////////////////////////////////////////////////
module clk_div(
  input clk, rst,
  output reg clk_out);
  
  parameter cycles = 100_000;
  reg [31:0] counter;
  
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 0;
		clk_out <= 0;
	 end
    else begin
      counter <= (counter > cycles - 1) ? 0 : counter + 1; // resetting counter if it goes above number of cycles
      clk_out <= (counter > cycles/2) ? 1 : 0; // implemented 50% duty cycle
    end
  end
endmodule
