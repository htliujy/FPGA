module test_default_width_bits();
s
mula = -4'd4 ;
mulb = 2 ;
res = mula * mulb ;      //计算结果为res=-6'd8, 即res=6'h38，正常
res = mula * (-'d4) ;    //(4的32次幂-4) * 2, 结果异常

endmodule