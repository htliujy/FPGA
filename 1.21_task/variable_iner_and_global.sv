`timescale 1ns/1ns

module variable_iner_and_global;

    //way1 to decirbe clk generating, not work
    task clk_rvs_iner ;
        output    clk_no_rvs ;
        begin
            # 5 ;     clk_no_rvs = 0 ;
            # 5 ;     clk_no_rvs = 1 ;
        end
    endtask
    reg          clk_test1 ;
    always clk_rvs_iner(clk_test1);

    //way2: use task to operate global varialbes to generating clk
    reg          clk_test2 ;
    task clk_rvs_global ;
        begin
            # 5 ;     clk_test2 = 0 ;
            # 5 ;     clk_test2 = 1 ;
        end
    endtask // clk_rvs_iner
    always clk_rvs_global;

    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end

    initial begin
        $dumpfile("variable_iner_and_global.vcd");
        $dumpvars(0);
    end

endmodule
