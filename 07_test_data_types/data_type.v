module data_type(input [31:0]     data1);
reg [7:0]      byte1 [3:0];
integer j;
always@*
begin
    for (j=0; j<=3;j=j+1) begin
        byte1[j] = data1[j*8+7-: 8];
    end
end
endmodule
