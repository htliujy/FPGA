/* Generated by Yosys 0.9 (git sha1 UNKNOWN, clang 12.0.0 -fPIC -Os) */

(* top =  1  *)
(* src = "data_type.v:1" *)
module data_type(data1);
  (* src = "data_type.v:1" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] \byte1[0] ;
  (* src = "data_type.v:1" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] \byte1[1] ;
  (* src = "data_type.v:1" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] \byte1[2] ;
  (* src = "data_type.v:1" *)
  (* unused_bits = "0 1 2 3 4 5 6 7" *)
  wire [7:0] \byte1[3] ;
  (* src = "data_type.v:2" *)
  input [31:0] data1;
  (* src = "data_type.v:8" *)
  wire [31:0] j;
  assign \byte1[0]  = data1[7:0];
  assign \byte1[1]  = data1[15:8];
  assign \byte1[2]  = data1[23:16];
  assign \byte1[3]  = data1[31:24];
  assign j = 32'd4;
endmodule
