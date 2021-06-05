`timescale 1ns/1ns
 
module test ;
    reg Ai, Bi, Ci;
    wire So, Co ;

    initial begin
        $dumpfile("full_adder1.vcd");
        $dumpvars;
        {Ai, Bi, Ci}      = 3'b0;
        forever begin
            #10 ;
            {Ai, Bi, Ci}      = {Ai, Bi, Ci} + 1'b1;
        end
    end

    full_adder1  u_adder(
        .Ai      (Ai),
        .Bi      (Bi),
        .Ci      (Ci),
        .So      (So),
        .Co      (Co));

    initial begin
        forever begin
            #100;
            //$display("---gyc---%d", $time);
            if ($time >= 1000) begin
            $finish ;
            end
        end
    end

endmodule