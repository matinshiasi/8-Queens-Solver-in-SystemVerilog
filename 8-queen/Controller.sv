
module Controller (
    input clk, rst, START, isSafe, countCo,
    output reg count_En, count_rst,
    output reg [8:1] load_reg, shift_En, init_reg,
    output reg DONE, No_Answer
);

    reg [3:0] ps, ns; 

    always @(*) begin
        {count_En, count_rst, load_reg, shift_En, init_reg, DONE, No_Answer} = 27'b0;
        
        case (ps)
            4'b0000: begin
                DONE = 1;
                No_Answer = 0; 
            end

            4'b0001: begin
                init_reg = 8'b11111111; 
            end

            4'b0010: begin
                {load_reg[1], load_reg[2]} = 2'b11; 
            end

            4'b0011: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[2] = ~isSafe;
                load_reg[3] = isSafe;
                init_reg[8:3] = (isSafe) ? 6'b0 : 6'b111111;
            end

            4'b0100: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[3] = ~isSafe;
                load_reg[4] = isSafe;
                init_reg[8:4] = (isSafe) ? 5'b0 : 5'b11111;
                shift_En[2] = (~isSafe & countCo);
            end

            4'b0101: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[4] = ~isSafe;
                load_reg[5] = isSafe;
                init_reg[8:5] = (isSafe) ? 4'b0 : 4'b1111;
                shift_En[3] = (~isSafe & countCo);
            end

            4'b0110: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[5] = ~isSafe;
                load_reg[6] = isSafe;
                init_reg[8:6] = (isSafe) ? 3'b0 : 3'b111;
                shift_En[4] = (~isSafe & countCo);
            end

            4'b0111: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[6] = ~isSafe;
                load_reg[7] = isSafe;
                init_reg[8:7] = (isSafe) ? 2'b0 : 2'b11;
                shift_En[5] = (~isSafe & countCo);
            end

            4'b1000: begin
                count_En = ~isSafe;
                count_rst = isSafe;
                shift_En[7] = (~isSafe & countCo);
                load_reg[8] = isSafe;
                init_reg[8] = (isSafe) ? 1'b0 : 1'b1;
            end
            
            4'b1001: begin
                DONE = 0; 
                No_Answer = 1; 
            end
        endcase
    end


    always @(*) begin
        ns = 4'b0000; 
        case (ps)
            4'b0000: ns = (START) ? 4'b0001 : 4'b0000; 
            4'b0001: ns = (START) ? 4'b0001 : 4'b0010; 
            4'b0010: ns = 4'b0011; 
            4'b0011: ns = (isSafe) ? 4'b0100 : 4'b0011; 
            4'b0100: ns = (isSafe) ? 4'b0101 : (~isSafe & countCo) ? 4'b0011 : 4'b0100; 
            4'b0101: ns = (isSafe) ? 4'b0110 : (~isSafe & countCo) ? 4'b0100 : 4'b0101; 
            4'b0110: ns = (isSafe) ? 4'b0111 : (~isSafe & countCo) ? 4'b0101 : 4'b0110; 
            4'b0111: ns = (isSafe) ? 4'b1000 : (~isSafe & countCo) ? 4'b0110 : 4'b0111; 
            4'b1000: ns = (isSafe) ? 4'b0000 : (~isSafe & countCo) ? 4'b0111 : 4'b1000; 
            default: ns = 4'b0000; 
        endcase
        
        if (ps == 4'b1000 && !isSafe && !countCo) begin
            ns = 4'b1001; 
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= 4'b0000; 
        else
            ps <= ns;
    end
endmodule