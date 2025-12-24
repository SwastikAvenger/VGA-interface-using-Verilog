//This module will generate the horizontal synbchronous signal (hsync)
//One complete horizontal scan of the screen has 800 pixels (0-799)

//The horizontal area is partioned into different portions :-
//Horizontal Display Area (0-639)
//Front Porch (the next 16 pixels, upto 655)
//Sync Pulse (the next 96 pixels, from front porch end, upto 752 pixel)
//Back Porch (the last 48 pixels, from Sync Pulse end, upto 799 pixel)

//It is to be kept in mind that the starting pixel is (0,0)
//          __________________________________________________                       ____________________
//                                                              ___________________    
//
//          |         DISPLAY AREA         | |       FP       | |       SP         | |       BP         |      
//          (0,0)....................(639,0) (640,0)....(655,0) (656,0)......(752,0) (753,0)......(799,0)
//          (0,1)....................(639,1) (640,1)....(655,1) (656,1)......(752,1) (753,1)......(799,1)
//          .                              .                                                            |     
//          .                              .                                                            |  
//          .      DISPLAY AREA            .<---------------NO DISPLAY AREA---------------------------->|
//          .      DISPLAY AREA            .<---------------NO DISPLAY AREA---------------------------->|                                                              
//          .                              .<---------------NO DISPLAY AREA---------------------------->|                                                                      
//          .                              .                                                            |  
//          (0,479)................(639,479)<---------------NO DISPLAY AREA---------------------------->|                                                                    
//          .                              .<---------------NO DISPLAY AREA---------------------------->                                                                
//          .                              .                                                            |
//          (0,489)                (639,489)                                                            |
//          .                              .                                                            |            
//          (0,491)                (639,491)                                                            |            
//          .                              .<---------------NO DISPLAY AREA---------------------------->|                                                             
//          .                              .<---------------NO DISPLAY AREA---------------------------->|                                                                       
//          .                              .                                                            |
//          (0,520)                 (639,520)                                                   (799,520)               
  
  
module horizontalSync(
        input en, 
        input clk,
        input [9:0] hcount,
        output reg hsync
);
        localparam TOTAL = 800;             //the total pixel count in VGA interface
        localparam VISIBLE = 640;           //the visible area in VGA interface
        localparam FRONT_PORCH = 16;        //the front porch
        localparam SYNC_PULSE = 96;         //the sync pulse (here, the hsync is LOW)
        localparam BACK_PORCH = 48;         //the back porch    
        
        always@(posedge clk) begin
            if(en)begin
                if(hcount >= ((VISIBLE+FRONT_PORCH)-1) && hcount <= ((VISIBLE+FRONT_PORCH+SYNC_PULSE)-1))begin    //this is the sync pulse area, where hsync goes low
                        hsync <= 0;         //the hsync signal will go low
                end else hsync<= 1;         //the hsync remains high in other areas    
            end
        end
endmodule  
