`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 02:51:55 PM
// Design Name: 
// Module Name: D_FF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This is a D FlipFlop structure
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_FF(
    input D,
    input clk,
    input rst,
    output reg Q
    );
    
    always@ (posedge (clk), posedge (rst))
    begin
        if (rst == 1)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule
