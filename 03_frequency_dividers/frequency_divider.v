// just for test
// ref(菜鸟初入FPGA之任意等分频和倍频):http://blog.chinaaet.com/Augus/p/5100001263

module frequency_divider(
    clk_in, rst_n, clk_out
);
    input rst_n, clk_in;
    output clk_out;
    parameter N = 7; //分频系数，可否作为输入参数传递？

    reg out_clk_1; //时钟上升沿信号；
    reg [9:0]cnt_1; //计数器（上升沿计数）

    always @(posedge clk_in or negedge rst_n) 
    begin
        if (!rst_n) 
            begin
                cnt_1 <= 1'd0;
                out_clk_1 <= 1'd0;
            end

        else 
            begin
                if(cnt_1 <= ((N-1)/2)-1) //2
                    begin
                        cnt_1 <= cnt_1 + 1'd1;
                        out_clk_1 <= 1'd1;
                    end
                else if (cnt_1 <= (N-2))
                    begin
                        cnt_1 <= cnt_1 + 1'd1;
                        out_clk_1 <= 1'd0;
                    end
                else begin
                    cnt_1 <= 1'd0;
                    out_clk_1 <= 1'd0;
                end
            end
    end

    reg out_clk_0; //时钟下降沿产生的信号
    reg [9:0] cnt_0; //下降沿时钟产生的信号

    always @(negedge clk_in or negedge rst_n) 
    begin
        if (!rst_n) begin
            cnt_0 <= 1'd0;
            out_clk_0 <= 1'd0;
        end
        else begin
            if(cnt_0 <= cnt_0 <= ((( N-1 )/2)-1))
                begin
                    cnt_0 <= cnt_0 + 1'd1;
                    out_clk_0 <= 1'd1;
                end
            else if (cnt_0 <= (N-2)) 
                begin
                    cnt_0 <= cnt_0 + 1'd1;
                    out_clk_0 <= 1'd0;
                end
            else
                begin
                    cnt_0 <= 1'd0;
                    out_clk_0 <= 1'd0;
                end
        end
    end

    assign clk_out = out_clk_1 | out_clk_0;

endmodule
