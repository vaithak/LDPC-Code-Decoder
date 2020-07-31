module ripple_adder(
  input [6:0] X,
  input [6:0] Y,
  output [6:0] S,
  output C_out
);
  wire [7:0] x;
  assign x = X + Y;
  assign S = x[6:0];
  assign C_out = x[7];
endmodule
