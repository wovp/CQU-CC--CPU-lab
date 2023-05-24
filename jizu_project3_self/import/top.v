`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:50:53
// Design Name: 
// Module Name: top
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


module top(
	input wire clk,rst,
	output wire [31:0]writedata,
	output wire [31:0] dataadr,
	output wire memwrite
    );
   	wire inst_ram_ena,data_ram_ena,data_ram_wea;
   	wire [31:0] pc, instr, alu_result, mem_rdata;
   	assign memwrite = data_ram_wea;
   	
   	// dataadr 是data-ram 取数据的地址，所以是由alu-out来决定的
	mips mips(
	    .clk(clk),
	    .rst(rst),
        .inst_ram_ena(inst_ram_ena),
        .data_ram_ena(data_ram_ena),
   	    .data_ram_wea(data_ram_wea),
   	    .pc(pc), 
   	    .instr(instr), 
   	    .alu_result(alu_result), 
   	    .mem_wdata(writedata), 
   	    .mem_rdata(mem_rdata)
	);
	assign dataadr = alu_result;
         // instr_ram
    instr_ram instr_ram1 (
    .clka(~clk),    // input wire clka
    .wea(4'b0000),      // input wire [3 : 0] wea
    .ena(inst_ram_ena),      // input wire ena
    .addra(pc),  // input wire [7 : 0] addra
    .dina(32'b0),    // input wire [31 : 0] dina
    .douta(instr)  // output wire [31 : 0] douta
    );
         // data_ram
//         wire tmp_data_ram_wea;
//         assign tmp_data_ram_wea = {3'b000,data_ram_wea};
    data_ram data_ram (
    .clka(~clk),    // input wire clka
    .wea({4{data_ram_wea}}),      // input wire [3 : 0] wea write enable   wea = 4'b1, when write
//    .wea(4'b1),
    .ena(1'b1),              // input wire ena
    .addra(alu_result),  // input wire [9 : 0] addra
    .dina(writedata),    // input wire [31 : 0] dina     
    .douta(mem_rdata)  // output wire [31 : 0] douta
     );
endmodule
