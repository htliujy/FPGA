module    divider_man
    #(parameter N=6,               //被除数：6bits
    parameter M=4,               //除数4bits，除数最大有效位
    parameter M_ACTIVE_MIN = 2,
    parameter SERIES = 5 )       //(N-M_ACTIVE_MIN + 1)除数有效至少是2bits
    (
    input                     clk,
    input                     rstn,
    input [M-1:0]             divisor,
    //input [M:0]               dividend, 不要，这个为常数。
    //39'b100_0000_0000_0000_0000_0000_0000_0000_0000_0000
    //或38'b11_1111_1111_1111_1111_1111_1111_1111_1111_1111
    //例程先使用：6'b11_1111
    output [SERIES-1:0]        merchant , //需要使用除数最小有效位计算N-M_ACTIVE_MIN+1-1 = N-M_ACTIVE_MIN
    output [M-1:0]        remainder             //需要使用除数最大有效位计算：
    );

    wire [M-1:0] remainder_t[0:SERIES-1];
    wire [M-1:0] divisor_t[0:SERIES-1];
    wire [SERIES-1:0] merchant_t[0:SERIES-1];
    
    //第一级
    divider_cell #(.N(N), .M(M), .M_ACTIVE_MIN(M_ACTIVE_MIN), .SERIES(SERIES), .SERIES_I(SERIES))
    divider_step0(
        .clk                (clk),
        .rstn               (rstn),

        //input
        .remainder          ({{(M-M_ACTIVE_MIN + 1){1'b0}}, {(M_ACTIVE_MIN - 1){1'b1}}}), //{{(M){1'b0}}, dividend[N-1]}
        .divisor            (divisor),
        .merchant           ({(SERIES){1'b0}}),

        //output
        .remainder_reg      (remainder_t[0]),
        .divisor_reg        (divisor_t[0]),
        .merchant_reg       (merchant_t[0])
    );

    genvar                  i;
    generate
        for(i=1; i <= (SERIES-1); i=i+1) 
        begin: sqrt_stepx
            divider_cell      #(.N(N), .M(M), .M_ACTIVE_MIN(M_ACTIVE_MIN), .SERIES(SERIES), .SERIES_I(i))
            divider_step_s
            (
            .clk              (clk),
            .rstn             (rstn),

            //input
            .remainder          (remainder_t[i-1]), //{{(M){1'b0}}, dividend[N-1]}
            .divisor            (divisor_t[i-1]),
            .merchant           (merchant_t[i-1]),

            //output
            .remainder_reg      (remainder_t[i]),
            .divisor_reg        (divisor_t[i]),
            .merchant_reg       (merchant_t[i])
            );
        end // block: sqrt_stepx
    endgenerate

    assign merchant = merchant_t[SERIES-1];
    assign remainder = remainder[SERIES-1];

endmodule
