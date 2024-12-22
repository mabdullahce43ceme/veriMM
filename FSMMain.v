`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:47 12/09/2024 
// Design Name: 
// Module Name:    FSMMain 
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
module FSMMain(input clk, btn, rx_status, tx_status, input [1:0] b_sel, input [7:0] data1, data2, data3, RHR, output reg read, write, enableMAC, MAC_or_Size, acc, tx, output reg[2:0] MemSel, output reg [7:0] i,j,k, maxSize
    );
//0 is the Idle state.
//State 1 receives length of Matrix A
//State 2 receives values
//State 4 outputs values of Matrix A or Matrix B on FPGA
//State 8 is for calculating on the MAC

parameter
B1 = 325, // This is for 19200 Baud Rate
B2 = 651, //This is for 9600 Baud Rate
B3 = 1302,
B4 = 3906; 

reg [15:0] counter, counter2;
reg [7:0] tempi, tempj, tempk, prevRHR = 0;
reg [5:0] state = 0;
reg prev_rx_status, prev_tx_status;

always @(posedge clk)
begin
	case (state)
		default: state = 0;
		
		0: 
		begin
			tempi = 0;
			tempj = -1; //Used a lot for addressing, so we set it to -1 by default
			tempk = 0;
			counter = 0;
			counter2 = 0;
			maxSize = 0; //This also makes sure our addressing doesn't mess up when accessing MemB and MemC
			MemSel = 3;
			write = 0;
			read = 0;
			enableMAC = 0;
			MAC_or_Size = 0;
			acc = 0;
			tx = 0;
			
			if (RHR != prevRHR)
			begin
				prevRHR = RHR;
			case (RHR)
				4: begin state = 4; MemSel = 0; read = 1; end //Display results of Matrix A
				8: begin state = 4; MemSel = 1; read = 1; tempk = -1; end //Display results of Matrix B
				12: begin state = 4; MemSel = 2; read = 1; tempk = -1; end //Display results of Matrix C
				16: begin state = 1; MemSel = 0; write = 1; end //Fill Up Matrix A
				32: begin state = 1; MemSel = 1; write = 1;  end //Fill Up Matrix B
				64: begin state = 7; MemSel = 2; MAC_or_Size = 1; read = 1; write = 1; end //MAC Calculations
				
				128: 
				begin 
					state = 13; 
					MemSel = 2; 
					read = 1; 
					tempk = -1; 
					
					case (b_sel)
						default: counter =  B2*8*2;
						0: counter =  B1*8*2;
						2: counter =  B3*8*2;
						3: counter =  B4*8*2;
					endcase
				
				end //Sending the matrix back to the computer
				
				default: state = 0;
			endcase
			end
				
		end
		
		1:
		begin
			if (~rx_status & prev_rx_status)
			begin
				//maxSize = RHR; 
				counter = RHR*RHR; 
				state = 2;
				tempj = 0; //start writing values from address 1 as address 0 is for length
			end
		end
		
		2: 
		begin
			if (~rx_status & prev_rx_status)
			begin
				counter = counter - 1;
				tempj = tempj + 1;
				
				if (counter == 0)
				begin
					state = 0;
					write = 0;
					prevRHR = RHR; //Setting this so on next cycle, the state doesnt shift on 4,8,16,32 etc.
				end
			end
		end
		
		4: 
		begin
			if (MemSel == 0)
			begin
				maxSize = data1;
			end
			
			else if (MemSel == 1)
			begin
				tempk = 0;
				maxSize = data2;
			end
			
			else
			begin
				tempk = 0;
				maxSize = data3;
			end
			
			counter = maxSize*maxSize; 
			tempj = 0;
			state = 5; 
		end
		
		5: 
		begin 
			if (btn == 1)
			begin
				state = 6;
				counter = counter - 1;
				
				if (MemSel == 0)
				begin
					tempj = tempj + 1;
					
					if (tempj >= maxSize)
					begin
						tempi = tempi + 1;
						tempj = 0;
					end
				end
				
				else
				begin
					tempk = tempk + 1;
					
					if (tempk >= maxSize)
					begin
						tempj = tempj + 1;
						tempk = 0;
					end
				end
				
				if (counter == 0)
				begin
					state = 0;
					read = 0;
				end
			end
		end
		
		6:
		begin
			if (btn == 0)
				state = 5;
		end
		
		7:
		begin
			enableMAC = 1;
			MAC_or_Size = 0;
			acc = 1;
			write = 0;
			
			maxSize = data1; 
			MemSel = 2;
			
			tempj = 0;
			state = 8;
		end
		
		8:
		begin
			tempj = tempj + 1;
			write = 0;
			acc = 0;
			
			if (tempj >= maxSize)
			begin
				enableMAC = 0;
				write = 1;
				tempj = tempk;
				state = 9;
			end
			
			if (tempi >= maxSize)
			begin
				read = 0;
				state = 0;
			end
		end
		
		9:
		begin
			tempk = tempk + 1;
			tempj = 0;
			enableMAC = 1;
			write = 0;
			acc = 1;
			
			if (tempk >= maxSize)
			begin
				tempi = tempi + 1;
				tempk = 0;
			end
			state = 8;
		end
		
		13: begin counter2 = data3*data3 + 1; state = 10; end
		
		10:
		begin
			counter = counter - 1;
			if (counter == 0)
			begin
				state = 12;
			end
		end
		
		12:
		begin
			tx = 1;
			if (~tx_status & prev_tx_status)
			begin
				tempk = tempk + 1;
				counter2 = counter2 - 1;
				
				tx = 0;
				state = 10;
				
				case (b_sel)
						default: counter =  B2*8*2 + 20; //Need some extra padding here or the clocks don't line up.
						0: counter =  B1*8*2 + 20;
						2: counter =  B3*8*2 + 20;
						3: counter =  B4*8*2 + 20;
					endcase
					
				if (counter2 == 0)
				begin
					state = 0;
					tx = 0;
					read = 0;
				end	
			end
		end
		
 	endcase
	
	prev_tx_status = tx_status;
	prev_rx_status = rx_status; //At the end because of sequential assignment and to prevent issues
end

always @(*)
begin
	 i <= tempi;
	 j <= tempj;
	 k <= tempk;
end

endmodule
