//======================================================
// File: race_lights_tb.v
// Description: race lights testbench
// 
// Name: Hannah Kelley
// Due Date: 10/2/26
//======================================================

`timescale 1ns/1ns

module race_lights_tb;

    reg clk, reset, start;
    wire clk_1Hz, red, yellow, green;

    // Clock divider
    clock_divider divider (
        .clk_10MHz(clk),
        .reset(reset),
        .clk_1Hz(clk_1Hz)
    );

    // Race lights
    race_lights lights (
        .clk_1Hz(clk_1Hz),
        .reset(reset),
        .start(start),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // 10 MHz clock
    // Period = 100 ns
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end

    initial begin

        // RESET
        reset = 1;
        start = 0;

        #200;

        if (red && !yellow && !green)
            $display("RESET/RED: PASS");
        else
            $display("RESET/RED: FAIL");

        reset = 0;
		  #100;

        // START
        start = 1;

        // Wait for the next 1 Hz clock edge
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change
        start = 0;

        // RED_WAIT
        // Red should remain on
        if (red && !yellow && !green)
            $display("RED_WAIT: PASS");
        else
            $display("RED_WAIT: FAIL");

        // YELLOW
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change

        if (!red && yellow && !green)
            $display("YELLOW: PASS");
        else
            $display("YELLOW: FAIL");

        // GREEN - 1st second
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change

        if (!red && !yellow && green)
            $display("GREEN (1 second): PASS");
        else
            $display("GREEN (1 second): FAIL");

        // GREEN - 2nd second
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change

        if (!red && !yellow && green)
            $display("GREEN (2 seconds): PASS");
        else
            $display("GREEN (2 seconds): FAIL");

        // GREEN - 3rd second
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change

        if (!red && !yellow && green)
            $display("GREEN (3 seconds): PASS");
        else
            $display("GREEN (3 seconds): FAIL");

        // RED after 3 seconds
        @(posedge clk_1Hz);
		  #1; // to give time for the clk to change

        if (red && !yellow && !green)
            $display("RETURN TO RED: PASS");
        else
            $display("RETURN TO RED: FAIL");

        $display("End");
        $finish;

    end

endmodule