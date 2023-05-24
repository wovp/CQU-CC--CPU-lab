`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 11:45:19
// Design Name: 
// Module Name: testDatapath
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


module testDatapath(

    );
    reg clk;
	reg rst;
	wire jump; // 是否跳转的标志
	wire branch; // 是否是分支的标志
	wire alusrc;
	wire memtoreg;
	wire regwrite;
	wire regdst;
     wire [2:0] alucontrol;
     wire [31:0] instr;
     wire [31:0] readdata;
     wire [31:0] pc;
     wire [31:0] aluout;
     wire [31:0] writedata;
     wire zero;    // zero 是beq条件判断的输出信号
     assign jump = 0, branch = 0, alusrc = 0, memtoreg = 0, regwrite = 0, regdst = 0;
     datapath da(clk,rst,jump,branch,alusrc,memtoreg,regwrite,regdst,alucontrol,instr,readdata,pc,aluout,writedata,zero);
     
     initial begin 
		rst <= 1;
		#200;
		rst <= 0;
	end
	
	always begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end
endmodule
