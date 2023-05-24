`timescale 1ns / 1ps

module pc(
    input clk,
    input RST,
    output [31:0]ins_addr,	
    output reg inst_ce			
    );
	
reg [31:0] data = 32'b0;

always@(posedge clk or posedge RST) begin
    if(RST) begin	
        inst_ce <= 0;
        data <= 32'b0;
	end
    else begin
        inst_ce <= 1;	
        // ʮ�����Ƶģ���Ϊcoe�ļ�ֻ������ָ�������Ҫ�������ں�ѭ��Ϊ0
//		if(data >= 32'h00000014 && clk) begin
//			data <= 0;
//		end
		if(clk) begin
			data <= data + 32'h00000004;
		end
	end
end

assign ins_addr = data;

endmodule
