`timescale 1ns / 1ps

//This module will generate the vertical synbchronous signal (vsync)
//One complete horizontal scan of the screen has 800 pixels (0-799)

//The horizontal area is partioned into different portions :-
//Horizontal Display Area (0-639)
//Front Porch (the next 16 pixels, upto 655)
//Sync Pulse (the next 96 pixels, from front porch end, upto 752 pixel)
//Back Porch (the last 48 pixels, from Sync Pulse end, upto 799 pixel)

//It is to be kept in mind that the starting pixel is (0,0)


//          (0,0)....................(639,0) (640,0)....(655,0) (656,0)......(752,0) (753,0)......(799,0)
// |   D    (0,1)....................(639,1) (640,1)....(655,1) (656,1)......(752,1) (753,1)......(799,1)
// |   I    .                              .                                                            |     
// |   S    .                              .                                                            |  
// |   P    .      DISPLAY AREA            .<---------------NO DISPLAY AREA---------------------------->|
// |   L    .      DISPLAY AREA            .<---------------NO DISPLAY AREA---------------------------->|                                                              
// |   A    .                              .<---------------NO DISPLAY AREA---------------------------->|                                                                      
// |   Y    .                              .                                                            |  
// |        (0,479)................(639,479)<---------------NO DISPLAY AREA---------------------------->|                                                                    
// |   F    .      NO DISPLAY              .<---------------NO DISPLAY AREA---------------------------->                                                                
// |   P    .      NO DISPLAY              .                                                            |
// |        (0,489)                (639,489)                                                            |
//   |S P   .      NO DISPLAY              .                                                            |            
//   |      (0,491)                (639,491)                                                            |            
// |   B    .      NO DISPLAY              .<---------------NO DISPLAY AREA---------------------------->|                                                             
// |        .      NO DISPLAY              .<---------------NO DISPLAY AREA---------------------------->|                                                                       
// |   P    .      NO DISPLAY              .                                                            |
// |        (0,520)                 (639,520)                                                   (799,520)               



module verticalSync(
        input en,
        input clk,
        input [9:0] vcount,
        output reg vsync
    );
    
    localparam TOTAL = 521;             //the total screen area
    localparam VISIBLE = 480;           //the vertical visible area 
    localparam FRONT_PORCH = 10;        //the front porch
    localparam SYNC_PULSE = 2;          //the sync pulse (vertical sync goes low in this region)
    localparam BACK_PORCH = 29;         //the back porch
    
        always@(posedge (clk))begin
            if(en)begin
                if(vcount >= VISIBLE+FRONT_PORCH - 1 && vcount <= VISIBLE+FRONT_PORCH+SYNC_PULSE -1)begin     //in the sync pulse region,
                    vsync <= 0;         //the vertical pulse signal goes low    
                end else
                    vsync <= 1;         //outside the sync pulse area, the horizontal signal goes high
            end
        end
endmodule
