`timescale 1ns/1ns
 
module repeat_loop ;
 
    reg clk;
    reg rstn;
    reg enable;
    reg [3:0] j;
    reg [3:0] buffer[7:0];

    // repeat 循环语句
    reg [3:0]    counter3 ;
    initial begin
        counter3 = 'b0 ;
        repeat (11) begin  //重复11次
            #10 ;
            counter3 = counter3 + 1'b1 ;
        end
    end

    initial begin
        clk = 0;
        rstn = 1;
        enable = 0;
        #3 rstn = 0;
        #3 rstn = 1;
        enable = 1;
    end

    always begin
        #5 clk=~clk;
    end



    always @(posedge clk or negedge rstn) begin
        j = 0  ;
        if (!rstn) begin
            repeat (8) begin
                buffer[j]   = 'b0 ;      //没有延迟的赋值，即同时赋值为0
                j = j + 1 ;     //为何阻塞和非阻塞写在一个block里？
            end
        end

        else if (enable) begin
            repeat (8) begin
                @(negedge clk) buffer[j]    <= counter3 ;       //在下一个clk的上升沿赋值
                j <= j + 1 ;
            end
        end
    end

   //stop the simulation
    always begin
        #10 ;  if ($time >= 200) $finish ;
    end
    
    initial begin
        $dumpfile("repeat_loop.vcd");
        $dumpvars(0,repeat_loop,buffer[0],buffer[1],buffer[2],buffer[3],buffer[4],buffer[5],buffer[6],buffer[7]);
    end
    /*
    integer idx;
    initial begin
        for (idx = 0; idx < 32; idx = idx + 1)begin
            $dumpvars(0,repeat_loop.buffer[idx]);
        end
    end
    */

    /*//还是没有什么用处。
    generate
    genvar idx;
    for(idx = 0; idx < 16; idx = idx+1) begin : buffer_array_dump
        wire [3:0] buffer_idx;
        assign buffer_idx = buffer[idx];
    end
    endgenerate
    */
    /*
    generate
    genvar idx;
    for (idx = 0; idx < 16; idx = idx + 1) begin
        initial $dumpvars(0, buffer[idx]);
    end
    endgenerate
    */

endmodule
