`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2025 01:02:07 PM
// Design Name: 
// Module Name: HCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  This module creates a horizontal counter which counts from 0 to 799. Upon counting, a Vertical Counter enable
//               signal is generated.



module HCounter(
        input clk,                      //the input DIVIDED clock
        input en,                       //an enable signal for the horizontal counter module
        output reg TS,                  //this is the Tick Signal (kinda like enable) for the vertical counter module.
        output reg [9:0] hcnt = 0       //the horizontal counter which shows the count
    );
    
    always@(posedge (clk)) begin        //At the positive edge of clock,    
        if(en == 1'b1) begin            //If the enable is active
            if(hcnt < 799) begin
                hcnt <= hcnt + 1;       //Start the count.Keep counting unless 799 pixel is reached    
                TS <= 1'b0;             //The tick signal for the vertical counter is deactivated
            end 
            else begin                  //At 799 pixel count,              
                hcnt <= 0;              //reset the horizontal counter to zero
                TS <= 1'b1;             //increament the tick signal (in essence, the vertical counter enable signal is ON)
            end
        end 
    end
endmodule
