`timescale 1ns/1ns

module function_factorial;
   wire [31:0]          results_auto = factorial(4);
   function automatic   integer         factorial ;
      input integer     data ;
      integer           i ;
      begin
         factorial = (data>=2)? data * factorial(data-1) : 1 ;
      end
   endfunction // factorial
   //no automatic
   wire [31:0]          results_noauto = factorial_no(4);
   function    integer         factorial_no ;
      input integer     data ;
      integer           i ;
      begin
         factorial_no = (data>=2)? data * factorial_no(data-1) : 1 ;
      end
   endfunction // factorial

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