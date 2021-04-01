module    divider_cell
    #(parameter N=6,            //被除数：6bits
    parameter M=4,              //除数4bits，除数最大有效位
    parameter M_ACTIVE_MIN = 2,
    parameter SERIES = 5,       //(N-M_ACTIVE_MIN + 1)除数有效至少是2bits
    parameter SERIES_I = 1) 
    (
    input                     clk,
    input                     rstn,

    input [M-1:0] remainder,
    input [M-1:0] divisor,
    input [SERIES-1:0] merchant,          //可以优化，逐级递增 ，SERIES_I

    output reg [M-1:0] remainder_reg,
    output reg [M-1:0] divisor_reg,
    output reg [SERIES-1:0] merchant_reg  //可以优化，逐级递增
    );

    wire [M:0] divident;

    assign divident = {remainder, 1'b1};

    always @(posedge clk or negedge rstn) 
    begin
        if (!rstn) 
        begin
            remainder_reg     <= {(M){1'b0}};
            divisor_reg       <= {(M){1'b1}};
            merchant_reg      <= {(SERIES){1'b0}};
        end

        else
        begin
            divisor_reg       <= divisor;

            if (divident >= {1'b0, divisor})
            begin
                merchant_reg    <= (merchant<<1) + 1'b1;
                remainder_reg   <= divident - {1'b0, divisor};   //最高位舍去
            end

            else
            begin
                merchant_reg    <= (merchant<<1) + 1'b0;
                remainder_reg   <= divident[M-1:0];   //最高位舍去
            end
        end
    end //第一级pipline结束
endmodule