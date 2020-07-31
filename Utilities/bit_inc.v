module bit_inc
(
  input  [5-1 : 0] inp,
  output [7-1 : 0] out
);
  reg [7-1 : 0] x;
  integer i;
  always @ ( * ) begin
    if(inp[5-1] == 1'b0) begin
      x = {2'b00, inp};
    end
    else begin
      x = {2'b11, inp};
    end
  end
  assign out = x;
endmodule
