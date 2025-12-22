`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2025 01:48:09 PM
// Design Name: 
// Module Name: tb_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  This is a testbench, which is designed to simulate the horizontal counter module. It also has inputs
//               for the clock divider and the D flipflop   
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_counter;

    // ===========================
    // Signals
    // ===========================
    reg clk;               // main 100 MHz clock
    reg rst;               // reset for clk_div
    reg en_h;              // enable for HCounter
    reg en_v;              // enable for VCounter

    wire out_clk;          // divided clock (25 MHz approx)
    wire TS;               // tick signal from HCounter
    wire [9:0] hcnt;       // horizontal count
    wire [9:0] vcnt;       // vertical count

    // ===========================
    // Instantiate the Clock Divider
    // ===========================
    clk_div uut_clkdiv (
        .clk(clk),
        .rst(rst),
        .out_clk(out_clk)
    );

    // ===========================
    // Instantiate Horizontal Counter
    // ===========================
    HCounter uut_hcounter (
        .clk(out_clk),
        .en(en_h),
        .TS(TS),
        .hcnt(hcnt)
    );

    // ===========================
    // Instantiate Vertical Counter
    // ===========================
    VCounter uut_vcounter (
        .clk(out_clk),
        .en(en_v),
        .V_en(TS),
        .vcnt(vcnt)
    );


    // ===========================
    // Main Clock Generation
    // ===========================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz clock (10 ns period)
    end

    // ===========================
    // Test Stimulus
    // ===========================
    initial begin
        $display("Starting VCounter simulation...");

        rst  = 1;    // assert reset
        en_h = 0;
        en_v = 0;
        #50;

        rst  = 0;    // release reset
        en_h = 1;    // enable horizontal counter
        en_v = 1;    // enable vertical counter

        // Run long enough to see several full frames
        #17000000;;

        $display("Simulation finished.");
        $stop;
    end


    // ===========================
    // Monitor output activity
    // ===========================
    initial begin
        $monitor("T=%0t | clkdiv=%b | hcnt=%d | TS=%b | vcnt=%d",
                 $time, out_clk, hcnt, TS, vcnt);
    end

endmodule

