//======================================================
// File: barrel_shifter_8_tb.v
// Description: 8 bit barrel shifter testbench
// 
// Name: Hannah Kelley
// Due Date: 9/25/26
//======================================================

`timescale 1ms/1ms

module barrel_shifter_8_tb ();

	reg EN;
	reg [7:0] a;
	reg s2, s1, s0;
	
	wire [7:0] c;
	
	barrel_shifter_8 DUT (
    .EN(EN),
    .a(a),
    .s2(s2),
    .s1(s1),
    .s0(s0),
    .c(c)
	);
	
	initial begin
	
		EN = 0;
		s2 = 0;
		s1 = 0;
		s0 = 0;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00000001) begin // enter hex values to make this easier to debug
			$display("Pass Shift 0");
		end else begin
			$display("Fail Shift 0");
		end
		
		EN = 0;
		s2 = 0;
		s1 = 0;
		s0 = 1;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b10000000) begin // 
			$display("Pass Shift 1");
		end else begin
			$display("Fail Shift 1");
		end
		
		EN = 0;
		s2 = 0;
		s1 = 1;
		s0 = 0;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b01000000) begin // enter hex values to make this easier to debug
			$display("Pass Shift 2");
		end else begin
			$display("Fail Shift 2");
		end
	
		EN = 0;
		s2 = 0;
		s1 = 1;
		s0 = 1;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00100000) begin // enter hex values to make this easier to debug
			$display("Pass Shift 3");
		end else begin
			$display("Fail Shift 3");
		end
		
		EN = 0;
		s2 = 1;
		s1 = 0;
		s0 = 0;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00010000) begin // enter hex values to make this easier to debug
			$display("Pass Shift 4");
		end else begin
			$display("Fail Shift 4");
		end
		
		EN = 0;
		s2 = 1;
		s1 = 0;
		s0 = 1;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00001000) begin // enter hex values to make this easier to debug
			$display("Pass Shift 5");
		end else begin
			$display("Fail Shift 5");
		end
		
		EN = 0;
		s2 = 1;
		s1 = 1;
		s0 = 0;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00000100) begin // enter hex values to make this easier to debug
			$display("Pass Shift 6");
		end else begin
			$display("Fail Shift 6");
		end
		
		EN = 0;
		s2 = 1;
		s1 = 1;
		s0 = 1;
		a = 8'b00000001;
		#10;
		
		if (c == 8'b00000010) begin // enter hex values to make this easier to debug
			$display("Pass Shift 7");
		end else begin
			$display("Fail Shift 7");
		end
		
		EN = 1;
		s2 = 0;
		s1 = 0;
		s0 = 0;
		a = 8'b00000001;
		#10;
		
		if (c === 8'bzzzzzzzz) begin // enter hex values to make this easier to debug
			$display("Pass Enable OFF");
		end else begin
			$display("Fail Enable OFF");
		end
		
		$finish;
	
	end	
	
endmodule