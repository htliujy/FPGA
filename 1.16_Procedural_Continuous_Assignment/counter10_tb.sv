`timescale 1ns/1ns
 
module counter10_tb ;
    reg          rstn ;
    reg          clk ;
    wire [3:0]    cnt ;
    wire         cout ;
 
    counter10     u_counter (
        .rstn    (rstn),
        .clk     (clk),
        .cnt     (cnt),
        .cout    (cout));
 
    initial begin
        clk       = 0 ;
        rstn      = 0 ;
        #10 ;
        rstn      = 1'b1 ;
        wait (counter10_tb.u_counter.cnt_temp == 4'd4) ;
        @(negedge clk) ;
        force     counter10_tb.u_counter.cnt_temp = 4'd6 ;
        force     counter10_tb.u_counter.cout     = 1'b1 ;
        #40 ;
        @(negedge clk) ;
        release   counter10_tb.u_counter.cnt_temp ;
        release   counter10_tb.u_counter.cout ;
    end
 
    initial begin
        clk = 0 ;
        forever #10 clk = ~ clk ;
    end
 
    //finish the simulation
    always begin
        #1000;
        if ($time >= 1000) $finish ;
    end

        initial begin
        $dumpfile("counter10_tb.vcd");
        $dumpvars;
    end

endmodule