module    divider_man
    #(parameter N=6,               //被除数：6bits
    parameter M=4,               //除数4bits，除数最大有效位
    parameter M_ACTIVE_MIN = 2,
    parameter SERIES = (N-M_ACTIVE_MIN + 1)) //除数有效至少是2bits
 (
      input                     clk,
      input                     rstn,
      input [M-1:0]             divisor,
      //input [M:0]               dividend, 不要，这个为常数。
      //39'b100_0000_0000_0000_0000_0000_0000_0000_0000_0000
      //或38'b11_1111_1111_1111_1111_1111_1111_1111_1111_1111
      //例程先使用：6'b11_1111
      output [N-M_ACTIVE_MIN:0]        merchant , //需要使用除数最小有效位计算N-M_ACTIVE_MIN+1-1 = N-M_ACTIVE_MIN
      output [M-1:0]        remainder             //需要使用除数最大有效位计算：
  );

   parameter [N-1:0]DIVIDENT = {(N){1'b1}};
   /*
   总共需要pipline极数为：
   (N-M_ACTIVE_MIN)+1: 解释第一次计算时，被除数（N）取出M_ACTIVE_MIN位参与运算，剩下的(N-M_ACTIVE_MIN)位每次只能一位加入运算。
   */

   reg [M-1:0] remainder_reg[SERIES-1:0];
   reg [M-1:0] divisor_reg[SERIES-1:0];
   reg [N-M_ACTIVE_MIN:0] merchant_reg[SERIES-1:0];

   //第一级pipline
   always @(posedge clk or negedge rstn) begin
      if (!rstn) 
      begin
         remainder_reg[0]     <= 'b0;
         divisor_reg[0]       <= 'b0;
         merchant_reg[0]      <= 'b0;
      end
      else begin
         divisor_reg[0]       <= divisor;

         if ({3'b000, DIVIDENT[N-1:N-M_ACTIVE_MIN]} >= {1'b0, divisor}) 
         begin
            merchant_reg[0]    <= ({(N-M_ACTIVE_MIN){1'b0}}<<1) + 1'b1 ;
            remainder_reg[0]   <= {3'b000, DIVIDENT[N-1:N-M_ACTIVE_MIN]} - {1'b0, divisor} ;

         end
         else
         begin
            merchant_reg[0]    <= ({(N-M_ACTIVE_MIN){1'b0}}<<1);
            remainder_reg[0]   <= {2'b00, DIVIDENT[N-1:N-M_ACTIVE_MIN]};     //4bits
         end
      end
   end //第一级pipline结束

   //第二级pipline
   always @(posedge clk or negedge rstn) begin
      if (!rstn) 
      begin
         remainder_reg[1]     <= 'b0;
         divisor_reg[1]       <= 'b0;
         merchant_reg[1]      <= 'b0;
      end
      else begin
         divisor_reg[1]       <= divisor_reg[0];

         if ({remainder_reg[0], DIVIDENT[N-M_ACTIVE_MIN-1]} >= {1'b0, divisor_reg[0]})
         begin
            merchant_reg[1]    <= ({merchant_reg[0]<<1) + 1'b1;
            remainder_reg[1]   <= {remainder_reg[0], DIVIDENT[N-M_ACTIVE_MIN-1]} - {1'b0, divisor};
         end
         else
         begin
            merchant_reg[1]    <= ({merchant_reg[0]<<1);
            remainder_reg[1]   <= {remainder_reg[0], DIVIDENT[N-M_ACTIVE_MIN-1]};
         end
      end
   end // always @ (posedge clk or negedge rstn)

endmodule
