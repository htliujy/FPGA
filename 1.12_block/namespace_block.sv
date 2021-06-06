`timescale 1ns/1ns
 
module namespace_block;
 
    initial begin: runoob   //命名模块名字为runoob，分号不能少
        integer    i ;       //此变量可以通过test.runoob.i 被其他模块使用
        i = 0 ;
        forever begin
            #10 i = i + 10 ;       
        end
    end
 
    reg stop_flag ;
    initial stop_flag = 1'b0 ;
    always begin : detect_stop
        if ( namespace_block.runoob.i == 100) begin //i累加10次，即100ns时停止仿真
            $display("Now you can stop the simulation!!!");
            stop_flag = 1'b1 ;
        end
        #10 ;
    end

    initial begin
        $dumpfile("namespace_block.vcd");
        $dumpvars(0, namespace_block);
    end

endmodule
