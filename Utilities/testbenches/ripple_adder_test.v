`include "ripple_adder.v"
module RippleAdder;
  reg [6:0] X;
  reg [6:0] Y;
  wire [6:0] S;
  wire C_out;

  ripple_adder RippleAdderTestModule(
    .X(X),
    .Y(Y),
    .S(S),
    .C_out(C_out)
  );

  initial begin
    X = 7'b1010101;
    Y = 7'b0001101;
    #10;
    $display("%b", S);
    $finish;
  end
endmodule
