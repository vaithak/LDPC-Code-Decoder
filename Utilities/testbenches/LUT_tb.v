`include "LUT.v"
module LUTTest;
  reg [7-1 : 0] X;
  wire [4-1 : 0] Y;

  LUT test_module
  (
    .X(X),
    .Y(Y)
  );

  integer i;
  initial begin
    $dumpvars(0, LUTTest);

    for(i = 0; i < (1 << 7); i = i + 1) begin
      X = i;
      #10;
      $display("%b %b", X, Y);
    end
    $finish;
  end
endmodule
