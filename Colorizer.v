`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: RahulM,KiyasulA
// 
// Create Date: 10.02.2018 12:26:09
// Design Name: 
// Module Name: Colorizer
// Project Name: Rojobot
// Target Devices: Nexys4DDR
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module colorizer( input clock,                    // Clock 75 Mhz  
                  input reset,                    // Reset Active Low 
                  input video_on,                 // Video On bit from Dtg
                  input [1:0] world_pixel,        // 2 bit Pixel Input from World Map
                  input [1:0] icon,               // 2 bit Pixel Input from Icon
                  output reg [3:0] red,           // 4 Bit Red Colour Ouput to VGA
                  output reg [3:0] green,         // 4 Bit Green Colour Ouput to VGA
                  output reg [3:0] blue           // 4 Bit Blue Colour Ouput to VGA                      
    );
    //////////////////////Parameters for Background//////////////////////////// 
    //////////////////////////// rrrrggggbbbb//////////////////////////////////   
    parameter background  =  12'b111111111111;    // White Background colour
    parameter blackline   =  12'b000000000000;    // Blackline
    parameter Obstruction =  12'b111100000000;    // Obstruction==Red
    parameter Reserved    =  12'b111100001111;    // Reserved Background colour
    parameter Icon_colour1=  12'b000011110000;    // Green colour
    parameter Icon_colour2=  12'b000011110000;    // Green colour
    parameter Icon_colour3=  12'b000011110000;    // Green colour

always@(posedge clock)
begin
if(video_on) begin                               // Check if Video_on Bit is High
    if(icon==2'b00) begin                        // Check if Bit from Icon is 00 I
    case(world_pixel)
    2'b00: {red,green,blue}<= background;        // Fill the Background Colour with White 
    2'b01: {red,green,blue}<= blackline;         // Fill the Line with Black
    2'b10: {red,green,blue}<= Obstruction;       // Any Obstruction  
    2'b11: {red,green,blue}<= Reserved;          // For Future Additions
    endcase
    end
   else begin       
   case(icon)
   2'b01: {red,green,blue}<= Icon_colour1;         
   2'b10: {red,green,blue}<= Icon_colour2;       
   2'b11: {red,green,blue}<= Icon_colour3;       
   endcase
   end
    end    
 else
 {red,green,blue}<=12'b000000000000;            // As Video_on is zero turn the screen black
    
end
endmodule