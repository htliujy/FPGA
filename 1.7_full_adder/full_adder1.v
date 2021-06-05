module full_adder1(
    input    Ai, Bi, Ci,
    output   So, Co);

    assign {Co, So} = Ai + Bi + Ci ;
endmodule