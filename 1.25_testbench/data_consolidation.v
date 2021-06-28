module  data_consolidation
    (
        input           clk ,
        input           rstn ,
        input [1:0]     din ,          //data in
        input           din_en ,
        output [7:0]    dout ,
        output          dout_en        //data out
     );

   // data shift and counter
    reg [7:0]            data_r ;
    reg [1:0]            state_cnt ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state_cnt     <= 'b0 ;
            data_r        <= 'b0 ;
        end
        else if (din_en) begin
            state_cnt     <= state_cnt + 1'b1 ;    //数据计数
            data_r        <= {data_r[5:0], din} ;  //数据拼接
        end
        else begin
            state_cnt <= 'b0 ;
            data_r <= data_r ;    //这句不写会怎样？不会
        end
    end
    assign dout          = data_r ;

    // data output en
    reg                  dout_en_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dout_en_r       <= 'b0 ;
        end
        //计数为 3 且第 4 个数据输入时，同步输出数据输出使能信号
        else if ((state_cnt == 2'd3) & din_en) begin  // 我不喜欢(state_cnt == 2'd3 & din_en)这种写法，于是改为 ((state_cnt == 2'd3) & din_en)
            dout_en_r       <= 1'b1 ;
        end
        else begin
            dout_en_r       <= 1'b0 ;
        end
    end
    //这里不直接声明dout_en为reg变量，而是用相关寄存器对其进行assign赋值
    assign dout_en       = dout_en_r;

endmodule
