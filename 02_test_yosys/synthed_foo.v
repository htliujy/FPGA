/* Generated by Yosys 0.9 (git sha1 UNKNOWN, clang 12.0.0 -fPIC -Os) */

(* top =  1  *)
(* src = "foo.v:1" *)
module foo(a, b, c, o);
  (* src = "foo.v:8" *)
  wire _0_;
  (* src = "foo.v:2" *)
  input a;
  (* src = "foo.v:3" *)
  input b;
  (* src = "foo.v:4" *)
  input c;
  (* src = "foo.v:5" *)
  output o;
  assign _0_ = a &(* src = "foo.v:8" *)  b;
  assign o = _0_ |(* src = "foo.v:8" *)  c;
endmodule
