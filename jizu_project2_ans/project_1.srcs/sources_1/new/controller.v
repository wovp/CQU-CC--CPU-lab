`timescale 1ns / 1ps

module controller(
    input [31:0] instruction,
    output wire jump,
    output wire branch,
    output wire alusrc,
    output wire memwrite,
    output wire memtoreg,
    output wire regwrite,
    output wire regdst,
    output wire pcsrc,
    output wire [2:0] alu_control
    );

//  ��Ϊ    maindec       �����һ��aluop����λ���������������˵������ʲôָ�����ͣ���R-Tpye��lw��sw��beq
// Ȼ��   aluop   ����  aludec  �����ݲ�ͬ��ָ�����ͣ�������ͬ��    alucontrol  �����ǼӼ����߼�����
wire [1:0] alu_op;
// ����λ��     opcode      ��˵��ָ�������
wire [5:0] inst_high;
//  ����λ��    funct   ֻ����������R-Type ָ��ľ������ͣ�����ָ����  lw  ����  xxxxx
wire [5:0] inst_low;

assign inst_high = instruction[31:26];
assign inst_low = instruction[5:0];


maindec maindec(
	.op(inst_high), 
    .jump(jump),
    .branch(branch),
    .alusrc(alusrc),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .regdst(regdst),
    .pcsrc(pcsrc),
    .alu_op(alu_op));		
    

aludec aludec(.funct(inst_low),.alu_op(alu_op),.alu_control(alu_control));
    
endmodule
    