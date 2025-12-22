module vga(
    input  wire clk,
    input  wire rst,
    input  wire en,

    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,

    output wire Hsync,
    output wire Vsync
);

    // --------------------------------------------------
    // Pixel clock (25 MHz)
    wire pix_clk;
    clk_div clk_div_inst (
        .clk(clk),
        .rst(rst),
        .out_clk(pix_clk)
    );

    // --------------------------------------------------
    // Horizontal counter
    wire [9:0] hcnt;
    wire h_tick;

    HCounter hcounter_inst (
        .clk(pix_clk),
        .en(en),
        .TS(h_tick),
        .hcnt(hcnt)
    );

    horizontalSync hsync_inst (
        .clk(pix_clk),
        .en(en),
        .hcount(hcnt),
        .hsync(Hsync)
    );

    // --------------------------------------------------
    // Vertical counter
    wire [9:0] vcnt;

    VCounter vcounter_inst (
        .clk(pix_clk),
        .en(en),
        .V_en(h_tick),
        .vcnt(vcnt)
    );

    verticalSync vsync_inst (
        .clk(pix_clk),
        .en(en),
        .vcount(vcnt),
        .vsync(Vsync)
    );

    // --------------------------------------------------
    // Visible area
    /*wire video_on;
    assign video_on = (hcnt < 640) && (vcnt < 480);

    // --------------------------------------------------
    // Pixel pointer
    wire [18:0] pixel_addr;

    pixel_point pix_ptr (
        .clk(pix_clk),
        .rst(rst),
        .en(en),
        .Hsync(video_on),   // IMPORTANT
        .Vsync(video_on),   // IMPORTANT
        .addr(pixel_addr)
    );

    // --------------------------------------------------
    // Frame buffer
    wire [5:0] pixel_data;

    frame_buffer fb (
        .clk(pix_clk),
        .addr(pixel_addr),
        .pixel_out(pixel_data)
    );

    // --------------------------------------------------
    // RGB output (from frame buffer)
    assign vgaBlue   = (video_on && en) ? {pixel_data[5:4], 2'b00} : 4'b0000;
    assign vgaGreen  = (video_on && en) ? {pixel_data[3:2], 2'b00} : 4'b0000;
    assign vgaRed    = (video_on && en) ? {pixel_data[1:0], 2'b00} : 4'b0000;
    */
    
        // --------------------------------------------------
    // Visible video region
    wire video_on;
    assign video_on = (hcnt < 640) && (vcnt < 480);

    // --------------------------------------------------
    // Pixel pointer
    wire [18:0] pixel_addr;

    pixel_point pix_ptr (
        .clk(pix_clk),
        .rst(rst),
        .en(en),
        .video_on(video_on),
        .addr(pixel_addr)
    );

    // --------------------------------------------------
    // Frame buffer
    wire [5:0] pixel_data;

    frame_buffer fb (
        .clk(pix_clk),
        .addr(pixel_addr),
        .pixel_out(pixel_data)
    );

    // --------------------------------------------------
    // Optional: align video_on with BRAM latency
    reg video_on_d;
    always @(posedge pix_clk)
        video_on_d <= video_on;

    // --------------------------------------------------
    // VGA RGB outputs (matches your .mem file)
    
    assign vgaRed  = (video_on_d && en) ? {pixel_data[5:4], 2'b00} : 4'b0000;
    assign vgaGreen = (video_on_d && en) ? {pixel_data[3:2], 2'b00} : 4'b0000;
    assign vgaBlue   = (video_on_d && en) ? {pixel_data[1:0], 2'b00} : 4'b0000;


endmodule
