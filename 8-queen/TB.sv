`timescale 1ns / 1ns

module TB;
    reg clk, rst, START;
    reg [7:0] inputData;
    wire [7:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8;
    wire DONE, NO_SOLUTION;
    TopModule uut (
        .clk(clk), .rst(rst), .START(START), 
        .reg1Bus(inputData),
        .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4),
        .reg5(reg5), .reg6(reg6), .reg7(reg7), .reg8(reg8),
        .DONE(DONE), .NO_SOLUTION(NO_SOLUTION)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        START = 0;
        inputData = 8'b00010000;

        #20 rst = 0;
        
        #20 START = 1; 
        #20 START = 0;
        
        #50; 
        
        #20 rst = 1;
        #20 rst = 0;

        inputData = 8'b11111111; 
        #20 START = 1;
        #20 START = 0;
        
        #100; 

        inputData = 8'b00000001; 
        #20 START = 1;
        #20 START = 0;

        #20 rst = 1;
        #20 rst = 0;
        inputData = 8'b00000001; 
        
        #20 START = 1;
        #20 START = 0;
        
        #500 $stop;
    end
endmodule

