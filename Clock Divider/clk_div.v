//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 04:26:44 PM
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  This is a clock divider module that uses a D flipflop to divide the incoming 100Mhz clock to 5MHz
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module clk_div(
        input clk,
        input rst,
        output out_clk
    );
        wire [1:0] din;
        wire [1:0] clkdiv;
 
    D_FF dff_inst0 (
      .clk(clk),
      .rst(rst),
      .D(din[0]),
      .Q(clkdiv[0])
    );
 
    genvar i;
    generate
        for (i = 1; i < 2; i=i+1) 
    begin : dff_gen_label
        D_FF dff_inst (
          .clk(clkdiv[i-1]),
          .rst(rst),
          .D(din[i]),
          .Q(clkdiv[i])
        );  
        end
    endgenerate;
 
        assign din = ~clkdiv;
        assign out_clk = clkdiv[1];

endmodule
