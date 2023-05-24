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
        // 十六进制的，因为coe文件只有六个指令，所以需要六次周期后循环为0
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
