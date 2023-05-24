`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/08 20:18:41
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
    input wire [31:0]num1,
    input wire [31:0]num2,
    input wire [2:0]alu_control,
    output wire [31:0]result,
    output wire zero
    );
assign result = (alu_control == 3'b000)? num1 & num2:
                (alu_control == 3'b001)? num1 | num2:
                (alu_control == 3'b010)? num1 + num2:
                (alu_control == 3'b110)? num1 - num2:
                (alu_control == 3'b111)? num1 < num2:
                32'h00000000;
assign zero = (result == 0)? 1'b1:1'b0;
endmodule
