module competition_hazard
    (
      input             clk ,
      input             rstn ,
      input             en ,
      input             din_rvs ,
      output reg        flag
    );

    wire    condition = din_rvs & en ;  //combination logic
    always @(posedge clk or negedge !rstn) begin
        if (!rstn) begin
            flag   <= 1'b0 ;
        end
        else begin
            flag   <= condition ;
        end
    end

endmodule