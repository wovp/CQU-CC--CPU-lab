`timescale 1ns / 1ps

module sim();

// input
reg clk;
reg RST;
wire ena;

//output
wire jump;
wire branch;
wire alusrc;
wire memwrite;
wire memtoreg;
wire regwrite;
wire regdst;
wire pcsrc;
wire [2:0] alu_control;
//wire
wire [31:0] addr;
wire [31:0]douta;

pc pc(.clk(clk),.RST(RST),.ins_addr(addr),.inst_ce(ena));

blk_mem_gen_0 ram(.clka(clk),
                    .addra(addr),
                    .douta(douta),
                    .ena(ena),
					.wea(4'b0000),
					.dina(0)
					);
                    
controller controller(
    .instruction(douta),
    .jump(jump),
    .branch(branch),
    .alusrc(alusrc),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .regdst(regdst),
    .pcsrc(pcsrc),
    .alu_control(alu_control));

initial begin
    clk = 1;
    RST = 1;
    #50 RST = 0;
end


always #5 clk = ~ clk;
// 打印控制台信�?
always #10 $display("instruction: %h, memtoreg: %b, memwrite: %b, pcsrc: %b, alusrc: %b, regdst: %b, regwrite: %b, jump: %b, branch: %b, alu_control: %b",
					douta, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, branch, alu_control);

endmodule
