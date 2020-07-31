`include "T_to_S.v"
module TtoSTest;
  reg  [7-1 : 0] inp;
  wire [8-1 : 0] out;

  T_to_S TtoSTestModule
  (
    .inp(inp),
    .out(out)
  );
  initial begin
    $dumpvars(0, TtoSTest);
    inp = 7'b1101100;
    #10;
    $display("%b", out);

    inp = 7'b1111000;
    #10;
    $display("%b", out);

    inp = 7'b0101010;
    #10;
    $display("%b", out);

    inp = 7'b0010101;
    #10;
    $display("%b", out);
    $finish;
  end
endmodule
