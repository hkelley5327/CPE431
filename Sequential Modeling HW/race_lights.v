//======================================================
// File: race_lights.v
// Description: sequential race lights program
// Inputs:	clk (clock)
//				reset (active high)
//				start
//
// Output:	red, yellow, and green lights (active high)
// 
// Name: Hannah Kelley
// Due Date: 10/2/26
//======================================================

module race_lights(input wire clk_1Hz, reset, start,
						 output reg red, yellow, green);
	
	// states
	parameter RED = 2'b00;
	parameter RED_WAIT = 2'b01;
	parameter YELLOW = 2'b10;
	parameter GREEN = 2'b11;
	
	reg [1:0] state;
	
	reg [1:0] green_count; // log2(3) = 1.58
	
	// state and counter
	always @(posedge clk_1Hz or posedge reset) begin
		
		if (reset) begin
			
			state <= RED;
			green_count <= 0;
			
		end else begin
			
			case(state)
			
				RED: begin
					if (start) begin
						state <= RED_WAIT;
					end
				end
				
				RED_WAIT: begin
					state <= YELLOW;
				end
				
				YELLOW: begin
					state <= GREEN;
				end
				
				GREEN: begin
					if (green_count == 2'd2) begin
						green_count <= 0;
						state <= RED;
					end else begin
						green_count <= green_count + 1;
					end
				end
				
				default: begin
					state <= RED;
				end
			
			endcase
			
		end
		
	end
	
	// output
	always @(*) begin
		
		// default all off
		red = 0;
		yellow = 0;
		green = 0;
		
		case (state)
			
			RED, RED_WAIT:
				red = 1;
			
			YELLOW:
				yellow = 1;
				
			GREEN:
				green = 1;
			
		endcase
		
	end

endmodule

// clock divider with 50% duty cycle, 1s period
// 10MHz => 1 Hz
module clock_divider (input wire clk_10MHz, reset, 
							 output reg clk_1Hz);

	reg [22:0] count; // log2(5,000,000) = 22.25
	
	always @(posedge clk_10MHz) begin
		
		if (reset) begin
			count <= 0;
			clk_1Hz <= 0;
		end else begin
			if (count == 23'd4999999) begin // half a second is 5,000,000 cycles at 10MHz
				count <= 0;
				clk_1Hz <= ~clk_1Hz; // toggle clock
			end else begin
				count <= count + 1;
			end
		end
		
	end

endmodule