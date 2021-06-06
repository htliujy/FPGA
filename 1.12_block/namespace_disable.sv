`timescale 1ns/1ns
 
module namespace_disable;
 
    initial begin: runoob_d //命名模块名字为runoob_d
        integer    i_d ;
        i_d = 0 ;
        while(i_d<=100) begin: runoob_d2
            # 10 ;
            if (i_d >= 50) begin       //累加5次停止累加
                disable runoob_d3.clk_gen ;//stop 外部block: clk_gen
                disable runoob_d2 ;       //stop 当前block: runoob_d2
            end
            i_d = i_d + 10 ;
        end
    end
 
    reg clk ;
    initial begin: runoob_d3
        while (1) begin: clk_gen  //时钟产生模块
            clk=1 ;      #10 ;
            clk=0 ;      #10 ;
        end
    end

    initial begin
        $dumpfile("namespace_disable.vcd");
        $dumpvars(0, namespace_disable);
    end
 
endmodule