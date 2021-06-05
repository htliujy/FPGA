module full_adder2(
    input    Ai, Bi, Ci,
    output   So, Co);

    assign So = Ai ^ Bi ^ Ci ;
    assign Co = (Ai & Bi) | (Ci & (Ai | Bi));
endmodule