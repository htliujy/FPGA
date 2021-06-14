`timescale 1ns/1ns

module  task_auto;

    reg clk;

    task automatic test_flag ;
        input [3:0]       cnti ;
        input             en ;
        output [3:0]      cnto ;
        if (en) cnto = cnti ;
    endtask

    reg          en_cnt ;
    reg [3:0]    cnt_temp ;
    initial begin
            en_cnt    = 1 ;
            cnt_temp  = 0 ;
            #25 ;     en_cnt = 0 ;
    end
    always #10 cnt_temp = cnt_temp + 1 ;

    reg [3:0]             cnt1, cnt2 ;
    always @(posedge clk) test_flag(2, en_cnt, cnt1);       //task(1)
    always @(posedge clk) test_flag(cnt_temp, !en_cnt, cnt2);//task(2)

    always begin
        #5 ;     clk = 0;
        #5 ;     clk = 1;
    end
    
    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end

    initial begin
        $dumpfile("task_auto.vcd");
        $dumpvars(0);
    end

endmodule