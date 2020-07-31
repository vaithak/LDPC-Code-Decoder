// Convert number from Two's complement to Signed format

module T_to_S
(
  input wire  [7-1 : 0] inp,
  // 'out' will have one extra bit than 'inp'
  output wire [8-1 : 0] out
);
  reg [8-1 : 0] x;
  reg [7-1 : 0] temp;
  always @ ( * ) begin
    if(inp[7-1] == 1'b1) begin
      temp = ~inp + 1;
      x    = {1'b1, temp};
    end
    else begin
      x = {1'b0, inp};
    end
  end
  assign out = x;
endmodule
