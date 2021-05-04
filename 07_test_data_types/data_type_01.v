module data_type_01(
    input [31:0]     data1
);

reg [3:0]      byte1 [7:0]; //这是错误的定义方式

integer j;
//generate
    always@* begin   //'*'代表一直？逻辑电路？
        for (j=0; j<=3;j=j+1) begin    //判断语句应该是：'j<=3'而不是'j<=31'?
            byte1[j] = data1[(j+1)*8-1 : j*8]; 
            //把data1[7:0]…data1[31:24]依次赋值给byte1[0][7:0]…byte[3][7:0]
        end
    end
//endgenerate
endmodule

