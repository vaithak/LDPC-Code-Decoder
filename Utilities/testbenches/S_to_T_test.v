`include "S_to_T.v"
module StoTTest;
  reg  [5-1 : 0] inp;
  wire [5-1 : 0] out;
  S_to_T S_to_T_test(
    .inp(inp),
    .out(out)
  );
  initial begin
    $dumpvars(0, StoTTest);
    inp = 5'b10010;
    #10;
    $display("%b", out);

    inp = 5'b10101;
    #10;
    $display("%b", out);

    inp = 5'b11010;
    #10;
    $display("%b", out);

    inp = 5'b00100;
    #10;
    $display("%b", out);
    $finish;
  end
endmodule
