`timescale 1ns/1ns
 
module test ;
    parameter    AW = 4 ;
    parameter    DW = 4 ;
 
    reg                  clk ;
    reg [AW:0]           a ;
    reg [DW-1:0]         d ;
    reg                  en ;
    reg                  wr ;
    wire [DW-1:0]        q ;
 
    //clock generating
    always begin
        #15 ;     clk = 0 ;
        #15 ;     clk = 1 ;
    end
 
    initial begin
        a         = 10 ;
        d         = 2 ;
        en        = 'b0 ;
        wr        = 'b0 ;
        repeat(10) begin
            @(negedge clk) ;
            en     = 1'b1;
            a      = a + 1 ;
            wr     = 1'b1 ;  //write command
            d      = d + 1 ;
        end
        a         = 10 ;
        repeat(10) begin
            @(negedge clk) ;
            a      = a + 1 ;
            wr     = 1'b0 ;  //read command
        end
    end // initial begin
 
    //instantiation
    defparam     u_ram_4x4.MASK = 7 ;
    ram_4x4    u_ram_4x4
    (
        .CLK    (clk),
        .A      (a[AW-1:0]),
        .D      (d),
        .EN     (en),
        .WR     (wr),    //1 for write and 0 for read
        .Q      (q)
     );

    initial begin
        $dumpfile("ram_4x4.vcd");
        $dumpvars(0);
    end
 
    //stop simulation
    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end
 
endmodule // test