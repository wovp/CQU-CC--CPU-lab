`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 14:54:36
// Design Name: 
// Module Name: datapath
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


module datapath(
    input wire clk,
	input wire rst,
	input wire jump, // 是否跳转的标志
	input wire branch, // 是否是分支的标志
	input wire alusrc,
	input wire memtoreg,memwrite,
	input wire regwrite,
	input wire regdst,
    input wire [2:0] alu_control,
    input wire [31:0] instr,mem_rdata,
    output wire [31:0] pc, alu_result, mem_wdata
    );
    wire [31 : 0]pc_plus4, rd1, imm_extend, imm_sl2, pc_branch, pc_next_jump;
    wire [31: 0] alu_srcB, wd3, pc_next;
    wire [4:0] write2reg;
    // mux2 for pc_next
    wire zero, pcsrc;
    assign pcsrc = zero & branch;
//    mux2 mux2_pc
//    (
//    .zero(pc_plus4),
//    .one(pc_branch),
//    .mux(pcsrc),
//    .c(pc_next)
//    );
    // left to
//    wire [31: 0] instr_sl2;
//    assign instr_sl2 = {instr[25:0],2'b00};
    // mux2 for pc_jump
//    mux2 mux2_pc_jump
//    (
//    .zero(pc_next),
//    .one({pc_plus4[31:28],{instr[25:0],2'b00}}),
//    .mux(jump),
//    .c(pc_next_jump)
//    );
    
    assign pc_next_jump = (jump == 1) ? ({pc_plus4[31:28], {instr[25:0], 2'b00}}):
                                    (pcsrc == 1) ? (pc_branch) : (pc_plus4);
    // pc
    pc pc0(
    .clk(clk),
    .RST(rst),
    .pc1(pc_next_jump),
    .pc2(pc)
    );
    // pc + 4
//    adder addr_pc(.a(pc), .b(32'd4), .y(pc_plus4));
    assign pc_plus4 = pc + 32'd4;
    // pc_branch
//    assign imm_sl2 = (imm_extend << 2);
    assign pc_branch = pc_plus4 + {imm_extend[29:0], 2'b00};
    // mux2 for aluSrcB
    mux2 mux2_alu_srcb
    (
    .zero(mem_wdata),
    .one(imm_extend),
    .mux(alusrc), //alusrc
    .c(alu_srcB)
    );
    // alu
    alu alu1(
    .num1(rd1),
    .num2(alu_srcB),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
    );
    // mux2 for regfile where port
    mux2 mux_wd3
    (
    .zero(alu_result),
    .one(mem_rdata),
    .mux(memtoreg), // memtoreg
    .c(wd3)
    );
    // mux2 for regfile where port
    mux2 #(5)mux_wa3
    (
    .zero(instr[20:16]),
    .one(instr[15:11]),
    .mux(regdst), // regdst
    .c(write2reg)
    );
    // regfile
    regfile regfile1(
	.clk(~clk),
	.we3(regwrite), // regwrite
	.ra1(instr[25:21]), // base
	.ra2(instr[20:16]), 
	.wa3(write2reg), // rt
	.wd3(wd3),
	.rd1(rd1),
	.rd2(mem_wdata)
    );
    // signext
    signext signext1(
    .constant(instr[15: 0]),
    .sign_extend(imm_extend)
    );
endmodule
