`timescale 1ns/1ns

module test ;

    parameter    N = 39 ;
    parameter    M = 30 ;
    parameter    M_ACTIVE_MIN = 12;
    parameter    SERIES = 28;    //(N-M_ACTIVE_MIN + 1)除数有效至少是2bits

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
        #2;
        rstn      = 1'b0 ;
        #5 ;
        rstn      = 1'b1 ;

        #25 ;

        divisor      = 12'b1000_0000_0000;

        repeat(32)    #10   divisor   = divisor + 1 ;
        #10;
        divisor     = 30'b01_0000_0000_0000_0000_0000_0000_0000;
        repeat(32) #10   divisor   = divisor + 13 ;

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
            if ($time >= 10000)  $finish ;
        end
    end

    //dump signals to file
    initial begin
        $dumpfile("test_divider.vcd");
        $dumpvars;
    end

endmodule // test
