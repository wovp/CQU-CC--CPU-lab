`timescale 1ns / 1ps

module clk_div(
    input Mhz,
    input RST,
    output reg hz
    );

reg [27:0] count;

always@(posedge Mhz or posedge RST) begin
    if(RST) begin
        hz <= 1'b0;
		count <= 27'b0;
    end
    else begin
		if(count + 1 >= 27'd100_000_000) begin
			count <= 27'b0;
			hz <= ~hz;
		end
		else
			count <= count + 27'b1;
	end
end
endmodule
