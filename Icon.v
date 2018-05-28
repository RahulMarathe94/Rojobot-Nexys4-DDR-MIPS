`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: RahulM,KiyasulA
// 
// Create Date: 10.02.2018 12:26:09
// Design Name: 
// Module Name: Icon
// Project Name: Rojobot
// Target Devices: Nexys4DDR
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module icon( input clock,reset,sysclk,                   
             input [7:0]LocX,LocY,BotInfo,
             input [9:0] pixel_row,pixel_column,
             output reg [1:0] icon
    );
    
    wire [2:0] orientation;
    assign orientation=  BotInfo[2:0];                                                // Orientation is Determined from the Last Three Bits in BotInfo
    
    reg [7:0] address_N ,address_E,address_NE,address_NW;                             // Store Addresses from the ROM 
    wire[1:0] doutN,doutS,doutE, doutW,doutNE,doutNW,doutSE, doutSW;                  // Stores the Pixel Datat at that specific address
    
     blk_mem_gen_N blk_mem_gen_N(.clka(sysclk), .douta(doutN),.addra(address_N));     // Data and Address from ROM Module 1 Containing the Icon for North
        
     blk_mem_gen_E blk_mem_gen_E(.clka(sysclk), .douta(doutE),.addra(address_E));     // Data and Address from ROM Module 2 Containing the Icon for East  
           
     blk_mem_gen_NW blk_mem_gen_NW(.clka(sysclk), .douta(doutNW),.addra(address_NW)); // Data and Address from ROM Module 3 Containing the Icon for North-West
             
     blk_mem_gen_NE blk_mem_gen_NE(.clka(sysclk), .douta(doutNE),.addra(address_NE)); // Data and Address from ROM Module 4 Containing the Icon for North-East
     
    
        

always@(posedge clock) begin
if (((LocY*6) == pixel_row) && ({LocX,3'b000} == pixel_column)) begin
 if(orientation == 3'b000) begin                 		                              // Bot facing North(0 deg Orientation)
                address_N <= 8'd0;
                icon <= doutN;
                end
            else if(orientation == 3'b100) begin                                      // Bot facing South(180 deg Orientation)
                        address_N <= 8'd255;
                        icon <= doutN;
                 end
             else if(orientation == 3'b010) begin                                    // Bot facing East (90 deg Orientation)
                         address_E <= 8'd0;
                         icon <= doutE;
                  end    
              else if(orientation == 3'b110) begin                                   // Bot facing West(270 deg Orientation)
                       address_E <= 8'd255;
                       icon <= doutE;
                end
                
              else if(orientation == 3'b001) begin                                   // Bot facing NE(45 deg Orientation)
                       address_NE <= 8'd0;
                       icon <= doutNE;
                       end   
               else if(orientation == 3'b101) begin                                  // Bot facing SW(225 deg Orientation)
                      address_NE <= 8'd255;
                      icon <= doutNE;
                      end 
                      
               else if(orientation == 3'b111) begin                                 // Bot facing NW(315 deg Orientation)
                     address_NW <= 8'd0;
                     icon <= doutNW;
                     end  
               else if(orientation == 3'b011) begin                                 // Bot facing SE(135 deg Orientation)
                        address_NW <= 8'd255;
                        icon <= doutNW;
                        end  
end
 else if ((pixel_row >= (LocY*6)) && (pixel_row <= (LocY*6) + 4'd15) && (pixel_column >= {LocX,3'b000}) && (pixel_column <= {LocX, 3'b000} + 4'd15))
           begin
               if(orientation == 3'b000) begin                                      // Bot facing North(0 deg Orientation)
                       address_N <= address_N + 1;
                       icon <= doutN;
                       end
               else if(orientation == 3'b100) begin                                 // Bot facing South(180 deg Orientation)
                       address_N <= address_N - 1;
                       icon <= doutN;
                       end
                else if(orientation == 3'b010) begin                                // Bot facing East (90 deg Orientation)
                        address_E <= address_E + 1;
                        icon <= doutE;
                       end    
                 else if(orientation == 3'b110) begin                               // Bot facing West(270 deg Orientation)
                          address_E <= address_E - 1;
                          icon <= doutE;
                          end
                 else if(orientation == 3'b001) begin                              // Bot facing NE(45 deg Orientation)
                         address_NE <= address_NE + 1;
                         icon <= doutNE;
                         end   
                 else if(orientation == 3'b101) begin                             // Bot facing SW(225 deg Orientation)
                        address_NE <= address_NE - 1;
                        icon <= doutNE;
                        end 
                        
                 else if(orientation == 3'b111) begin                            // Bot facing NW(315 deg Orientation)
                       address_NW <= address_NW + 1;
                       icon <= doutNW;
                       end  
                 else if(orientation == 3'b011) begin                           // Bot facing SE(135 deg Orientation)
                          address_NW <= address_NW - 1;
                          icon <= doutNW;
                          end
               end
       else 
           begin                                                               // Retain the Address if the Bot Location Conditions are not satisfied
              address_N <= address_N;                                  
              address_E <= address_E;
              address_NW <= address_NW;
              address_NE <= address_NE;
              icon <= 2'b00;
           end
       end              
endmodule
