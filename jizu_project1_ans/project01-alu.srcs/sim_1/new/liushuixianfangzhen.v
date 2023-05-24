`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2023 02:55:52 PM
// Design Name: 
// Module Name: liushuixianfangzhen
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


module liushuixianfangzhen( );
    reg [31:0] cin_a;
    reg [31:0] cin_b;
    reg [0:0]clk;
    reg [3:0]rst;
    reg cin;
    reg [3:0]stop;
    wire cout;
    wire [31:0] sum;
    
    
    initial begin
        clk = 1;
        rst = 0;
        stop = 0;
        cin_a = 32'h0000_0000;cin_b=32'h0000_0000;cin=1'b0;
 @(posedge clk) 
        
                       cin_a = 32'h0000_0000;cin_b=32'h0000_1000;cin=1'b0;
        @(posedge clk) cin_a = 32'h0000_0000;cin_b=32'h0000_1000;cin=1'b0;
        @(posedge clk) cin_a = 32'h0000_0001;cin_b=32'h0000_1001;cin=1'b0;
        @(posedge clk) cin_a = 32'h0000_0010;cin_b=32'h0000_1001;cin=1'b0;
        @(posedge clk) cin_a = 32'h0000_0100;cin_b=32'h0000_1001;cin=1'b0;
        @(posedge clk) cin_a = 32'h0000_1000;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) cin_a = 32'h0001_0000;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) cin_a = 32'h0010_0000;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) stop=4'b0010;cin_a = 32'h0100_0000;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) stop=4'b0010;cin_a = 32'h1000_0001;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) stop=4'b0010;cin_a = 32'h1000_1111;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) stop=4'b0010;cin_a = 32'h1000_0001;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) stop=4'b0000;cin_a = 32'h1000_0001;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) cin_a = 32'h1000_0001;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) rst=4'b0100;cin_a = 32'h1000_0001;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk)  rst=3'b000;cin_a = 32'h1000_0011;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) cin_a = 32'h1000_1011;cin_b=32'h0000_1001;cin=1'b1;
        @(posedge clk) cin_a = 32'h1000_0111;cin_b=32'h0000_1001;cin=1'b1;
       repeat(10) @(posedge clk);
        $finish;       
    end
    
    always #10  clk = ~clk;

    pipline a(cin_a,cin_b,cin,clk,stop,rst,cout,sum);

endmodule

