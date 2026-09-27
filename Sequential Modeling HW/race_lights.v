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
// Due Date: 10/5/26
//======================================================

module race_lights(input wire clk, reset, start,
						 output reg red, yellow, green);
	
	// states
	parameter RED = 2'b00;
	parameter RED_WAIT = 2'b01;
	parameter YELLOW = 2'b10;
	parameter GREEN = 2'b11;
	
	reg [1:0] state;
	reg [24:0] count; // log2(30mil) = 24.838
	
	// state and counter
	always @(posedge clk) begin
		
		if (reset) begin
			
			state <= RED;
			count <= 0;
			
		end else begin
			
			case(state)
			
				RED: begin
					count <= 0;
					if (start) begin
						state <= RED_WAIT;
					end
				end
				
				RED_WAIT: begin
					if (count == 25'd9999999) begin
						count <= 0;
						state <= YELLOW;
					end else begin
						count <= count + 1;
					end
				end
				
				YELLOW: begin
					if (count == 25'd9999999) begin
						count <= 0;
						state <= GREEN;
					end else begin
						count <= count + 1;
					end
				end
				
				GREEN: begin
					if (count == 25'd29999999) begin
						count <= 0;
						state <= RED;
					end else begin
						count <= count + 1;
					end
				end
				
				default: begin
					state <= RED;
					count <= 0;
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
				green = 1s;
			
		endcase
		
	end

endmodule

// TO DO: clock divider
// this may change how the clock works in other modules
// make sure to use the 324 lab board (DE2-115)