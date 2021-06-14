module function_factorial
    (output wire [31:0] results_auto);
    parameter fact = 4;

    results_auto = factorial(fact);

    function automatic integer factorial ;
        input integer     data ;
        integer           i ;
        begin
            factorial = (data>=2)? data * factorial(data-1) : 1 ;
        end
    endfunction // factorial

endmodule