`timescale 1ns/1ns
`define clock_period 20

module Mul_clk_tb();
    
    reg clk;
    wire out_clk;

    initial clk = 1;
    
    always #(`clock_period/2) 
        begin
            clk = ~clk;
        end

    initial 
        begin
            #(`clock_period*50);
            $stop;
        end

    frequency_divider div(.clk_in(clk), .clk_out(out_clk));

endmodule
