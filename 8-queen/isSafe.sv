
`timescale 1ns/1ns

module isSafe (
    input [7:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8,
    output isSafe
);
    wire vertical_Check, diag_Check1, diag_Check2; 
    wire [7:0] Sums [0:7];
    wire [2:0] diag_sum1 [0:14], diag_sum2 [0:14];

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign Sums[i] = reg1[i] + reg2[i] + reg3[i] + reg4[i] + reg5[i] + reg6[i] + reg7[i] + reg8[i];
        end
    endgenerate

    assign diag_sum1[0]  = reg1[0] + reg2[1] + reg3[2] + reg4[3] + reg5[4] + reg6[5] + reg7[6] + reg8[7];
    assign diag_sum1[1]  = reg1[1] + reg2[2] + reg3[3] + reg4[4] + reg5[5] + reg6[6] + reg7[7];
    assign diag_sum1[2]  = reg1[2] + reg2[3] + reg3[4] + reg4[5] + reg5[6] + reg6[7];
    assign diag_sum1[3]  = reg1[3] + reg2[4] + reg3[5] + reg4[6] + reg5[7];
    assign diag_sum1[4]  = reg1[4] + reg2[5] + reg3[6] + reg4[7];
    assign diag_sum1[5]  = reg1[5] + reg2[6] + reg3[7];
    assign diag_sum1[6]  = reg1[6] + reg2[7];
    assign diag_sum1[7]  = reg7[0] + reg8[1];
    assign diag_sum1[8]  = reg6[0] + reg7[1] + reg8[2];
    assign diag_sum1[9]  = reg5[0] + reg6[1] + reg7[2] + reg8[3];
    assign diag_sum1[10] = reg4[0] + reg5[1] + reg6[2] + reg7[3] + reg8[4];
    assign diag_sum1[11] = reg3[0] + reg4[1] + reg5[2] + reg6[3] + reg7[4] + reg8[5];
    assign diag_sum1[12] = reg2[0] + reg3[1] + reg4[2] + reg5[3] + reg6[4] + reg7[5] + reg8[6];
    assign diag_sum1[13] = reg7[7] + reg8[6];
    assign diag_sum1[14] = reg6[7] + reg7[6] + reg8[5];

    assign diag_sum2[0]  = reg1[7] + reg2[6] + reg3[5] + reg4[4] + reg5[3] + reg6[2] + reg7[1] + reg8[0];
    assign diag_sum2[1]  = reg1[6] + reg2[5] + reg3[4] + reg4[3] + reg5[2] + reg6[1] + reg7[0];
    assign diag_sum2[2]  = reg1[5] + reg2[4] + reg3[3] + reg4[2] + reg5[1] + reg6[0];
    assign diag_sum2[3]  = reg1[4] + reg2[3] + reg3[2] + reg4[1] + reg5[0];
    assign diag_sum2[4]  = reg1[3] + reg2[2] + reg3[1] + reg4[0];
    assign diag_sum2[5]  = reg1[2] + reg2[1] + reg3[0];
    assign diag_sum2[6]  = reg1[1] + reg2[0];
    assign diag_sum2[7]  = reg7[7] + reg8[6];
    assign diag_sum2[8]  = reg6[7] + reg7[6] + reg8[5];
    assign diag_sum2[9]  = reg5[7] + reg6[6] + reg7[5] + reg8[4];
    assign diag_sum2[10] = reg4[7] + reg5[6] + reg6[5] + reg7[4] + reg8[3];
    assign diag_sum2[11] = reg3[7] + reg4[6] + reg5[5] + reg6[4] + reg7[3] + reg8[2];
    assign diag_sum2[12] = reg2[7] + reg3[6] + reg4[5] + reg5[4] + reg6[3] + reg7[2] + reg8[1];
    assign diag_sum2[13] = reg1[7] + reg2[6] + reg3[5] + reg4[4] + reg5[3] + reg6[2] + reg7[1] + reg8[0];
    assign diag_sum2[14] = reg1[7] + reg2[6] + reg3[5] + reg4[4] + reg5[3] + reg6[2] + reg7[1] + reg8[0];

    assign vertical_Check = (Sums[0] > 1) || (Sums[1] > 1) || (Sums[2] > 1) || (Sums[3] > 1) ||
                            (Sums[4] > 1) || (Sums[5] > 1) || (Sums[6] > 1) || (Sums[7] > 1);

    assign diag_Check1 = (diag_sum1[0] > 1) || (diag_sum1[1] > 1) || (diag_sum1[2] > 1) || 
                         (diag_sum1[3] > 1) || (diag_sum1[4] > 1) || (diag_sum1[5] > 1) || 
                         (diag_sum1[6] > 1) || (diag_sum1[7] > 1) || (diag_sum1[8] > 1) || 
                         (diag_sum1[9] > 1) || (diag_sum1[10] > 1) || (diag_sum1[11] > 1) || 
                         (diag_sum1[12] > 1) || (diag_sum1[13] > 1) || (diag_sum1[14] > 1);

    assign diag_Check2 = (diag_sum2[0] > 1) || (diag_sum2[1] > 1) || (diag_sum2[2] > 1) || 
                         (diag_sum2[3] > 1) || (diag_sum2[4] > 1) || (diag_sum2[5] > 1) || 
                         (diag_sum2[6] > 1) || (diag_sum2[7] > 1) || (diag_sum2[8] > 1) || 
                         (diag_sum2[9] > 1) || (diag_sum2[10] > 1) || (diag_sum2[11] > 1) || 
                         (diag_sum2[12] > 1) || (diag_sum2[13] > 1) || (diag_sum2[14] > 1);

    assign isSafe = ~(vertical_Check | diag_Check1 | diag_Check2);

endmodule

module Reg_8bit(input clk, rst, ld, shift_en, input [7:0] in, output reg [7:0] out);
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 8'b0;
        else if (shift_en)
            out <= (out == 8'b00000001) ? 8'b10000000 : (out >> 1);
        else if (ld)
            out <= in;
    end
endmodule