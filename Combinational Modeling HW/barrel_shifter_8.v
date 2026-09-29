//======================================================
// File: barrel_shifter_8.v
// Description: 8 bit barrel shifter
// Inputs:	EN 			active low enable signal
// 			a[7:0] 		the input vector that gets shifted
//				s2, s1, s0 	the selection inputs
//
// Output:	c[7:0]		the resulting shifted vector
// 
// Name: Hannah Kelley
// Due Date: 9/25/26
//======================================================


module barrel_shifter_8 (input EN, s2, s1, s0, 
								 input [7:0] a, 
								 output reg [7:0] c);

	always @(*) begin
		
		if (EN == 1) begin // if enable input is high (off)
			
			c = 8'bz;
			
		end else begin // else enable unput is low (on)
		
			case ({s2, s1, s0})
			
				3'b000: c = a;
				3'b001: c = {a[0], a[7:1]};
				3'b010: c = {a[1:0], a[7:2]};
				3'b011: c = {a[2:0], a[7:3]};
				3'b100: c = {a[3:0], a[7:4]};
				3'b101: c = {a[4:0], a[7:5]};
				3'b110: c = {a[5:0], a[7:6]};
				3'b111: c = {a[6:0], a[7]};
			
			endcase
		
		end
		
	end

endmodule