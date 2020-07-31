`include "bit_inc.v"
module BitIncTest;
  reg  [5-1 : 0] inp;
  wire [7-1 : 0] out;

  bit_inc BitIncTestModule(
    .inp(inp),
    .out(out)
  );

  initial begin
    $dumpvars(0, BitIncTest);
    inp = 5'b11001;
    #10;
    $display("%b", out);

    inp = 5'b01001;
    #10;
    $display("%b", out);
    $finish;
  end
endmodule
