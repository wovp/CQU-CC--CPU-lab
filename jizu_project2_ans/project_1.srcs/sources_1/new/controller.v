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

//  因为    maindec       会产生一个aluop的两位的输出，这个输出是说明它是什么指令类型，是R-Tpye、lw、sw、beq
// 然后   aluop   传入  aludec  ，根据不同的指令类型，产生不同的    alucontrol  来看是加减或逻辑运算
wire [1:0] alu_op;
// 高五位的     opcode      是说明指令的类型
wire [5:0] inst_high;
//  低五位的    funct   只是用来表明R-Type 指令的具体类型，其他指令如  lw  都是  xxxxx
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
    