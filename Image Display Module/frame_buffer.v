/*`timescale 1ns / 1ps

module frame_buffer (
    input  wire  clk,                  // Pixel clock (e.g., 25 MHz for 640x480 VGA)
    input  wire [18:0] addr,          // Address of each pixel (0 to 307199)
    output reg  [5:0]  pixel_out     // 6-bit RGB output (2 bits each for R,G,B)
);

    // Total pixels: 640 × 480 = 307,200
    // Each pixel is 6-bit wide (2 bits each for R,G,B)
    reg [5:0] frame [0:307200];

    // Preload image from memory file
    initial begin
        $readmemh("frame.mem", frame);
    end

    // Synchronous read
    always @(posedge clk) begin
        pixel_out <= frame[addr];
    end

endmodule
*/

`timescale 1ns / 1ps

module frame_buffer (
    input  wire        clk,        // Pixel clock
    input  wire [18:0] addr,       // Pixel address
    output reg  [5:0]  pixel_out   // RGB: [5:4]=B, [3:2]=G, [1:0]=R
);

    // 640 × 480 = 307,200 pixels
    reg [5:0] frame [0:307200];

    initial begin
        $readmemh("frame.mem", frame);
    end

    always @(posedge clk) begin
        pixel_out <= frame[addr];
    end

endmodule



