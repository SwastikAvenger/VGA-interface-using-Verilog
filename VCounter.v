//This module is a Vertical Counter which counts from 0 to 524. 
//The vertical counter increaments it's value when it receives the tick signal from the horizontal counter
//When the count upto 525 is reached, the counter is resetted

module VCounter(
        input clk,                              //the input clock signal from the clock divider module
        input en,                               //the enable signal for the vertical counter
        input V_en,                             //the tick signal coming from the horizontal counter module    
        output reg [9:0] vcnt = 0              //an output register for the vertical count
);
        always@(posedge (clk)) begin            //when the clock is high
            if (en == 1'b1)begin                //if the enable line is active
                if(V_en == 1)begin              //if the tick signal is active
                    if(vcnt < 524)begin         //if the counter value is less than 524,
                        vcnt <= vcnt + 1;       //keep increamenting it's value by one, with every tick signal
                    end else begin              //if the full screen render is done,        
                        vcnt <= 0;              //reset the counter to start again for a new render
                    end
                end
            end 
        end
endmodule