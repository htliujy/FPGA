`timescale 1ns/1ns

module digital_tube_tb;
    reg clk;
    reg rstn;
    reg en;
    reg [3:0]       single_digit;
    reg [3:0]       ten_digit;
    reg [3:0]       hundred_digit;
    reg [3:0]       kilo_digit;

    wire [3:0]  csn;
    wire  a,b,c,d,e,f,g;

    always begin
        #5 ;     clk = 0;
        #5 ;     clk = 1;
    end

    initial begin
        rstn = 0;
        #10 rstn = 1;
    end

    initial begin
        en = 0;
        #18 en = 1;
    end

    initial begin
        single_digit = 2;
        ten_digit= 4 ;
        hundred_digit= 5;
        kilo_digit = 0;
    end

    digital_tube digital_tube_instan(
        //input
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .single_digit(single_digit),
        .ten_digit(ten_digit),
        .hundred_digit(hundred_digit),
        .kilo_digit(kilo_digit),
        //output
        .csn(csn), //chip select, low-available, 对应控制电路的DIG1, DIG2, DIG3, DIG4.
        .abcdefg({a,b,c,d,e,f,g})        //light control, 对应控制电路的阴极引线LED_A, LED_B...LED_G.
    );

    initial begin
        forever begin
            #100;
            if ($time >= 1000)  $finish ;
        end
    end

    initial begin
        $dumpfile("digital_tube.vcd");
        $dumpvars(0);
    end

endmodule
