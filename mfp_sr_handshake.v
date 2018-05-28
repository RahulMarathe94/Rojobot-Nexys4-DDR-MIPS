`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2018 12:57:53
// Design Name: 
// Module Name: mfp_sr_handshake
// Project Name: 
// Target Devices: 
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
module mfp_sr_handshake(
    input IO_BotUpdt,                                   // 1 bit IO_Bot_Updt_Sync to the Handshake Module
    input clk1_in,                                      //  50 Mhz Clock from CLock Wizard
    output reg IO_BotUpdt_Sync,                         // 1 bit IO_Bot_Updt_Sync to the Handshake Module
    input IO_INT_ACK                                    // 1 bit Acknowledge from the Nexys4DDR to the Handshake 
    );
       
    always @(posedge clk1_in) begin
    if(IO_INT_ACK == 1'b1) begin
    IO_BotUpdt_Sync <= 1'b0;
    end
    else if(IO_BotUpdt == 1'b1) begin
    IO_BotUpdt_Sync <= 1'b1;
    end
    else
    begin
    IO_BotUpdt_Sync <= IO_BotUpdt_Sync;
    end
    end
      
endmodule
