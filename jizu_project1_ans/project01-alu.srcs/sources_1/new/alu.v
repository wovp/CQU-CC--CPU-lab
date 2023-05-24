`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2023 02:44:06 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input wire [31:0] a,
    input wire [7:0] b,
    input wire [2:0] f,
    output wire [31:0] s,
    output wire yichu
    );

    wire [31:0] Sign_extend;
    assign Sign_extend={{24{1'b0}},b[7:0]};

    assign yichu = 1'b0;
    assign s = (f == 3'b000) ? (a + Sign_extend):
            (f == 3'b001) ? (a - Sign_extend):
            (f == 3'b010) ? (a & Sign_extend):
            (f == 3'b011) ? (a | Sign_extend):
            (f == 3'b100) ? (~ a):
            (f == 3'b101) ? (a < Sign_extend):
            32'b0;

endmodule

