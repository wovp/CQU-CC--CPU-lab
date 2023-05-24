`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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


module mips(
	output wire inst_ram_ena,data_ram_ena,data_ram_wea,
   	output wire [31:0] pc, alu_result, mem_wdata,
   	input wire [31:0]instr,mem_rdata,
   	input wire clk,rst
    );
    assign inst_ram_ena = 1'b1;
    // alusrc ��������
	wire memtoreg,alusrc,regdst,regwrite,jump,pcsrc,branch;
	wire[2:0] alucontrol;
    wire[5:0] op = instr[31:26];
    wire[5:0] funct = instr[5:0];
	controller controller(
	.opcode(op),
	.funct(funct),
    .jump(jump),
    .branch(branch),
    .alusrc(alusrc),
    .memwrite(data_ram_wea),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .regdst(regdst),
    .alu_control(alucontrol),
    .memen(data_ram_ena)
	);
	// pc Ҫ����4 ���ظ�ԭ����pc�ˣ� ������output
	// aluout ��alu�ļ�������Ҫ���ظ�data memery ��output
	// writedata ���ж�aluout�Ƿ�д���ڴ棬Ҳ��output
	
	datapath datapath(
	.clk(clk),
	.rst(rst),
    .instr(instr),
    .mem_rdata(mem_rdata),
    .pc(pc) ,
    .alu_result(alu_result), 
    .mem_wdata(mem_wdata),
    .jump(jump),
    .branch(branch),
    .alusrc(alusrc),
    .memwrite(data_ram_wea),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .regdst(regdst),
    .alu_control(alucontrol)
	);
	
endmodule
