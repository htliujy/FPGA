// ref：Verilog code for SR flip-flop – All modeling styles<https://technobyte.org/sr-flip-flop-verilog-gate-dataflow-behavioral/>
//an SR flip flop.

module SR_FF(s, r, clk, q_out, qbar_out);
    input s, r, clk;
    output reg q_out, qbar_out;
    always @(posedge clk ) begin
        if (s == 1) begin //判断语句中，==和<= 什么区别？
            q_out <= 1;
            qbar_out <= 0;
        end
        else if(r == 1) begin
            q_out <= 0;
            qbar_out <= 1;
        end
        else if (s == 0 & r == 0) begin
            q_out <= q_out;
            qbar_out <= qbar_out;
        end
    end
endmodule
