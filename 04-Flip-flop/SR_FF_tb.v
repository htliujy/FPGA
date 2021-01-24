//test SR flip flop 

`timescale 1ns/1ns
`define clock_period 20

module SR_FF_tb();

    //1. Declare module and ports
    reg S, R, CLK;
    wire Q, QBAR;

    //2. Instantiate the module we want to test. We have instantiated the srff_behavior
    SR_FF sr_ff_dut(.s(S), .r(R), .clk(CLK), .q_out(Q), .qbar_out(QBAR));

    //3. Monitor, do not have monitor.

    //4. test vectors
    initial begin
        CLK=0;
        forever begin
            #(`clock_period/2) CLK = ~CLK;
        end
    end

    initial begin
        S= 1; R= 0;
        #100; S= 0; R= 1;
        #100; S= 0; R= 0;
        #100;  S= 1; R=1;
    end

    //5. dump wave file of the testbench.
    initial begin
        $dumpfile("SR_FF_test.vcd");
        $dumpvars;
        #(`clock_period*100);
        $finish;
    end

endmodule