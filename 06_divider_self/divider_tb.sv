`timescale 1ns/1ns

module test ;

    parameter    N = 6 ;
    parameter    M = 4 ;
    parameter    M_ACTIVE_MIN = 2;
    parameter    SERIES = 5;

    reg          clk;
    reg          rstn ;

    reg [M-1:0]  divisor ;

    wire [SERIES-1:0] merchant ;
    wire [M-1:0] remainder ;

    //clock
    always begin
        clk = 0 ; #5 ;
        clk = 1 ; #5 ;
    end

    //driver
    initial begin
        rstn      = 1'b0 ;
        #7 ;
        rstn      = 1'b1 ;

        #25 ;

        divisor      = 2;

        repeat(32)    #10   divisor   = divisor + 1 ;

    end // initial begin

    //module instantiation
    divider_man  #(.N(N), .M(M), .M_ACTIVE_MIN(M_ACTIVE_MIN), .SERIES(SERIES))
    u_divider
    (
        .clk              (clk),
        .rstn             (rstn),
        //input
        .divisor          (divisor),    //[M-1:0]
        //output
        .merchant         (merchant),   //[SERIES-1:0]
        .remainder        (remainder)   //[M-1:0]
    );

    //simulation finish
    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end

    //dump signals to file
    initial begin
        $dumpfile("test_divider.vcd");
        $dumpvars;
    end

endmodule // test
