`timescale 1ns / 1ps

module maindec(
    input [5:0] op,	//  ����Ǹ�pc����λ
	
    output wire regwrite, // �Ƿ�Ĵ�����
    output wire regdst,		// д��Ĵ����ѵĵ�ַ�� rt ���� rd,0 Ϊ rt,1 Ϊ rd
    output wire alusrc,		// ���� ALU B �˿ڵ�ֵ���������� 32 λ��չ/�Ĵ����Ѷ�ȡ��ֵ
	output wire pcsrc,		// ��һ�� PC ֵ�� PC+4/��ת���µ�ַ
    output wire branch,		// �Ƿ�Ϊ branch ָ������� branch ������
    output wire memwrite,	// �Ƿ���Ҫд���ݴ洢��
    output wire memtoreg,	// ��д������������ ALU ����Ľ��/�洢����ȡ������
    output wire jump,		// �Ƿ�Ϊ jump ָ��
    output wire [1:0] alu_op	 //ALU �����źţ�����ͬ����������
    );

reg [1:0] aluop_reg;
reg [7:0] sigs;		

assign alu_op = aluop_reg;
// �����п����źű�Ϊһ����İ�λ�����ź�λ������aluop��������
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