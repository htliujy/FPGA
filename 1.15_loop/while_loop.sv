`timescale 1ns/1ns
 
module while_loop ;
 
    reg [3:0]    counter ;
    initial begin
        counter = 'b0 ;
        while (counter<=10) begin
            #10 ;
            counter = counter + 1'b1 ;
        end
    end
 
   //stop the simulation
    always begin
        #10 ;  if ($time >= 1000) $finish ;
    end

    initial begin
        $dumpfile("while_loop.vcd");
        $dumpvars(0, while_loop);
    end
 
endmodule