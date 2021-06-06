`timescale 1ns/1ns
 
module para_sequen_block ;
    reg [3:0]   ai_sequen, bi_sequen ;
    reg [3:0]   ai_paral,  bi_paral ;
    reg [3:0]   ai_nonblk, bi_nonblk ;
    reg [3:0]   ai_nonblk_sequen, bi_nonblk_sequen ;

 //============================================================//
    //(1)Sequence block
    initial begin
        #5 ai_sequen         = 4'd5 ;    //at 5ns
        #5 bi_sequen         = 4'd8 ;    //at 10ns
    end
    //(2)fork block
    initial fork
        #5 ai_paral          = 4'd5 ;    //at 5ns
        #5 bi_paral          = 4'd8 ;    //at 5ns
    join
    //(3)non-block block
    initial fork
        #5 ai_nonblk         <= 4'd5 ;    //at 5ns
        #5 bi_nonblk         <= 4'd8 ;    //at 5ns
    join

    //(non-block-with-begin-end )
    initial begin
        #5 ai_nonblk_sequen         <= 4'd5 ;    //at 5ns
        #5 bi_nonblk_sequen         <= 4'd8 ;    //at 5ns
    end

    initial begin
        $dumpfile("para_sequen_block.vcd");
        $dumpvars;
    end

    always begin
        #10;
        if ($time >= 20) begin
            $finish ;
        end
    end

endmodule
