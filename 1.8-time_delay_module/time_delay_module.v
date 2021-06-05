module time_delay_module(
    input   ai, bi,
    output  so_lose, so_get, so_normal);
 
    assign #20      so_lose      = ai & bi ;
    assign  #5      so_get       = ai & bi ;
    assign          so_normal    = ai & bi ;
endmodule