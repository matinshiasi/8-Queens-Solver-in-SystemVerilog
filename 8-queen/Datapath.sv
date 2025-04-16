module DataPath (
    input clk, rst, 
    input [7:0] dataInput, 
    input count_En, count_Init, 
    input [8:1] load_Reg, shift_En, init_Reg, 
    output reg isSafe, 
    output reg countCarryOut, 
    output reg [7:0] out1, out2, out3, out4, out5, out6, out7, out8
);

    logic [7:0] in2, in3, in4, in5, in6, in7, in8;
    logic [2:0] ps;
    logic [1:0] countOut;

    Reg_8bit reg1 (clk, init_Reg[1], load_Reg[1], shift_En[1], dataInput, out1);
    Reg_8bit reg2 (clk, init_Reg[2], load_Reg[2], shift_En[2], in2, out2);
    Reg_8bit reg3 (clk, init_Reg[3], load_Reg[3], shift_En[3], in3, out3);
    Reg_8bit reg4 (clk, init_Reg[4], load_Reg[4], shift_En[4], in4, out4);
    Reg_8bit reg5 (clk, init_Reg[5], load_Reg[5], shift_En[5], in5, out5);
    Reg_8bit reg6 (clk, init_Reg[6], load_Reg[6], shift_En[6], in6, out6);
    Reg_8bit reg7 (clk, init_Reg[7], load_Reg[7], shift_En[7], in7, out7);
    Reg_8bit reg8 (clk, init_Reg[8], load_Reg[8], shift_En[8], in8, out8);

    always @(*) begin
        in2 = (out1 >> 1 > 0) ? (out1 >> 1) : 8'b10000000;
        in3 = (out2 >> 1 > 0) ? (out2 >> 1) : 8'b10000000;
        in4 = (out3 >> 1 > 0) ? (out3 >> 1) : 8'b10000000;
        in5 = (out4 >> 1 > 0) ? (out4 >> 1) : 8'b10000000;
        in6 = (out5 >> 1 > 0) ? (out5 >> 1) : 8'b10000000;
        in7 = (out6 >> 1 > 0) ? (out6 >> 1) : 8'b10000000;
        in8 = (out7 >> 1 > 0) ? (out7 >> 1) : 8'b10000000;
    end

    always @(posedge clk, posedge rst) begin
        if (rst) 
            ps <= 3'b0;
        else if (count_Init) 
            ps <= 3'b0;
        else if (count_En) 
            ps <= ps + 3'b001;
    end

    assign countCarryOut = (count_En) ? (ps == 3'b111) : 1'b0;

    isSafe safe(out1, out2, out3, out4, out5, out6, out7, out8, isSafe);
endmodule