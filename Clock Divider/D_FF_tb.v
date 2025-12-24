`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 03:05:28 PM
// Design Name: 
// Module Name: D_FF_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module D_FF_tb;

    // Testbench signals
    reg D;                  //Input Data Signal
    reg clk;                //Input Clock Signal
    reg rst;                //Input Reset Signal
    wire Q;                 //Outpur Signal

    // Instantiate the DUT
    D_FF uut (
        .D(D),
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    // Clock generation (10ns period → 100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Monitor values on console
        $monitor("Time=%0t | rst=%b | D=%b | Q=%b", $time, rst, D, Q);

        // Initial conditions
        rst = 1;  // Apply reset
        D   = 0;

        #10;
        rst = 0;  // Release reset

        // Test 1: D = 1
        #10 D = 1;

        // Test 2: D = 0
        #10 D = 0;

        // Test 3: Change D multiple times
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;

        // Apply reset again
        #10 rst = 1;
        #10 rst = 0;

        // Test final value
        #10 D = 0;

        #20 $finish;
    end

endmodule

