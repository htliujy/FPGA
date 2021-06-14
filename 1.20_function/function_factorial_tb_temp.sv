`timescale 1ns/1ns

module function_factorial_tb ;
    wire [31:0] factorial_with_auto;

    function_factorial factorial_test(
        .results_auto(factorial_with_auto)
    );

   initial begin
      forever begin
         #100;
         if ($time >= 1000)  $finish ;
      end
   end

    initial begin
        $dumpfile("function_factorial.vcd");
        $dumpvars(0);
    end

endmodule
