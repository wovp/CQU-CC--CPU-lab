`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
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

module pc(
    input clk,
    input RST,
    input [31:0]pc1,
    output reg [31:0]pc2
    );
always @ (posedge RST or posedge clk)
    begin 
    if(RST == 1)
        pc2 <= 0;
    else
        pc2 <= pc1;
    end
endmodule
