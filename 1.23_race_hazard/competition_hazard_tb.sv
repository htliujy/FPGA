`timescale 1ns/1ns

module competition_hazard_tb ;
    reg          clk, rstn ;
    reg          en ;
    reg          din_rvs ;
    wire         flag_safe, flag_dgs ;

    //clock and rstn generating
    initial begin
        rstn              = 1'b0 ;
        clk               = 1'b0 ;
        #5 rstn           = 1'b1 ;
        forever begin
            #5 clk = ~clk ;
        end
    end

    initial begin
        en        = 1'b0 ;
        din_rvs   = 1'b1 ;
        #19 ;      en        = 1'b1 ;
        #1 ;       din_rvs   = 1'b0 ;
    end

    competition_hazard         u_dgs
     (
      .clk              (clk           ),
      .rstn             (rstn          ),
      .en               (en            ),
      .din_rvs          (din_rvs       ),
      .flag             (flag_dgs      ));

    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end

    initial begin
        $dumpfile("competition_hazard.vcd");
        $dumpvars(0);
    end

endmodule // test
