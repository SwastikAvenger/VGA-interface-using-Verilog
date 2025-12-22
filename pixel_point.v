/*`timescale 1ns / 1ps

//This module points to the frame buffer 
//And does nothing else


//////////////////////////////////////////////////////////////////////////////////////////////////////

module pixel_point(
    input  wire clk,          // 25 MHz input clock
    input  wire rst,          // Reset
    input  wire en,           // Enable counting
    input  wire Hsync,        // Horizontal sync
    input  wire Vsync,        // Vertical sync
    output reg  [18:0] addr, // Pixel address (0 to 307199)
    output wire clk_out       // Divided clock (12.5 MHz)
);

//////////////////////////////////////////////////////////////////////////////////////////////////////
    // Clock divider: 25 MHz -> 12.5 MHz

    //reg clk_div;
   // always @(posedge clk or posedge rst) begin
        //if (rst)
            //clk_div <= 0;
        //else
            //clk_div <= !clk_div;  // divide by 2
    //end

    //assign clk_out = clk_div;

    // Pixel pointer will scan frame buffer
    // It will only increment during visible area (Hsync & Vsync active)

    always @(posedge clk or posedge rst) begin
        if (rst)
            addr <= 19'd0;
        else if (en && Hsync && Vsync) begin
            if (addr < 19'd307199)
                addr <= addr + 1;
            else
                addr <= 19'd0;  // wrap around to the end of frame
        end
    end

endmodule
*/

`timescale 1ns / 1ps

// This module generates a linear pixel address
// for the frame buffer during the visible VGA area.

module pixel_point(
    input  wire        clk,        // Pixel clock (25 MHz)
    input  wire        rst,        // Reset
    input  wire        en,         // Enable
    input  wire        video_on,   // High only in visible area
    output reg [19:0]  addr        // 0 to 307199
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            addr <= 19'd0;
        else if (en && video_on) begin
            if (addr < 19'd307199)
                addr <= addr + 1'b1;
            else
                addr <= 19'd0;
        end
    end

endmodule
