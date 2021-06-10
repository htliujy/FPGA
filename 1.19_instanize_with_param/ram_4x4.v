module  ram_4x4
    (
     input               CLK ,
     input [4-1:0]       A ,
     input [4-1:0]       D ,
     input               EN ,
     input               WR ,    //1 for write and 0 for read
     output reg [4-1:0]  Q    );
 
    parameter        MASK = 3 ;
 
    reg [4-1:0]     mem [0:(1<<4)-1] ;
    always @(posedge CLK) begin
        if (EN && WR) begin
            mem[A]  <= D & MASK;
        end
        else if (EN && !WR) begin
            Q       <= mem[A] & MASK;
        end
    end
 
endmodule