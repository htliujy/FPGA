`timescale 1ns/1ns
 
module procedural_assignment ;
    reg [3:0]   ai, bi ;
    reg [3:0]   ai2, bi2 ;
    reg [3:0]   value_blk ;
    reg [3:0]   value_non ;
    reg [3:0]   value_non2 ;
 
    initial begin
        ai            = 4'd1 ;   //(1)
        bi            = 4'd2 ;   //(2)
        ai2           = 4'd7 ;   //(3)
        bi2           = 4'd8 ;   //(4)
        #20 ;                    //(5)
 
        //non-block-assigment with block-assignment
        ai            = 4'd3 ;     //(6)
        bi            = 4'd4 ;     //(7)
        value_blk     = ai + bi ;  //(8)
        value_non     <= ai + bi ; //(9)
 
        //non-block-assigment itself
        ai2           <= 4'd5 ;           //(10)
        bi2           <= 4'd6 ;           //(11)
        value_non2    <= ai2 + bi2 ;      //(12)
    end

    initial begin
        $dumpfile("procedural_assignment.vcd");
        $dumpvars;
    end

   //stop the simulation
    always begin
        #10 ;
        if ($time >= 1000) $finish ;
    end
 
endmodule
