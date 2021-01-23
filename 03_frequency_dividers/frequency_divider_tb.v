`timescale 1ns/1ns
`define clock_period 20

module frequency_divider_tb();
    
    reg clk;
    wire out_clk;

    initial clk = 1;
    
    always #(`clock_period/2) 
        begin
            clk = ~clk;
        end

    initial 
        begin
            $dumpfile("test.vcd");
            $dumpvars;
            #(`clock_period*100);
            $finish;
        end

    frequency_divider #(12) f_divider (.clk_in(clk), .clk_out(out_clk));

endmodule
