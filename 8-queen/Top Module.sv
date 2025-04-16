
module TopModule (
    input clk, rst, START,
    input [7:0] reg1Bus,
    output reg [7:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8,
    output reg DONE,
    output logic NO_SOLUTION
); 
    logic counten, countiz;
    logic [8:1] ldreg, shen, initreg;
    logic isSafe, countCo;

    DataPath D1 (clk, rst, reg1Bus, counten, countiz, ldreg, shen, initreg, isSafe, countCo, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8);
    Controller C1 (clk, rst, START, isSafe, countCo, counten, countiz, ldreg, shen, initreg, DONE, NO_SOLUTION);
endmodule