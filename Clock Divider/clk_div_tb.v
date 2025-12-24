`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 04:35:50 PM
// Design Name: 
// Module Name: clk_div_tb
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

module clk_div_tb;
 
    // Inputs
    reg clk;
    reg rst;
 
    // Outputs
    wire out_clk;
 
    // Instantiate the Unit Under Test (UUT)
    clk_div uut (
        .clk(clk), 
        .rst(rst), 
        .out_clk(out_clk)
    );
 
    always
        #5 clk = ~clk;
 
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
 
        #10 rst = 0;
 
        // Wait 100 ns for global reset to finish
        #100;
 
    end
 
endmodule

