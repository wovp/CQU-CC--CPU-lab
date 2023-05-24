`timescale 1ns / 1ps

module maindec(
    input [5:0] op,	//  这个是高pc的六位
	
    output wire regwrite, // 是否寄存器堆
    output wire regdst,		// 写入寄存器堆的地址是 rt 还是 rd,0 为 rt,1 为 rd
    output wire alusrc,		// 送入 ALU B 端口的值是立即数的 32 位扩展/寄存器堆读取的值
	output wire pcsrc,		// 下一个 PC 值是 PC+4/跳转的新地址
    output wire branch,		// 是否为 branch 指令，且满足 branch 的条件
    output wire memwrite,	// 是否需要写数据存储器
    output wire memtoreg,	// 回写的数据来自于 ALU 计算的结果/存储器读取的数据
    output wire jump,		// 是否为 jump 指令
    output wire [1:0] alu_op	 //ALU 控制信号，代表不同的运算类型
    );

reg [1:0] aluop_reg;
reg [7:0] sigs;		

assign alu_op = aluop_reg;
// 将所有控制信号变为一个大的八位控制信号位，除了aluop单独控制
assign {regwrite, regdst, alusrc, pcsrc, branch, memwrite, memtoreg, jump} = sigs;		



always@(*) begin
	case (op)
	// R-Type
		6'b000000: begin
			aluop_reg <= 2'b10;
			sigs <= 8'b1100_0000;
		end
		//  lw
		6'b100011: begin
			aluop_reg <= 2'b00;
			sigs <= 8'b1010_0010;
		end
		// sw
		6'b101011: begin
			aluop_reg <= 2'b00;
			sigs <= 8'b0x10_01x0;
		end
		// beq
		6'b000100: begin
			aluop_reg <= 2'b01;
			sigs <= 8'b0x01_10x0;
		end
		// addi
		6'b001000: begin
			aluop_reg <= 2'b00;
			sigs <= 8'b1010_0000;
		end
		// j
		6'b000010: begin
			aluop_reg <= 2'bxx;
			sigs <= 8'b0xxx_x0x1;
		end
		default: begin
			aluop_reg <= 2'b00;
			sigs <= 8'b0000_0000;
		end
	endcase
end

endmodule